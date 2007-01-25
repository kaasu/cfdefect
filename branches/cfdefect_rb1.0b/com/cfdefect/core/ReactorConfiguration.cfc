<cfcomponent output="false" displayname="ReactorConfiguration" hint="" extends="reactor.config.Config">

<cffunction name="init" returntype="ReactorConfiguration" output="false" access="public" hint="Constructor">
	<cfargument name="pathToConfigXml" type="string" required="true" hint="" />
	<cfreturn super.init( argumentCollection=arguments ) />
</cffunction>

<cffunction name="configure" returntype="void" access="public" output="false" hint="">
	<!--- <cfset setProject( getProject() & '_' & getType() )>
	<cfset setMapping( getMapping() & '/' & getType() ) />
	<cfdump var="#getMapping()#"><cfabort> --->
</cffunction>

<!--- PUBLIC METHODS --->

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
</cfcomponent>