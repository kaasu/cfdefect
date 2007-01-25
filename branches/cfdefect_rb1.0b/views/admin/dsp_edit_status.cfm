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
						id="#record.getID()#"	
						UDF="#event.getValue( 'UDF' )#"
						help="Use this form to edit/add status.">
		<label for="name">Name: </label>
		<input type="text" id="name" name="name" tabindex="1" value="#record.getName().trim()#" title="name"><br>
				
		<label for="rank">Rank: </label>
		<input type="text" id="rank" name="rank" tabindex="1" value="#record.getRank()#" title="rank" class="small"><br>			
</ui:dspGenericEditForm>
</cfoutput>