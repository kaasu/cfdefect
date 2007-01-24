<cfif thisTag.ExecutionMode eq 'start'>
	<cfparam name="attributes.errors" type="array" />
	<cfoutput>
	<cfset errors = attributes.errors />	
	<div class="lighterBox">
		<p>Please correct following errors!</p>
		<ul>
			<cfloop from="1" to="#ArrayLen( errors )#" index="i">
				<li>#errors[i]#</li>
			</cfloop>
		</ul>
	</div>
	</cfoutput>
</cfif>