<cfsilent>	
	<!--- using #hash( getCurrentTemplatePath() )# makes this application name unique to this application --->
	<cfset myAppName = hash( getCurrentTemplatePath() ) & 'cfdefect_mssql'/>
	<cfapplication 	name="#myAppName#"
					applicationtimeout="#createTimeSpan( 3, 1, 0, 0 )#"
					sessionmanagement="true"
					sessiontimeout="#createTimeSpan( 0, 1, 10, 0 )#">		
					
<cfparam name="url['fusebox.load']" default="true" />	
<cfparam name="url['fusebox.password']" default="cfdefect" />
</cfsilent>