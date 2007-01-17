<cfsilent>
	<cfset COLDSPRING_FACTORY_NAME = 'servicefactory' />
	
	<cfset FUSEBOX_APPLICATION_PATH = "\">
	<!--- myAppName is set in Application.cfm file --->
	<cfset FUSEBOX_APPLICATION_KEY = myAppName />
	
</cfsilent>
<cftry>
<cfinclude template="/fusebox5/fusebox5.cfm">
<cfcatch type="any">
	<cfdump var="#cfcatch#"><cfabort>
</cfcatch>
</cftry>
