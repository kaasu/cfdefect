<cfset userProjectStats = event.getValue( 'userProjectStats', StructNew() )>
<cfset user = event.getValue( 'user' )>
<cfimport taglib="/cfdefect/customtags" prefix="ui" />
<cfoutput>
<div class="lighterBox">
	<h1 class="title">Project Stats</h1>
    <p>
	    Issues assigned to #user.getName()#
	    <div align="center">
			#userProjectStats.open# Open | #userProjectStats.total# Total
		</div>
		<br />
		<cfif userProjectStats.projects.recordcount>
			<table class="data">
				<tr>
					<th>Project</th>
					<th>Open Issues</th>
				</tr>
				<cfloop query="userProjectStats.projects">
					<tr>
						<td><a href="#event.getValue( 'myself' )##xfa.issues#&projectidfk=#URLEncodedFormat( projectidfk )#">#project#</td>
						<td>#numberOfOpenIssues#</td>
					</tr>
				</cfloop>
			</table>
		</cfif>
		<div>
			<cfif userProjectStats.newest.recordcount>
				<ui:dspUserStatsIssue data="#userProjectStats.newest#" title="Newest" link="#event.getValue( 'myself' )##xfa.issue#" />
			</cfif>
			<cfif userProjectStats.oldest.recordcount>
				<ui:dspUserStatsIssue data="#userProjectStats.oldest#" title="Oldest" link="#event.getValue( 'myself' )##xfa.issue#" />
			</cfif>
			<cfif userProjectStats.overdue.recordcount>
				<ui:dspUserStatsIssue data="#userProjectStats.overdue#" title="Overdue" link="#event.getValue( 'myself' )##xfa.issue#" />
			</cfif>
			<div class="clear"></div>
		</div>
	</p>
</div>
</cfoutput>