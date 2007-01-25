<cfcomponent output="false" displayname="ProjectService" hint="" extends="cfdefect.com.cfdefect.service.AbstractService">

<cffunction name="init" returntype="cfdefect.com.cfdefect.service.ProjectService" output="false" access="public" hint="Constructor">
	<cfargument name="tableName" type="string" required="true" hint="" />
	<cfreturn super.init( argumentCollection=arguments ) />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
	<cfreturn getReactorFactory().createGateway( getTableName() ).getAllProjectsWithIssues() />
</cffunction>

<cffunction name="getSupportingData" returntype="struct" access="public" output="false" hint="">
	<cfset var supportingData =  StructNew() />
	<cfset supportingData['users'] = getUserService().getAll() />
	<cfset supportingData['projectloci'] = getProjectLocusService().getAll() />
	<cfreturn supportingData />
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getProjectLocusService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for ProjectLocusService">
	<cfreturn variables.instance.ProjectLocusService />
</cffunction>

<cffunction name="setProjectLocusService" access="public" returntype="void" output="false" hint="Setter for ProjectLocusService">
	<cfargument name="ProjectLocusService" type="cfdefect.com.cfdefect.service.AbstractService" required="true" />
	<cfset variables.instance.ProjectLocusService = arguments.ProjectLocusService>
</cffunction>

<cffunction name="getUserService" access="private" returntype="cfdefect.com.cfdefect.service.UserService" output="false" hint="Getter for UserService">
	<cfreturn variables.instance.UserService />
</cffunction>

<cffunction name="setUserService" access="public" returntype="void" output="false" hint="Setter for UserService">
	<cfargument name="UserService" type="cfdefect.com.cfdefect.service.UserService" required="true" />
	<cfset variables.instance.UserService = arguments.UserService>
</cffunction>

</cfcomponent>