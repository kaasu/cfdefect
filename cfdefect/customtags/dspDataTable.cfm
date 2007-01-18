<cfsetting enablecfoutputonly="true" />
<cfswitch expression="#thisTag.ExecutionMode#">
	<cfcase value="start">
		<cfsilent>
		<cfparam name="attributes.myself" type="string" />
		<cfparam name="attributes.xfa" type="struct" />	
		<cfparam name="attributes.type" type="string" />
		<cfparam name="attributes.headers" type="array" />
		<cfparam name="attributes.UDF"  />
		<cfset myself = attributes.myself />
		<cfset xfa = attributes.xfa />
		<cfset type = attributes.type />
		<cfset headers = attributes.headers />
		<cfset UDF = attributes.UDF />
		</cfsilent>
		<cfoutput>
		<form id="#type#ListForm" name="#type#ListForm" method="post" action="#myself##xfa.delete#">
			<table border="1" width="100%" id="#type#Table" class="data">
				<caption>#UDF.capFirstTitle( type )#(s) <br />
				<p>Use the form below to select #type# to edit. You may also create or delete #type#.</p>
				</caption>
				<thead>
					<tr>
						<th width="2%">&nbsp;</th>
						<cfloop from="1" to="#ArrayLen( headers )#" index="i">
							<th>#UDF.capFirstTitle( Replace( headers[i], '_', ' ', 'All' ) )#</th>
						</cfloop>
					</tr>
				</thead>
				<tbody>
		</cfoutput>
	</cfcase>
	<cfcase value="end">
		<cfoutput>
				#thisTag.GeneratedContent#
				<cfset thisTag.GeneratedContent = '' />
				</tbody>
				<tfoot>
					<tr>
						<td colspan="#1 + ArrayLen( headers )#">[<a href="#myself##xfa.add#">Add #UDF.capFirstTitle( type )#</a>] | [<a href="##" class="delete" targetform="#type#ListForm">Delete Selected</a>]</td>
					</tr>
				</tfoot>
			</table>		
		</form>
		</cfoutput>
	</cfcase>
</cfswitch>
<cfsetting enablecfoutputonly="false" />
<!--- <cfif thisTag.ExecutionMode eq 'start'>
	<cfsilent>
	<cfparam name="attributes.myself" type="string" />
	<cfparam name="attributes.xfa" type="struct" />	
	<cfparam name="attributes.data" type="query" />
	<cfparam name="attributes.type" type="string" />
	<cfparam name="attributes.UDF"  />
	<cfparam name="attributes.columns" type="string" />
	<cfset myself = attributes.myself />
	<cfset xfa = attributes.xfa />
	<cfset data = attributes.data />
	<cfset type = attributes.type />
	<cfset UDF = attributes.UDF />
	<cfset columns = ListToArray( attributes.columns,  '~' ) />
	</cfsilent>
	<cfoutput>
		<form id="#type#ListForm" name="#type#ListForm" method="post" action="#myself##xfa.delete#&type=#type#">
			<table border="1" width="100%">
				<caption>#UDF.capFirstTitle( type )#(s)</caption>
				<thead>
					<tr>
						<th width="2%">&nbsp;</th>
						<cfloop from="1" to="#ArrayLen( columns )#" index="i">
							<th width="#DecimalFormat( ( 1 / ArrayLen( columns ) ) * 100 )#%">#UDF.capFirstTitle( columns[i] )#</th>
						</cfloop>
					</tr>
				</thead>
				<tbody>
					<cfloop query="data">
						<tr>
							<td><input type="checkbox" name="id" value="#id#" /></td>
							<cfloop from="1" to="#ArrayLen( columns )#" index="i">
								<td>
									<cfif i eq 1>
										<a href="#myself##xfa.edit#&id=#URLEncodedFormat( id )#&type=#type#">#UDF.format( data[columns[i]][currentrow] )#</a>	
									<cfelse>
										#UDF.format( data[columns[i]][currentrow] )#
									</cfif>
								</td>
							</cfloop>
						</tr>
					</cfloop>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="#1 + ArrayLen( columns )#">[<a href="#myself##xfa.add#&type=#type#">Add #UDF.capFirstTitle( type )#</a>] | [<a href="##" class="delete" targetform="#type#ListForm">Delete Selected</a>]</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</cfoutput> 
</cfif>
 --->