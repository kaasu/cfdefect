<cfcomponent output="false" displayname="Email" hint="">

<cfset variables.instance.tO = "">
<cfset variables.instance.textmessage = "">
<cfset variables.instance.htmlmessage = "">
<cfset variables.instance.subject = "">
<cfset variables.instance.type = "">
<cfset variables.instance.from = "">
<cfset variables.instance.cc = "">
<cfset variables.instance.headers = ArrayNew(1) />

<cffunction name="init" returntype="Email" output="false" access="public" hint="Constructor">
	<cfargument name="EmailService" type="EmailService" required="true" hint="" />	
	<cfset setEmailService( arguments.EmailService ) />
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="send" returntype="void" access="public" output="false" hint="">
	<cfset getEmailService().send( this ) />
</cffunction>

<cffunction name="getInstance" returntype="struct" access="public" output="false" hint="">
	<cfreturn variables.instance />
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getTO" access="public" returntype="string" output="false" hint="Getter for TO">
	<cfreturn variables.instance.TO />
</cffunction>

<cffunction name="setTO" access="public" returntype="void" output="false" hint="Setter for TO">
	<cfargument name="TO" type="string" required="true" />
	<cfset variables.instance.TO = arguments.TO>
</cffunction>

<cffunction name="getSubject" access="public" returntype="string" output="false" hint="Getter for Subject">
	<cfreturn variables.instance.Subject />
</cffunction>

<cffunction name="setSubject" access="public" returntype="void" output="false" hint="Setter for Subject">
	<cfargument name="Subject" type="string" required="true" />
	<cfset variables.instance.Subject = arguments.Subject>
</cffunction>

<cffunction name="getFrom" access="public" returntype="string" output="false" hint="Getter for From">
	<cfreturn variables.instance.From />
</cffunction>

<cffunction name="setFrom" access="public" returntype="void" output="false" hint="Setter for From">
	<cfargument name="From" type="string" required="true" />
	<cfset variables.instance.From = arguments.From>
</cffunction>

<cffunction name="getTextMessage" access="public" returntype="string" output="false" hint="Getter for Message">
	<cfreturn variables.instance.TextMessage />
</cffunction>

<cffunction name="setTextMessage" access="public" returntype="void" output="false" hint="Setter for Message">
	<cfargument name="TextMessage" type="string" required="true" />
	<cfset variables.instance.TextMessage = arguments.TextMessage>
</cffunction>

<cffunction name="getHTMLMessage" access="public" returntype="string" output="false" hint="Getter for HTMLMessage">
	<cfreturn variables.instance.HTMLMessage />
</cffunction>

<cffunction name="setHTMLMessage" access="public" returntype="void" output="false" hint="Setter for HTMLMessage">
	<cfargument name="HTMLMessage" type="string" required="true" />
	<cfset variables.instance.HTMLMessage = arguments.HTMLMessage>
</cffunction>

<cffunction name="getType" access="public" returntype="string" output="false" hint="Getter for Type">
	<cfreturn variables.instance.Type />
</cffunction>

<cffunction name="setType" access="public" returntype="void" output="false" hint="Setter for Type">
	<cfargument name="Type" type="string" required="true" />
	<cfset variables.instance.Type = arguments.Type>
</cffunction>

<cffunction name="getCC" access="public" returntype="string" output="false" hint="Getter for CC">
	<cfreturn variables.instance.CC />
</cffunction>

<cffunction name="setCC" access="public" returntype="void" output="false" hint="Setter for CC">
	<cfargument name="CC" type="string" required="true" />
	<cfset variables.instance.CC = arguments.CC>
</cffunction>

<cffunction name="addHeader" returntype="void" access="public" output="false" hint="Sets the Headers property">
	<cfargument name="name" type="string" required="true" />
	<cfargument name="value" type="string" required="true" />
	<cfset ArrayAppend(variables.instance.headers, arguments ) />
</cffunction>

<cffunction name="getHeaders" returntype="array" access="public" output="false" hint="Gets the Headers property">
	<cfreturn variables.instance.Headers  />
</cffunction>

<cffunction name="getEmailService" access="private" returntype="EmailService" output="false" hint="Getter for EmailService">
	<cfreturn variables._EmailService />
</cffunction>

<cffunction name="setEmailService" access="private" returntype="void" output="false" hint="Setter for EmailService">
	<cfargument name="EmailService" type="EmailService" required="true" />
	<cfset variables._EmailService = arguments.EmailService>
</cffunction>
</cfcomponent>