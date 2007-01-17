<cfset reportData = event.getValue( 'reportData', '' ) />
<cfoutput>
<br />
<div class="lighterBox">
<cfif IsSimpleValue( reportData ) AND Len( Trim( reportData ) )>
<br />	
#reportData#
<cfelseif IsStruct( reportData ) AND StructCount( reportData )>
	<table width="100%">
		<tr>
			<td>#reportData['issue_types']#</td>
			<td>#reportData['statuses']#</td>
			<td>#reportData['severities']#</td>
		</tr>
		<tr>
			<td colspan="2">#reportData['loci']#</td>
			<td>#reportData['users']#</td>
		</tr>
	</table>
</cfif>	
<!--- 	
	
<cfif Len( reportContent )>#reportContent#</cfif>	
<cfif IsStruct( reportCharts ) AND StructCount( reportCharts )>
	
</cfif> --->
<br />
</div>
</cfoutput>

