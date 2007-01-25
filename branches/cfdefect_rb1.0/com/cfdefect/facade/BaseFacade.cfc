<cfcomponent displayname="BaseFacade" hint="I am a facade used to access a specific scope.">
	
	<cffunction name="init" access="public" returntype="BaseFacade" hint="I configure and return the facade." output="false">
		<cfargument name="scopename" type="string" required="true" hint="" />
		<cfset var oScopes = getPageContext().getBuiltinScopes()>
		<cfset setScopeName( arguments.scopename ) />
		<cfset setScope( oScopes[getScopeName()] ) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getAll" access="public" returntype="struct" output="false" hint="I get all values.">
		<cfreturn getScope() />
	</cffunction>

	<cffunction name="put" access="public" returntype="void" output="false" hint="I set a value in the scope.">
		<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
		<cfargument name="value" type="any" required="true" hint="I am the value.">
		<cfargument name="useLock" type="boolean" default="true" hint="" />
		<cfif arguments.useLock>
			<cflock name="#getScopeName()#_lock" type="exclusive" timeout="5">
				<cfset getScope().put( arguments.key, arguments.value ) />
			</cflock>
		<cfelse>
			<cfset getScope().put( arguments.key, arguments.value ) />
		</cfif>
	</cffunction>
	
	<cffunction name="get" access="public" returntype="any" output="false" hint="I get a value from the scope or the default or an empty string.">
		<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
		<cfif exists( arguments.key )>
			<cfreturn getScope().get( arguments.key ) />
		</cfif>
		<cfreturn '' />
	</cffunction>
	
	<!--- <cffunction name="get" access="public" returntype="any" output="false" hint="I get a value from the scope or the default or an empty string.">
		<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
		<cfargument name="default" required="false" type="any" hint="I am a default value to set and return if the value does not exist." />
		<cfif exists( arguments.name )>
			<cfreturn getScope().get( arguments.key ) />
		<cfelseif structKeyExists( arguments, 'default' )>
			<cfset put(arguments.name, arguments.default) />
			<cfreturn arguments.default />
		<cfelse>
			<cfreturn '' />
		</cfif>
	</cffunction> --->

	<cffunction name="remove" access="public" returntype="void" output="false" hint="I remove a value from the scope.">
		<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
		<cfargument name="useLock" type="boolean" default="true" hint="" />
		<cfif arguments.useLock>
			<cflock name="#getScopeName()#_lock" type="exclusive" timeout="5">
				<cfset structDelete( getScope(), arguments.key, false ) />
			</cflock>
		<cfelse>
			<cfset structDelete( getScope(), arguments.key, false ) />
		</cfif>
	</cffunction>

	<cffunction name="exists" access="public" returntype="boolean" output="false" hint="I state if a value exists.">
		<cfargument name="key" type="string" required="true" hint="I am the name of the value.">
		<cfreturn structKeyExists( getScope(), arguments.key ) />
	</cffunction>
	
	<!--- getter & setters --->
	<cffunction name="getScope" access="private" returntype="struct" output="false" hint="Getter for Scope">
		<cfreturn variables._Scope />
	</cffunction>
	
	<cffunction name="setScope" access="private" returntype="void" output="false" hint="Setter for Scope">
		<cfargument name="Scope" type="struct" required="true" />
		<cfset variables._Scope = arguments.Scope>
	</cffunction>
	
	<cffunction name="getScopeName" access="public" returntype="string" output="false" hint="Getter for ScopeName">
		<cfreturn variables._ScopeName />
	</cffunction>
	
	<cffunction name="setScopeName" access="public" returntype="void" output="false" hint="Setter for ScopeName">
		<cfargument name="ScopeName" type="string" required="true" />
		<cfset variables._ScopeName= arguments.ScopeName>
	</cffunction>
	
</cfcomponent>