
<cfcomponent hint="I am the database agnostic custom Record object for the issues object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Record.issuesRecord" >
	<!--- Place custom code here, it will not be overwritten --->
	<cffunction name="init" access="public" hint="I configure and return this record object." output="false" returntype="any" _returntype="reactor.project.cfdefect.Record.issuesRecord">
		<cfargument name="ProjectName" type="string" required="true" hint="ProjectName" />
		<cfargument name="CreatorName" type="string" required="true" hint="CreatorName" />
		<cfargument name="AdditionalNotes" type="string" default="" hint="AdditionalNotes" />
		<cfset setProjectName( arguments.ProjectName ) />
		<cfset setCreatorName( arguments.CreatorName ) />
		<cfset setAdditionalNotes( arguments.AdditionalNotes ) />
		<cfreturn super.init( argumentCollection=arguments ) />
	</cffunction>
	
	<!--- save --->
	<cffunction name="save" access="public" hint="I save the record." output="false" returntype="void">
		<cfargument name="currentUser" type="reactor.base.AbstractRecord" required="true" hint="logged in user record object" />
		<cfargument name="useTransaction" hint="I indicate if this save should be executed within a transaction." required="no" type="any" _type="boolean" default="true" />
		<cftransaction>
			<cfif getID() eq 0>
				<cfset setHistory( 'Created by ' & makeHistoryDateString( arguments.currentUser ) ) />
			<cfelse>
				<cfset setHistory( getHistory() & chr(10) & 'Updated by ' & makeHistoryDateString( arguments.currentUser ) ) />
				<cfif getAdditionalNotes().trim().length() GT 0>
					<cfset setHistory( getHistory() & chr(10) & getAdditionalNotes().trim() & chr(10) ) />
				</cfif>
			</cfif>
			<cfset super.save( useTransaction=false ) />
		</cftransaction>
	</cffunction>	
	
	<!--- beforeSave --->
	<cffunction name="beforeSave" access="private" hint="I am code executed before saving the record." output="false" returntype="void">
		<cfset super.beforeSave() />
	
		<cfif getID() eq 0>
			<!--- generate id for new records --->
			<cfset setID( CreateUUID() ) />
			<cfset setCreated( Now() ) />
		</cfif>
		
		<!--- generate public id for new records --->
		<cfif getPublicID() eq 0>
			<cfset setPublicID( generatePublicID() ) />
		</cfif>	
		<cfset setUpdated( Now() ) />	
	</cffunction>
	
	<cffunction name="generatePublicID" returntype="string" access="private" output="false" hint="">
		<cfset var local =  StructNew() />
		<cfset local.gateway = _getReactorFactory().createGateway( _getAlias() ) />
		<cfset local.query = local.gateway.createQuery() />
		<cfset local.query.getWhere().isEqual( _getAlias(), 'projectidfk', getPRojectIDFK() ) />
		<cfset local.query.returnObjectFields( _getAlias(), 'publicid' ) />
		<cfset local.query.setFieldExpression( _getAlias(), 'publicid',  'MAX(publicid)', 'CF_SQL_INTEGER' ) />
		<cfreturn Val( local.gateway.getByQuery( local.query ).publicid ) + 1 />
	</cffunction>
	
	<cffunction name="makeHistoryDateString" access="private" returntype="string" output="false" hint="">
		<cfargument name="user" type="reactor.base.AbstractRecord" required="true" hint="logged in user record object" />
		<cfreturn arguments.user.getUserName() & ' (' & arguments.user.getName() & ' : ' & DateFormat( Now(), 'mm/dd/yyyy' ) & ' ' & TimeFormat( Now(), 'h:mm tt' ) & ')' & chr( 10 ) />
	</cffunction>

	<!--- afterLoad --->
	<cffunction name="afterLoad" access="private" hint="I am code executed after loading the record." output="false" returntype="void">
		<cfset super.afterLoad() />
		<cfset setCreatorName( getCreator().getName() ) />
		<cfset setProjectName( getProjects().getName() ) />
	</cffunction>
	
	<!--- getter & setters --->
	<cffunction name="getProjectName" access="public" returntype="string" output="false" hint="Getter for ProjectName">
		<cfreturn _getTO().ProjectName />
	</cffunction>
	
	<cffunction name="setProjectName" access="public" returntype="void" output="false" hint="Setter for ProjectName">
		<cfargument name="ProjectName" type="string" required="true" hint="ProjectName" />
		<cfset _getTO().ProjectName = arguments.ProjectName>
	</cffunction>
	
	<cffunction name="getCreatorName" access="public" returntype="string" output="false" hint="Getter for CreatorName">
		<cfreturn _getTO().CreatorName />
	</cffunction>
	
	<cffunction name="setCreatorName" access="public" returntype="void" output="false" hint="Setter for CreatorName">
		<cfargument name="CreatorName" type="string" required="true" hint="CreatorName" />
		<cfset _getTO().CreatorName = arguments.CreatorName>
	</cffunction>
	
	<cffunction name="getAdditionalNotes" access="public" returntype="string" output="false" hint="Getter for AdditionalNotes">
		<cfreturn _getTO().AdditionalNotes />
	</cffunction>
	
	<cffunction name="setAdditionalNotes" access="public" returntype="void" output="false" hint="Setter for AdditionalNotes">
		<cfargument name="AdditionalNotes" type="string" required="true" hint="AdditionalNotes" />
		<cfset _getTO().AdditionalNotes = arguments.AdditionalNotes>
	</cffunction>
	
	<cffunction name="getLocusName" access="public" returntype="string" output="false" hint="Getter for LocusName">
		<cfreturn getLocus().getName() />
	</cffunction>
	
	<cffunction name="getSeverityName" access="public" returntype="string" output="false" hint="Getter for SeverityName">
		<cfreturn getSeverity().getName() />
	</cffunction>
	
	<cffunction name="getStatusName" access="public" returntype="string" output="false" hint="Getter for StatusName">
		<cfreturn getStatus().getName() />
	</cffunction>
	
	<cffunction name="getIssueTypeName" access="public" returntype="string" output="false" hint="Getter for IssueTypeName">
		<cfif getIsBug()>
			<cfreturn 'Bug' />
		<cfelse>
			<cfreturn 'Enhancement' />
		</cfif>
	</cffunction>
	
	<cffunction name="getOwnerName" access="public" returntype="string" output="false" hint="Getter for StatusName">
		<cfreturn getOwner().getName() />
	</cffunction>
	
	<!--- <cffunction name="setLocusName" access="public" returntype="void" output="false" hint="Setter for LocusName">
		<cfargument name="LocusName" type="string" required="true" hint="LocusName" />
		<cfset _getTO().LocusName = arguments.LocusName>
	</cffunction> --->
	
</cfcomponent>
	
