<cfcomponent output="false" displayname="GenericService" hint="" extends="cfdefect.com.cfdefect.service.AbstractService">

<cffunction name="init" returntype="cfdefect.com.cfdefect.service.GenericService" output="false" access="public" hint="Constructor">
	<cfargument name="tableName" type="string" required="true" hint="" />
	<cfreturn super.init( argumentCollection=arguments ) />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
	<cfreturn getAll() />
</cffunction>
<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
</cfcomponent>