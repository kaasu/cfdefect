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
						help="Use the form below to edit a user. You may also assign a user to projects as well as manage their email subscription."	>
		<label for="username">Username: </label>
		<input type="text" id="username" name="username" tabindex="1" value="#record.getUsername().trim()#" title="username"><br>
		
		<label for="password">Password: </label>
		<input type="text" id="password" name="password" tabindex="1" value="#record.getPassword().trim()#" title="password"><br>
		
		<label for="emailaddress">Email: </label>
		<input type="text" id="emailaddress" name="emailaddress" tabindex="1" value="#record.getEmailaddress().trim()#" title="emailaddress"><br>
		
		<label for="name">Name: </label>
		<input type="text" id="name" name="name" tabindex="1" value="#record.getName().trim()#" title="name"><br>
		
		<label for="UserProjects">Projects: </label>
		<select name="UserProjects" multiple="true" size="3" id="UserProjects">
			<cfloop query="supportingData.projects">
				<option value="#id#" <cfif ListFindNoCase( record.getUserProjects(), id )>selected</cfif>>#name#</option>
			</cfloop>
		</select><br>
		
		<label for="UserProjectEmails">Email Projects: </label>
		<select name="UserProjectEmails" multiple="true" size="3" id="UserProjectEmails">
			<cfloop query="supportingData.projects">
				<option value="#id#" <cfif ListFindNoCase( record.getUserProjectEmails(), id )>selected</cfif>>#name#</option>
			</cfloop>
		</select><br>
		
		<label for="isadmin">Admin:</label>
		<input type="radio" name="isadmin" id="isadmin" value="1" class="radio" <cfif record.getIsAdmin()>checked</cfif> />Yes
		<input type="radio" name="isadmin" id="isadmin" value="0" class="radio" <cfif NOT record.getIsAdmin()>checked</cfif>/>No  <br />
</ui:dspGenericEditForm>
</cfoutput>