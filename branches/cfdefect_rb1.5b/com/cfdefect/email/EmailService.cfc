<cfcomponent output="false" displayname="EmailService" hint="">

<cffunction name="init" returntype="cfdefect.com.cfdefect.email.EmailService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->

<!--- PACKAGE METHODS --->
<cffunction name="createEmail" returntype="Email" access="public" output="false" hint="I return an instance of Email">
	<cfset var email = CreateObject( 'component', 'Email' ).init( this ) />
	<cfset email.setFrom( getApplicationConfiguration().getConfig( 'mailDefaultFrom' ) ) />
	<cfreturn email />
</cffunction>


<cffunction name="send" returntype="void" access="public" output="false" hint="">
	<cfargument name="email" type="Email" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset local.server = getConfig( 'mailServer' ) />
	<cfset local.port = getConfig( 'mailPort' ) /> 
	<cfset local.headers = arguments.email.getHeaders() />

	<cfmail 
	   to = "#arguments.email.getTO()#"
	   from = "#arguments.email.getFrom()#"
	   cc = "#arguments.email.getCC()#"
	   subject = "#arguments.email.getSubject()#"
	   server = "#local.server#"
	   port = "#local.port#">
<cfmailpart type="text">
#getConfig( 'AppTitle' )# Notification
========================================================================
#arguments.email.getTextMessage().trim()#
</cfmailpart>
<cfmailpart type="html">
#formatHTMLMessage( arguments.email.getHTMLMessage().trim() )#
</cfmailpart>		   
		<cfloop from="1" to="#ArrayLen( local.headers )#" index="i"><cfmailparam name="#local.headers[i].name#" value="#local.headers[i].value#" /></cfloop>
	</cfmail>
</cffunction>


<!--- PRIVATE METHODS --->
<cffunction name="formatHTMLMessage" returntype="string" access="private" output="false" hint="">
	<cfargument name="message" type="string" required="true" hint="" />
	<cfset var ret = '' />
	<cfoutput>
	<cfsavecontent variable="ret">
<html>
<head>
<title>#getConfig( 'AppTitle' )# Notification</title>
<style type="text/css">
<cfinclude template="#getConfig( 'mailCSS' )#" />	
</style>
</head>
<body>
	<div id="header">
    	<h1 class="headerTitle">#getConfig( 'AppTitle' )# Notification</h1>
	</div>
#arguments.message#
</body>
</html>
	</cfsavecontent>
	</cfoutput>	
	<cfreturn ret.trim() />
</cffunction> 


<cffunction name="getConfig" returntype="string" access="private" output="false" hint="">
	<cfargument name="key" type="string" required="true" hint="" />
	<cfargument name="defaultValue" type="string" default="" hint="" />
	<cfreturn getApplicationConfiguration().getConfig( argumentCollection=arguments ) />
</cffunction>


<!--- GETTER & SETTER --->
<cffunction name="getApplicationConfiguration" access="private" returntype="cfdefect.com.cfdefect.core.ApplicationConfiguration" output="false" hint="Getter for ApplicationConfiguration">
	<cfreturn variables.instance.ApplicationConfiguration />
</cffunction>

<cffunction name="setApplicationConfiguration" access="public" returntype="void" output="false" hint="Setter for ApplicationConfiguration">
	<cfargument name="ApplicationConfiguration" type="cfdefect.com.cfdefect.core.ApplicationConfiguration" required="true" />
	<cfset variables.instance.ApplicationConfiguration = arguments.ApplicationConfiguration>
</cffunction>

</cfcomponent>