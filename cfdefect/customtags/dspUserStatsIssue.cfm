<cfif thisTag.ExecutionMode eq 'start'>
	<cfparam name="attributes.data"  type="query" />
	<cfparam name="attributes.title"  type="string" />
	<cfparam name="attributes.link"  type="string" />
	<cfoutput>
	<dl class="table-display">
		<cfloop query="attributes.data">
			<dt>#attributes.title#:</dt>
			<dd><a href="#attributes.link#&projectidfk=#URLEncodedFormat( projectidfk )#&id=#URLEncodedFormat( id )#">#publicid#) #issue_name#</a>
				<br />
				#DateFormat( created, 'medium' )# #TimeFormat( created, 'short' )#
			</dd>
		</cfloop>
	</dl>
	</cfoutput>
</cfif>

