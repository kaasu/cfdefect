<cfcomponent output="false" displayname="SeverityService" hint="">

<cffunction name="init" returntype="SeverityService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getSeverity" returntype="reactor.base.AbstractTO" access="public" output="false" hint="">
	<cfargument name="id" type="uuid" required="false" hint="" />
	
</cffunction>

<cffunction name="validateAndSave" returntype="date" access="public" output="false" hint="">
	<cfargument name="id" type="uuid" required="true" hint="" />
	<cfargument name="name" type="string" required="true" hint="" />
	<cfargument name="rank" type="numeric" required="true" hint="" />
	
</cffunction>


<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getReactorFactory" access="private" returntype="reactor.ReactorFactory" output="false" hint="Getter for ReactorFactory">
	<cfreturn variables.instance.ReactorFactory />
</cffunction>

<cffunction name="setReactorFactory" access="public" returntype="void" output="false" hint="Setter for ReactorFactory">
	<cfargument name="ReactorFactory" type="reactor.ReactorFactory" required="true" />
	<cfset variables.instance.ReactorFactory = arguments.ReactorFactory>
</cffunction>
</cfcomponent>