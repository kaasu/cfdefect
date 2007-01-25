<cfcomponent output="false" displayname="AnnouncementService" hint="" extends="cfdefect.com.cfdefect.service.AbstractService">

<cffunction name="init" returntype="cfdefect.com.cfdefect.service.AnnouncementService" output="false" access="public" hint="Constructor">
	<cfargument name="tableName" type="string" required="true" hint="" />
	<cfreturn super.init( argumentCollection=arguments ) />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
	<cfreturn getAll() />
</cffunction>

<cffunction name="getSupportingData" returntype="struct" access="public" output="false" hint="">
	<cfset var supportingData =  StructNew() />
	<cfset supportingData['projects'] = getProjectService().getAll() />
	<cfreturn supportingData />
</cffunction>

<cffunction name="getAnnouncementForUser" returntype="query" access="public" output="false" hint="">
	<cfargument name="user_id" type="string" required="true" hint="" />
	<cfreturn getReactorFactory().createGateway( getTableName() ).getAnnouncementForUser( argumentCollection=arguments ) />
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getProjectService" access="public" returntype="cfdefect.com.cfdefect.service.Projectservice" output="false" hint="Getter for ProjectService">
	<cfreturn variables.instance.ProjectService />
</cffunction>

<cffunction name="setProjectService" access="public" returntype="void" output="false" hint="Setter for ProjectService">
	<cfargument name="ProjectService" type="cfdefect.com.cfdefect.service.Projectservice" required="true" />
	<cfset variables.instance.ProjectService = arguments.ProjectService>
</cffunction>
</cfcomponent>