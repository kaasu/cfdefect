<cfset failed = myFusebox.plugins[myFusebox.thisPlugin].parameters.failed />
<cfset skipFuseactions = failed & '~' & myFusebox.plugins[myFusebox.thisPlugin].parameters.skipFuseactions />
<cfif NOT event.getValue( 'isLoggedIn' ) AND NOT ListFindNoCase( skipFuseactions, myFusebox.OriginalCircuit & '.' & myFusebox.OriginalFuseaction,  '~' )>
	<cflocation url="#myself##failed#" addtoken="false" />
</cfif>