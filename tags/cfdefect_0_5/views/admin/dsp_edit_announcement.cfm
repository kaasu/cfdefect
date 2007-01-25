<cfset record = event.getValue( 'recordObject' ) />
<cfset supportingData = event.getValue( 'supportingData' ) />
<cfoutput>
<cfif record.validated() AND record.hasErrors()>
	<cfimport taglib="/cfdefect/customtags" prefix="ui" />
	<ui:dspError errors="#record._getErrorCollection().getTranslatedErrors()#" />
</cfif>
<ui:dspGenericEditForm 	myself= "#myself#"
						xfa="#xfa#" 
						type="#event.getValue( 'type' )#"
						UDF="#event.getValue( 'UDF' )#"
							help="Use this form to edit/add your announcement.">
		<label for="title">Title: </label>
		<input type="text" id="title" name="title" tabindex="1" value="#record.getTitle().trim()#" title="title"><br>
		
		<label for="body">Body: </label>
		<textarea name="body">#record.getBody().trim()#</textarea><br>
		
		<label for="projects">Projects: </label>
		<select name="projectidfk">
			<cfloop query="supportingData.projects">
				<option value="#id#" <cfif record.getProjectIDFK() eq id>selected</cfif>>#name#</option>
			</cfloop>
		</select><br>	
</ui:dspGenericEditForm>
</cfoutput>