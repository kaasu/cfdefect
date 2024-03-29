<!---
Copyright 2006 Qasim Rasheed (www.qasimrasheed.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->
<cfsilent>	
	<!--- using #hash( getCurrentTemplatePath() )# makes this application name unique to this application --->
	<cfset myAppName = hash( getCurrentTemplatePath() ) />
	<cfapplication 	name="#myAppName#"
					applicationtimeout="#CreateTimeSpan( 0, 1, 0, 0 )#"
					sessionmanagement="true"
					sessiontimeout="#CreateTimeSpan( 0, 0, 30, 0 )#">
					
	<cfif IsDefined("Cookie.CFID") AND IsDefined("Cookie.CFTOKEN")>
  		<cfset localCFID = Cookie.CFID>
  		<cfset localCFTOKEN = Cookie.CFTOKEN>
  		<cfcookie name="CFID" value="#localCFID#">
  		<cfcookie name="CFTOKEN" value="#localCFTOKEN#">
	</cfif>				
</cfsilent>