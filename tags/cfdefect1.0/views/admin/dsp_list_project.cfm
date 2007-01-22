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
			<td colspan="#Arraylen( columns ) + 1#">No project(s) found.</td>
		</tr>
	<cfelse>
		<cfloop query="data">
			<tr>
				<td><input type="checkbox" name="id" value="#id#" /></td>
				<cfloop from="1" to="#ArrayLen( columns )#" index="i">
					<cfif columns[i] neq 'view_issues'>
						<td>
							<cfif i eq 1>
								<a href="#myself##xfa.edit#&id=#URLEncodedFormat( id )#">#UDF.format( data[columns[i]][currentrow] )#</a>	
							<cfelse>
								#UDF.format( data[columns[i]][currentrow] )#
							</cfif>
						</td>
					</cfif>
				</cfloop>
				<td><a href="#myself##xfa.issues#&projectidfk=#URLEncodedFormat( id )#">View Issues</a></td>
			</tr>
		</cfloop>
	</cfif>
	
</ui:dspDataTable>
</cfoutput>