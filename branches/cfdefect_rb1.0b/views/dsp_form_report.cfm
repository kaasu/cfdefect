<cfsilent>
<cfparam name="content.result" default="" type="string" />	
<cfset qProject = event.getValue( 'qProject' )/>
<cfset projectidfk = event.getValue( 'projectidfk', '' )/>
<cfset option = event.getValue( 'option', 'html' )/>
</cfsilent>
<style>

</style>
<cfoutput>
	<table  class="reportform">
		<tr>
			<td width="65%" valign="top">

				<form name="reportForm" id="reportForm" method="post" action="#myself##xfa.report#" class="data">
					<fieldset>
						<label for="projectidfk">Project: </label>
						<select name="projectidfk" id="projectidfk">
							<option value="" <cfif projectidfk eq ''>selected</cfif>>All Projects</option>
							<option value="-1" <cfif projectidfk eq -1>selected</cfif>>All Projects (My Issues)</option>
							<cfloop query="qProject">
								<option value="#id#" <cfif projectidfk eq id>selected</cfif>>#name#</option>
							</cfloop>
						</select><br />
						
						<label for="option">Options: </label>
						<input type="radio" name="option" id="option" value="chart" class="radio" <cfif option eq 'chart'>checked</cfif> />Chart
						<input type="radio" name="option" id="option" value="html" class="radio"  <cfif option eq 'html'>checked</cfif> />HTML
						<input type="radio" name="option" id="option" value="excel" class="radio"  <cfif option eq 'excel'>checked</cfif> />Excel
						<input type="radio" name="option" id="option" value="pdf" class="radio" disabled/>PDF
						<br />
						
						<label for="kludge"></label>
						<input type="submit" value="View" name="submit" class="button" /> <br />
					</fieldset>
				</form>

			</td>
			<td valign="top">
				<div class="darkerBox help">
					<h4>Help</h4>
					<p>Select one or more projects to generate reports. You can view the report chart or generate issue report in HTML + Excel Format. PDF and CSV are currently in progress.</p>
				</div>
			</td>
		</tr>
	</table>
</cfoutput>
