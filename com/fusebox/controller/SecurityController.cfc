<cfcomponent output="false" displayname="SecurityController" hint="" extends="AbstractController">

<cffunction name="init" returntype="SecurityController" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="OnRequestStart" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'user', getBean( 'SecurityService' ).getUser() ) />
	<cfset arguments.event.setValue( 'isLoggedIn', getBean( 'SecurityService' ).isLoggedIn() ) />
</cffunction>

<cffunction name="logout" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset getBean( 'SecurityService' ).logout() />
</cffunction>

<cffunction name="validateUser" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'isValid', getBean( 'SecurityService' ).validateUser( 	event.getValue( 'username' ), 
																							event.getValue( 'password' ) ) ) />
	<cfif NOT arguments.event.getValue( 'isValid' )>
		<cfset arguments.event.setValue( 'message', 'Login Failed. Please try again.' )>
	</cfif>
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->

</cfcomponent>