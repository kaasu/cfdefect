<cfcomponent output="false" displayname="IssueService" hint="" extends="cfdefect.com.cfdefect.service.AbstractService">

<cffunction name="init" returntype="cfdefect.com.cfdefect.service.IssueService" output="false" access="public" hint="Constructor">
	<cfargument name="tableName" type="string" required="true" hint="" />
	<cfreturn super.init( argumentCollection=arguments ) />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getSupportingData" returntype="struct" access="public" output="false" hint="">
	<cfset var supportingData =  StructNew() />
	<cfset supportingData['projectloci'] = getProjectLocusService().getAll() />
	<cfset supportingData['severities'] = getSeverityService().getAll() />
	<cfset supportingData['statuses'] = getStatusService().getAll() />
	<cfset supportingData['users'] = getUserService().getAll() />
	<cfset supportingData['issuetypes'] = getIssueTypeService().getAll() />
	<cfreturn supportingData />
</cffunction>

<cffunction name="formatIssuesForProject" returntype="string" access="public" output="false" hint="">
	<cfargument name="projectidfk" type="string" required="true" hint="" />
	<cfargument name="editlink" type="string" required="true" hint="" />
	<cfargument name="issue_type_selected" type="string" default="" hint="" />
	<cfargument name="locus_selected" type="string" default="" hint="" />
	<cfargument name="severity_selected" type="string" default="" hint="" />
	<cfargument name="status_selected" type="string" default="" hint="" />
	<cfargument name="user_selected" type="string" default="" hint="" />
	<cfargument name="keyword" type="string" default="" hint="" />
	<!--- <cfargument name="myself" type="string" required="true" hint="" /> --->
	<cfset var issues = getIssueForProject( argumentCollection=arguments ) />
	<cfset var csv = CreateObject( 'java', 'java.lang.StringBuffer') />
	<cfif NOT issues.recordcount>
		<cfset csv.append( '<tr>' ) />
		<cfset csv.append( '<td colspan="10">No record(s) found</td>' ) >
		<cfset csv.append( '</tr>' ) />
	<cfelse>
		<cfloop query="issues">
			<cfset csv.append( '<tr>' ) />
			<cfset csv.append( '<td><input type="checkbox" name="chkid" value="' & id &  '">&nbsp;</td>' )>
			<cfset csv.append( '<td>' & publicid & '</td>' )>
			<cfset csv.append( '<td><a href="' & arguments.editlink & '&id=' & URLEncodedFormat( id ) & '">' & name & '</a></td>' )>
			<cfset csv.append( '<td>' & type & '</td>' )>
			<cfset csv.append( '<td>' & locus & '</td>' )>
			<cfset csv.append( '<td>' & severity & '</td>' )>
			<cfset csv.append( '<td>' & status & '</td>' )>
			<cfset csv.append( '<td>' & owner & '</td>' )>
			<cfif Trim( due_date ) neq ''>
				<cfset csv.append( '<td>' & DateFormat( due_date, 'mm/dd/yyyy' ) & '</td>' )>
			<cfelse>
				<cfset csv.append( '<td>&nbsp;</td>' )>
			</cfif>
			<cfset csv.append( '<td>' & DateFormat( updated, 'mm/dd/yyyy' ) & '</td>' )>
			<cfset csv.append( '</tr>' ) />
		</cfloop>
	</cfif>
	<cfreturn csv.toString() />
</cffunction>

<cffunction name="getIssueForProject" returntype="query" access="public" output="false" hint="">
	<cfargument name="projectidfk" type="uuid" required="true" hint="" />
	<cfargument name="issue_type_selected" type="string" default="" hint="" />
	<cfargument name="locus_selected" type="string" default="" hint="" />
	<cfargument name="severity_selected" type="string" default="" hint="" />
	<cfargument name="status_selected" type="string" default="" hint="" />
	<cfargument name="user_selected" type="string" default="" hint="" />
	<cfargument name="keyword" type="string" default="" hint="" />
	<cfreturn getReactorFactory().createGateway( getTableName() ).getIssuesForProject( argumentCollection=arguments ) />
</cffunction>

<cffunction name="getRecord" returntype="reactor.base.AbstractRecord" access="public" output="false" hint="">
	<cfargument name="id" type="string" default="0" hint="" />
	<cfargument name="projectidfk" type="uuid" required="true" hint="" />
	<cfset var record = getReactorFactory().createRecord( getTableName() ) />
	<!--- for  new record set the creator and owner as logged in user. --->
	<cfif arguments.id eq 0>
		<cfset record.setCreatorIDFK( getSecurityService().getUser().getID() ) />
		<cfset record.setUserIDFK( getSecurityService().getUser().getID() ) />
	</cfif>
	<cfset record.load( id=arguments.id, projectidfk=arguments.projectidfk ) />
	<cfreturn record />
</cffunction>

<cffunction name="validateAndProcess" returntype="reactor.base.AbstractRecord" access="public" output="false" hint="">
	<cfargument name="data" type="struct" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset var record = getReactorFactory().createRecord( getTableName() ).init( argumentCollection=arguments.data ) />	
	<cfset record.validate() />
	
	<cfif NOT record._getErrorCollection().hasErrors()>
		<cfset local.formFacade = CreateObject( 'component', 'cfdefect.com.cfdefect.facade.BaseFacade' ).init( 'form' )>
		<cfif local.formFacade.exists( arguments.data['newattachment_field'] ) AND len( local.formFacade.get( arguments.data['newattachment_field'] ) )>
			<cfif Len( record.getAttachment() )>
				<cfset deleteAttachment( record.getAttachment() ) />
			</cfif>
			
			<cfset local.attachmentData = getFileService().upload( arguments.data['newattachment_field'] ) />
				
			<cfif StructCount( local.attachmentData ) AND StructKeyExists( local.attachmentData, 'fileWasSaved' ) AND local.attachmentData.fileWasSaved>
				<cfset record.setAttachment( local.attachmentData.serverfile ) />
			</cfif>
		<!--- delete old attachment if delete checkbox is checked. --->	
		<cfelseif StructKeyExists( arguments.data, 'deleteAttachment' )>
			<cfset getFileService().delete( record.getAttachment() ) />
			<cfset record.setAttachment( '' ) />
		</cfif>
		<cfset record.save( getSecurityService().getUser() ) />
	</cfif>
	<cfreturn record />
</cffunction>

<cffunction name="getIssuesForProjectUser" returntype="query" access="public" output="false" hint="">
	<cfargument name="projectidfk" type="string" required="false" hint="" />
	<cfargument name="useridfk" type="string" required="false" hint="" />
	<cfreturn getReactorFactory().createGateway( getTableName() ).getIssuesForProjectUser( argumentCollection=arguments ) />	
</cffunction>

<cffunction name="deleteAttachment" returntype="void" access="public" output="false" hint="">
	<cfargument name="attachment" type="string" required="true" hint="" />
	<cfset getFileService().delete( record.getAttachment() ) />
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getFileService" access="public" returntype="cfdefect.com.cfdefect.core.FileService" output="false" hint="Getter for FileService">
	<cfreturn variables.instance.FileService />
</cffunction>

<cffunction name="setFileService" access="public" returntype="void" output="false" hint="Setter for FileService">
	<cfargument name="FileService" type="cfdefect.com.cfdefect.core.FileService" required="true" />
	<cfset variables.instance.FileService = arguments.FileService>
</cffunction>

<cffunction name="getIssueTypeService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for IssueTypeService">
	<cfreturn variables.instance.IssueTypeService />
</cffunction>

<cffunction name="setIssueTypeService" access="public" returntype="void" output="false" hint="Setter for IssueTypeService">
	<cfargument name="IssueTypeService" type="cfdefect.com.cfdefect.service.GenericService" required="true" />
	<cfset variables.instance.IssueTypeService = arguments.IssueTypeService>
</cffunction>

<cffunction name="getSecurityService" access="private" returntype="cfdefect.com.cfdefect.core.SecurityService" output="false" hint="Getter for SecurityService">
	<cfreturn variables.instance.SecurityService />
</cffunction>

<cffunction name="setSecurityService" access="public" returntype="void" output="false" hint="Setter for SecurityService">
	<cfargument name="SecurityService" type="cfdefect.com.cfdefect.core.SecurityService" required="true" />
	<cfset variables.instance.SecurityService = arguments.SecurityService>
</cffunction>

<cffunction name="getProjectLocusService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for ProjectLocusService">
	<cfreturn variables.instance.ProjectLocusService />
</cffunction>

<cffunction name="setProjectLocusService" access="public" returntype="void" output="false" hint="Setter for ProjectLocusService">
	<cfargument name="ProjectLocusService" type="cfdefect.com.cfdefect.service.AbstractService" required="true" />
	<cfset variables.instance.ProjectLocusService = arguments.ProjectLocusService>
</cffunction>

<cffunction name="getSeverityService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for SeverityService">
	<cfreturn variables.instance.SeverityService />
</cffunction>

<cffunction name="setSeverityService" access="public" returntype="void" output="false" hint="Setter for SeverityService">
	<cfargument name="SeverityService" type="cfdefect.com.cfdefect.service.AbstractService" required="true" />
	<cfset variables.instance.SeverityService = arguments.SeverityService>
</cffunction>

<cffunction name="getStatusService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for StatusService">
	<cfreturn variables.instance.StatusService />
</cffunction>

<cffunction name="setStatusService" access="public" returntype="void" output="false" hint="Setter for StatusService">
	<cfargument name="StatusService" type="cfdefect.com.cfdefect.service.GenericService" required="true" />
	<cfset variables.instance.StatusService = arguments.StatusService>
</cffunction>

<cffunction name="getUserService" access="private" returntype="cfdefect.com.cfdefect.service.UserService" output="false" hint="Getter for UserService">
	<cfreturn variables.instance.UserService />
</cffunction>

<cffunction name="setUserService" access="public" returntype="void" output="false" hint="Setter for UserService">
	<cfargument name="UserService" type="cfdefect.com.cfdefect.service.UserService" required="true" />
	<cfset variables.instance.UserService = arguments.UserService>
</cffunction>


</cfcomponent>