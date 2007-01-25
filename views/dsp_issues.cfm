<cfsilent>
<cfset supportingData = event.getValue( 'supportingData' )>
<cfset issue_type_selected = event.getValue( 'issue_type_selected', '') />
<cfset locus_selected = event.getValue( 'loci_selected', '') />
<cfset severity_selected = event.getValue( 'loci_selected', '') />
<cfset status_selected = event.getValue( 'loci_selected', '') />
<cfset user_selected = event.getValue( 'loci_selected', '') />
<cfset keyword = event.getValue( 'keyword', '') />
<cfset columns = ListToArray( event.getValue( 'columns' ),  '~' ) />
<cfimport taglib="/cfdefect/customtags" prefix="ui" />
</cfsilent>
<cfoutput>
<form name="filterIssueForm" id="filterIssueForm" method="post" action="#myself##myfusebox.originalCircuit#.#myfusebox.originalFuseaction#">
<fieldset>
	<legend>Filter Issues</legend>
	<select name="issue_type_selected" class="filter">
		<option value="-1">All Issue Types</option>
		<cfloop query="supportingData.issuetypes">
			<option value="#id#">#name#</option>
		</cfloop>
	</select>
	
	<select name="locus_selected" class="filter">
		<option value="-1">All Loci</option>
		<cfloop query="supportingData.projectloci">
			<option value="#id#">#name#</option>
		</cfloop>
	</select>
	<select name="severity_selected" class="filter">
		<option value="-1">All Severities</option>
		<cfloop query="supportingData.severities">
			<option value="#id#">#name#</option>
		</cfloop>
	</select>
	<select name="status_selected" class="filter">
		<option value="-1">All Statuses</option>	
		<cfloop query="supportingData.statuses">
			<option value="#id#">#name#</option>
		</cfloop>
	</select>
	<select name="user_selected" class="filter">
		<option value="-1">All Users</option>
		<cfloop query="supportingData.users">
			<option value="#id#">#name#</option>
		</cfloop>
	</select>
	<input name="keyword" type="text" id="keyword" value="#keyword#" />
	<input type="hidden" name="projectidfk" value="#event.getValue( 'projectidfk' )#">
	<input type="button" name="Filter" value="Keyword Search" class="button filter" />
	<!--- <input type="button" name="reset" value="Reset" class="button reset" /> --->
</fieldset>
</form>
<br />
<ui:dspDataTable myself="#myself#" xfa="#xfa#" type="issue" udf="#event.getValue( 'UDF' )#" headers="#columns#" />
</cfoutput>