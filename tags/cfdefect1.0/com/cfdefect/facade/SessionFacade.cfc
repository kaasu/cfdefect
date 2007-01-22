<cfcomponent output="false" displayname="SessionFacade" hint="" extends="BaseFacade">

<cffunction name="init" returntype="SessionFacade" output="false" access="public" hint="Constructor">
	<cfargument name="scopename" type="string" required="true" hint="" />
	<cfreturn super.init( argumentCollection=arguments ) />
</cffunction>

<cffunction name="put" access="public" returntype="void" output="false" hint="I set a value in the scope.">
	<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
	<cfargument name="value" type="any" required="true" hint="I am the value.">	
	<cflock scope="session" type="exclusive" timeout="5">
		<cfset super.put( arguments.key, arguments.value, false ) />
	</cflock>
</cffunction>

<cffunction name="get" access="public" returntype="any" output="false" hint="I get a value from the scope or the default or an empty string.">
	<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
	<cflock scope="session" type="readonly" timeout="2">
		<cfreturn super.get( key ) />
	</cflock>
</cffunction>
	
<cffunction name="remove" access="public" returntype="void" output="false" hint="I remove a value from the scope.">
	<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
	<cflock scope="session" type="exclusive" timeout="5">
		<cfset super.remove( arguments.key, false ) />
	</cflock>
</cffunction>

<cffunction name="exists" access="public" returntype="boolean" output="false" hint="I state if a value exists.">
	<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
	<cflock scope="session" type="readonly" timeout="5">
		<cfreturn super.exists( arguments.key, false ) />
	</cflock>
</cffunction>
		
<!--- PUBLIC METHODS --->

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
</cfcomponent>