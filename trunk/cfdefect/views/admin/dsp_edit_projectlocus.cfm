<cfset record = event.getValue( 'recordObject' ) />
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
						help="Use the form below to edit a project loci. Project Loci are simply bug/issue locations.">
		<label for="name">Name: </label>
		<input type="text" id="name" name="name" tabindex="1" value="#record.getName().trim()#" title="name"><br>				
</ui:dspGenericEditForm>
</cfoutput>