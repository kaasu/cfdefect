<cfsilent>
<cfset xmlData = event.getValue( 'xmlData') />
<cfsetting showdebugoutput="false" />
</cfsilent>
<cfcontent reset="true" type="text/xml"><cfoutput>#xmlData.trim()#</cfoutput>