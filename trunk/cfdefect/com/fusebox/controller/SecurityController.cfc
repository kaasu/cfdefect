<cfcomponent output="false" displayname="SecurityController" hint="">

<cffunction name="init" returntype="SecurityController" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="OnRequestStart" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="fusebox5.FuseboxEvent" required="true" hint="" />
	<cfset arguments.event.setValue( getSecurityService().getUser() ) />
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getSecurityService" access="public" returntype="cfdefect.com.cfdefect.SecurityService" output="false" hint="Getter for SecurityService">
	<cfreturn variables.instance.SecurityService />
</cffunction>

<cffunction name="setSecurityService" access="public" returntype="void" output="false" hint="Setter for SecurityService">
	<cfargument name="SecurityService" type="cfdefect.com.cfdefect.SecurityService" required="true" />
	<cfset variables.instance.SecurityService = arguments.SecurityService>
</cffunction>
</cfcomponent>