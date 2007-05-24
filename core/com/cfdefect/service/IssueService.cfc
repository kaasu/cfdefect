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
	<cfargument name="addlink" type="string" required="false" hint="" />
	<cfargument name="deletelink" type="string" required="false" hint="" />
	<cfargument name="issue_type_selected" type="string" default="" hint="" />
	<cfargument name="locus_selected" type="string" default="" hint="" />
	<cfargument name="severity_selected" type="string" default="" hint="" />
	<cfargument name="status_selected" type="string" default="" hint="" />
	<cfargument name="user_selected" type="string" default="" hint="" />
	<cfargument name="keyword" type="string" default="" hint="" />
	<cfset var issues = getIssueForProject( argumentCollection=arguments ) />
	<cfset var sb = CreateObject( 'java', 'java.lang.StringBuffer') />
	<cfset var columns = getColumns() />
	<cfset var i = '' />
	<cfset sb.append( '<form id="issueListForm" name="issueListForm" method="post" action="#arguments.deletelink#">' ) />
	<cfset sb.append( '<table border="1" width="100%" id="issueTable" class="data">' ) />
	<cfset sb.append( '<caption>Issues <br /><p>Use the form below to select an issue to edit. You may also create or delete an issue.</p></caption>' ) />
	<cfset sb.append( '<thead><tr><th width="2%">&nbsp;</th>' ) />
	<cfloop list="#columns#" index="i"  delimiters="~">
		<cfset sb.append( '<th>' & getUDF().capFirstTitle( Replace( i, '_', ' ', 'All' ) ) & '</th>' ) />
	</cfloop>
	<cfset sb.append( '</thead>' ) />
	<cfset sb.append( '<tbody>' ) />
	<cfif NOT issues.recordcount>
		<cfset sb.append( '<tr>' ) />
		<cfset sb.append( '<td colspan="#ListLen( columns, '~' ) + 1#">No record(s) found</td>' ) >
		<cfset sb.append( '</tr>' ) />
	<cfelse>
		<cfloop query="issues">
			<cfset sb.append( '<tr>' ) />
			<cfset sb.append( '<td><input type="checkbox" name="chkid" value="' & id &  '">&nbsp;</td>' )>
			<cfset sb.append( '<td>' & publicid & '</td>' )>
			<cfset sb.append( '<td><a href="' & arguments.editlink & '&id=' & URLEncodedFormat( id ) & '">' & name & '</a></td>' )>
			<cfset sb.append( '<td>' & type & '</td>' )>
			<cfset sb.append( '<td>' & locus & '</td>' )>
			<cfset sb.append( '<td>' & severity & '</td>' )>
			<cfset sb.append( '<td>' & status & '</td>' )>
			<cfset sb.append( '<td>' & owner & '</td>' )>
			<cfif Trim( due_date ) neq ''>
				<cfset sb.append( '<td>' & DateFormat( due_date, 'mm/dd/yyyy' ) & '</td>' )>
			<cfelse>
				<cfset sb.append( '<td>&nbsp;</td>' )>
			</cfif>
			<cfset sb.append( '<td>' & DateFormat( updated, 'mm/dd/yyyy' ) & '</td>' )>
			<cfset sb.append( '</tr>' ) />
		</cfloop>
	</cfif>
	<cfset sb.append( '</tbody>' ) />
	<cfset sb.append( '<tfoot><tr><td colspan="#ListLen( columns, '~' ) + 1#">[<a href="#arguments.addLink#">Add Issue</a>] [<a href="##" class="delete" targetform="issueListForm">Delete Selected</a>]</td></tr></tfoot>' ) />
	<cfset sb.append( '</table>' ) />
	<cfset sb.append( '</form>' ) />
	<cfreturn sb.toString() />
</cffunction>

<cffunction name="getIssueForProject" returntype="query" access="public" output="false" hint="">
	<cfargument name="projectidfk" type="uuid" required="true" hint="" />
	<cfargument name="issue_type_selected" type="string" default="" hint="" />
	<cfargument name="locus_selected" type="string" default="" hint="" />
	<cfargument name="severity_selected" type="string" default="" hint="" />
	<cfargument name="status_selected" type="string" default="" hint="" />
	<cfargument name="user_selected" type="string" default="" hint="" />
	<cfargument name="keyword" type="string" default="" hint="" />
	<cfset arguments['applicationid'] = getApplicationID() />
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
	<cfset record.load( applicationid = getApplicationID(),
						id = arguments.id, 
						projectidfk = arguments.projectidfk ) />
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
	<cfset arguments['applicationid'] = getApplicationID() />
	<cfreturn getReactorFactory().createGateway( getTableName() ).getIssuesForProjectUser( argumentCollection=arguments ) />	
</cffunction>

<cffunction name="deleteAttachment" returntype="void" access="public" output="false" hint="">
	<cfargument name="attachment" type="string" required="true" hint="" />
	<cfset getFileService().delete( arguments.attachment ) />
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

<cffunction name="getUDF" access="public" returntype="cfdefect.com.cfdefect.core.UDF" output="false" hint="Getter for UDF">
	<cfreturn variables.instance.UDF />
</cffunction>

<cffunction name="setUDF" access="public" returntype="void" output="false" hint="Setter for UDF">
	<cfargument name="UDF" type="cfdefect.com.cfdefect.core.UDF" required="true" />
	<cfset variables.instance.UDF = arguments.UDF>
</cffunction>

</cfcomponent>