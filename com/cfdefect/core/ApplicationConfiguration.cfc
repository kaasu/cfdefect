<cfcomponent output="false" displayname="ApplicationConfiguration" hint="">

<cffunction name="init" returntype="cfdefect.com.cfdefect.core.ApplicationConfiguration" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getConfig" returntype="string" access="public" output="false" hint="">
	<cfargument name="key" type="string" required="true" hint="" />
	<cfargument name="defaultValue" type="string" default="" hint="" />
	<cfif exists( arguments.key )>
		<cfreturn getConfigs().get( arguments.key ) />
	</cfif>
	<cfreturn arguments.defaultValue />
</cffunction>

<cffunction name="getVersion" returntype="string" access="public" output="false" hint="">
	<cfreturn '0.5' />
</cffunction>


<!--- PRIVATE METHODS --->
<cffunction name="exists" returntype="boolean" access="private" output="false" hint="">
	<cfargument name="key" type="string" required="true" hint="" />
	<cfreturn StructKeyExists( getConfigs(), arguments.key ) />
</cffunction>


<!--- GETTER & SETTER --->
<cffunction name="getConfigs" access="public" returntype="struct" output="false" hint="Getter for Config">
	<cfreturn variables.instance.Configs />
</cffunction>

<cffunction name="setConfigs" access="public" returntype="void" output="false" hint="Setter for Config">
	<cfargument name="Configs" type="struct" required="true" />
	<cfset variables.instance.Configs = arguments.Configs>
</cffunction>

</cfcomponent>