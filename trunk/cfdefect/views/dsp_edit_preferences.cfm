<cfset record = event.getValue( 'recordObject' ) />
<cfset qProjects = record.getProjectsIterator().getQuery() />
<cfoutput>
<cfif event.valueExists( 'saved' )>
Your preferences have been updated.	
</cfif>	
#event.getValue( 'message', '' )#
<cfif record.validated() AND record.hasErrors()>
	<cfimport taglib="/cfdefect/customtags" prefix="ui" />
	<ui:dspError errors="#record._getErrorCollection().getTranslatedErrors()#" />
</cfif>
<ui:dspGenericEditForm 	myself= "#myself#"
						xfa="#xfa#" 
						type="#event.getValue( 'type' )#"
						id="#record.getID()#"	
						UDF="#event.getValue( 'UDF' )#"
						help="Use the form below to update your preferences. Every project selected in the 'Email Projects' field will subscribe you to that project. You will then get an email every time an issue is created or updated.">
						
		<label for="name">Name: </label>
		<input type="text" id="name" name="name" tabindex="1" value="#record.getName().trim()#" title="name"><br>
		
		<label for="emailaddress">Email: </label>
		<input type="text" id="emailaddress" name="emailaddress" tabindex="1" value="#record.getEmailaddress().trim()#" title="emailaddress"><br>
		
		<label for="newpassword">New Password: </label>
		<input type="text" id="newpassword" name="newpassword" tabindex="1" value="#record.getNewPassword().trim()#" title="newpassword"><br>
		
		<label for="oldpassword">Confirm Password: </label>
		<input type="text" id="oldpassword" name="oldpassword" tabindex="1" value="#record.getOldPassword().trim()#" title="oldpassword"><br>
		
		<label for="UserProjectEmails">Email Projects: </label>
		<select name="UserProjectEmails" multiple="true" size="3" id="UserProjectEmails">
			<cfloop query="qProjects">
				<option value="#id#" <cfif ListFindNoCase( record.getUserProjectEmails(), id )>selected</cfif>>#name#</option>
			</cfloop>
		</select><br>
		<input type="hidden" name="fromPreference" value="true" />
		<input type="hidden" name="userProjects" value="#record.getUserProjects()#" />
		<input type="hidden" name="password" value="#record.getPassword().trim()#" />
		<input type="hidden" name="username" value="#record.getUsername().trim()#" />
		<input type="hidden" name="admin" value="#record.getAdmin()#" />

</ui:dspGenericEditForm>
</cfoutput>