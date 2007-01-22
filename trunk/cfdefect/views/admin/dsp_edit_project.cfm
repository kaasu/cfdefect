<cfset record = event.getValue( 'recordObject' ) />
<cfset supportingData = event.getValue( 'supportingData' ) />
<cfoutput>
<cfif record.validated() AND record.hasErrors()>
	<cfimport taglib="/cfdefect/customtags" prefix="ui" />
	<ui:dspError errors="#record._getErrorCollection().getTranslatedErrors()#" />
</cfif>
<ui:dspGenericEditForm 	myself= "#myself#"
						xfa="#xfa#" 
						type="Project"
						UDF="#event.getValue( 'UDF' )#"
						help="Use the form below to edit your project. Loci refer to the areas of your project where issues may be located. Typical examples include 'Database, Front End, Administrator, Components.' Only selected users will be able to work with issues."	>
		<label for="name">Name: </label>
		<input type="text" id="name" name="name" tabindex="1" value="#record.getName().trim()#" title="name"><br>
		
		<label for="projectlociid">Project Loci: </label>
		<select name="projectlociid" multiple="true" size="6" id="projectlociid">
			<cfloop query="supportingData.projectloci">
				<option value="#id#" <cfif ListFindNoCase( record.getProjectLociID(), id, '~' )>selected</cfif>>#name#</option>
			</cfloop>
		</select><br>
		
		<label for="projectusersid">Users: </label>
		<select name="projectusersid" multiple="true" size="3" id="projectusersid">
			<cfloop query="supportingData.users">
				<option value="#id#" <cfif ListFindNoCase( record.getProjectUsersID(), id, '~' )>selected</cfif>>#name#</option>
			</cfloop>
		</select><br>
								
</ui:dspGenericEditForm>
</cfoutput>