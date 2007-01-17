<cfset record = event.getValue( 'recordObject' ) />
<cfset supportingData = event.getValue( 'supportingData' ) />
<cfoutput>
<cfif record.validated() AND record.hasErrors()>
	<cfimport taglib="/cfdefect/customtags" prefix="ui" />
	<ui:dspError errors="#record._getErrorCollection().getTranslatedErrors()#" />
</cfif>
<ui:dspGenericEditForm 	myself= "#myself#"
						xfa="#xfa#" 
						type="Issue"
						id="#record.getID()#"	
						UDF="#event.getValue( 'UDF' )#"
						formEnctype="multipart/form-data"
						help="Use this form to add/edit an issue.">
	<label for="name">Name: </label>
	<input type="text" id="name" name="name" tabindex="1" value="#record.getName().trim()#" title="name"><br>
	
	<label for="name">Project: </label> 
	<span>#record.getProjectName()#</span> <br />
	
	<label for="isBug">Type: </label>
	<select name="isBug" id="isBug">
		<option value="1">Bug</option>
		<option value="0">Enhancement</option>
	</select><br />
	
	<label for="locusidfk">Locus: </label>
	<select name="locusidfk" id="locusidfk">
		<cfloop query="supportingData.projectloci">
			<option value="#id#" <cfif record.getLocusIDFK() eq id>selected</cfif>>#name#</option>
		</cfloop>
	</select><br />
	
	<label for="severityidfk">Severity: </label>
	<select name="severityidfk" id="severityidfk">
		<cfloop query="supportingData.severities">
			<option value="#id#" <cfif record.getSeverityIDFK() eq id>selected</cfif>>#name#</option>
		</cfloop>
	</select><br />
	
	<label for="statusidfk">Status: </label>
	<select name="statusidfk" id="statusidfk">
		<cfloop query="supportingData.statuses">
			<option value="#id#" <cfif record.getStatusIDFK() eq id>selected</cfif>>#name#</option>
		</cfloop>
	</select><br />
	
	<label for="duedate">Due Date: </label>
	<input type="text" id="duedate" name="duedate" value="#record.getDueDate()#"><br />												
	
	<label for="relatedURL">Related URL: </label>
	<input type="text" id="relatedURL" name="relatedURL" value="#record.getRelatedURL()#"><br />
	
	<label for="attachement">Attachment: </label>
	<span><cfif record.getAttachment().trim().length() GT 0><a href="#event.getValue( 'ApplicationConfig' ).getConfig( 'attachmentPath' )#/#record.getAttachment()#" target="_blank">#record.getAttachment()#</a><cfelse>No attachment</cfif></span> <br />
	<label for="newattachment">&nbsp;</label>
	<input type="file" name="newattachment" id="newattachment" /> <br />
	
	
	<label for="useridfk">Owner: </label>
	<select name="useridfk" id="useridfk">
		<cfloop query="supportingData.users">
			<option value="#id#" <cfif record.getUserIDFK() eq id>selected</cfif>>#name#</option>
		</cfloop>
	</select><br />
	
	<label>Creator: </label> 
	<span>#record.getCreatorName()#</span> <br />
	
	<cfif record.getID() neq 0>
		<label>Created: </label> 
		<span>#DateFormat( record.getCreated(), 'mm/dd/yyyy' )# #TimeFormat( record.getCreated(), 'short' )#</span> <br />
		
		<label>Last Updated: </label> 
		<span>#DateFormat( record.getUpdated(), 'mm/dd/yyyy' )# #TimeFormat( record.getUpdated(), 'short' )#</span> <br />
	</cfif>
	
	<label for="description">Description:</label>
	<textarea name="description" id="description">#record.getDescription()#</textarea>
	
	<cfif record.getID() neq 0>
		<label for="history">history:</label>
		<textarea name="history" id="history" readonly="true">#record.getHistory()#</textarea>
	</cfif>
	
	<cfif record.getID() neq 0>
		<label for="additionalnotes">Add Notes:</label>
		<textarea name="additionalnotes" id="additionalnotes"></textarea>
	</cfif>
	<cfif record.getID() neq 0>
		<input type="hidden" name="created" value="#record.getCreated()#" />
	</cfif>
	<input type="hidden" name="newattachment_field" value="newattachment" />
	<input type="hidden" name="attachment" value="#record.getAttachment()#" />
	<input type="hidden" name="publicid" value="#record.getPublicID()#" />
	<input type="hidden" name="projectname" value="#record.getProjectName()#" />
	<input type="hidden" name="creatorname" value="#record.getCreatorName()#" />
	<input type="hidden" name="creatoridfk" value="#record.getCreatorIDFK()#" />
</ui:dspGenericEditForm>
</cfoutput>