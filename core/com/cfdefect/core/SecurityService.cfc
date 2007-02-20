<cfcomponent output="false" displayname="SecurityService" hint="">

<cffunction name="init" returntype="cfdefect.com.cfdefect.core.SecurityService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="isLoggedIn" returntype="boolean" access="public" output="false" hint="">
	<cfreturn getUser().getID().trim().length() GT 0 />
</cffunction>

<cffunction name="validateUser" returntype="boolean" access="public" output="false" hint="">
	<cfargument name="username" type="string" required="true" hint="" />
	<cfargument name="password" type="string" required="true" hint="" />
	<cfset var userRecord = getReactorFactory().createRecord( 'user' )>
	<cfset logout() />
	<cfset userRecord.load( applicationid=getApplicationConfiguration().getAppKey(),
							username=arguments.username.trim(), 
							password=arguments.password.trim() ) />
	<cfif userRecord.getID().trim().length() GT 0>
		<cfset getSessionFacade().put( 'user', userRecord ) />
		<cfreturn true />
	</cfif>
	<cfreturn false />
</cffunction>

<cffunction name="logout" returntype="void" access="public" output="false" hint="">
	<cfset paramUser( true ) />
</cffunction>

<cffunction name="getUser" returntype="reactor.base.AbstractRecord" access="public" output="false" hint="">
	<cfset paramUser() />
	<cfreturn getSessionFacade().get( 'user' ) />
</cffunction>


<!--- PRIVATE METHODS --->
<cffunction name="paramUser" returntype="void" access="private" output="false" hint="">
	<cfargument name="reset" type="boolean" default="false" hint="" />
	<cfset var user =  "" />
	<cfif arguments.reset>
		<cfset getSessionFacade().remove( 'user' ) />
	</cfif>
	<cfif not getSessionFacade().exists( 'user' )>
		<cfset user = getReactorFactory().createRecord( 'user' ) />
		<cfset getSessionFacade().put( 'user', user ) />
	</cfif>
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getSessionFacade" access="private" returntype="cfdefect.com.cfdefect.facade.SessionFacade" output="false" hint="Getter for SessionFacade">
	<cfreturn variables.instance.SessionFacade />
</cffunction>

<cffunction name="setSessionFacade" access="public" returntype="void" output="false" hint="Setter for SessionFacade">
	<cfargument name="SessionFacade" type="cfdefect.com.cfdefect.facade.SessionFacade" required="true" />
	<cfset variables.instance.SessionFacade = arguments.SessionFacade>
</cffunction>

<cffunction name="getReactorFactory" access="private" returntype="reactor.ReactorFactory" output="false" hint="Getter for ReactorFactory">
	<cfreturn variables.instance.ReactorFactory />
</cffunction>

<cffunction name="setReactorFactory" access="public" returntype="void" output="false" hint="Setter for ReactorFactory">
	<cfargument name="ReactorFactory" type="reactor.ReactorFactory" required="true" />
	<cfset variables.instance.ReactorFactory = arguments.ReactorFactory>
</cffunction>

<cffunction name="getApplicationConfiguration" access="private" returntype="cfdefect.com.cfdefect.config.ApplicationConfiguration" output="false" hint="Getter for ApplicationConfiguration">
	<cfreturn variables.instance.ApplicationConfiguration />
</cffunction>

<cffunction name="setApplicationConfiguration" access="public" returntype="void" output="false" hint="Setter for ApplicationConfiguration">
	<cfargument name="ApplicationConfiguration" type="cfdefect.com.cfdefect.config.ApplicationConfiguration" required="true" />
	<cfset variables.instance.ApplicationConfiguration = arguments.ApplicationConfiguration>
</cffunction>

</cfcomponent>