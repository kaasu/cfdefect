<cfset factory = myFusebox.plugins[myFusebox.thisPlugin].parameters.factory />
<cfset securitybean = myFusebox.plugins[myFusebox.thisPlugin].parameters.bean />
<cfset failed = myFusebox.plugins[myFusebox.thisPlugin].parameters.failed />
<cfset skipFuseactions = failed & '~' & myFusebox.plugins[myFusebox.thisPlugin].parameters.skipFuseactions />
<cfset appData = myFuseBox.getApplication().getApplicationData() />
<cfif StructKeyExists( appData, factory )>
	<cfset securityService = appData[factory].getBean( securitybean )>
	<cfif NOT securityService.isLoggedIn() AND NOT ListFindNoCase( skipFuseactions, myFusebox.OriginalCircuit & '.' & myFusebox.OriginalFuseaction,  '~' )>
		<cflocation url="#myself##failed#" addtoken="false" />
	</cfif>
</cfif>