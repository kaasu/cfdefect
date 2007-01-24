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