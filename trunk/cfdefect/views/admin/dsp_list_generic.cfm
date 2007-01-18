<cfsilent>
<cfset data = event.getValue( 'qAll' )>
<cfset udf = event.getValue( 'UDF' )>
<cfset type = event.getValue( 'type' ) />
<cfset columns = ListToArray( event.getValue( 'columns' ),  '~' ) />
<cfimport taglib="/cfdefect/customtags" prefix="ui" />
</cfsilent>
<cfoutput>
<ui:dspDataTable myself="#myself#" xfa="#xfa#" type="#type#" udf="#UDF#" headers="#columns#">
	<cfif NOT data.recordcount>
		<tr>
			<td colspan="#ArrayLen( columns ) + 1#">No #type#(s) found.</td>
		</tr>
	<cfelse>
		<cfloop query="data">
			<tr>
				<td><input type="checkbox" name="chkid" value="#id#" /></td>
				<cfloop from="1" to="#ArrayLen( columns )#" index="i">
					<td>
						<cfif i eq 1>
							<a href="#myself##xfa.edit#&id=#URLEncodedFormat( id )#">#UDF.format( data[columns[i]][currentrow] )#</a>	
						<cfelse>
							#UDF.format( data[columns[i]][currentrow] )#
						</cfif>
					</td>
				</cfloop>
			</tr>
		</cfloop>
	</cfif>	
</ui:dspDataTable>
</cfoutput>