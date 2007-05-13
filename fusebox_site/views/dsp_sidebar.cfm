<cfset qUserProjects = event.getValue( 'qUserProjects' ) />
<cfoutput>
<cfif qUserProjects.recordcount>
	<p class="sideBarTitle">Your Projects</p>
	<ul>
		<cfloop query="qUserProjects">
			<li><a href="#event.getValue( 'myself' )##xfa.issues#&projectidfk=#URLEncodedFormat( id )#">#name#</a>&nbsp;<a href="#event.getValue( 'myself' )##xfa.addissue#&projectidfk=#URLEncodedFormat( id )#&type=issue&id=0">[+]</a></li>
		</cfloop>
	</ul>
</cfif>
<cfif event.getValue( 'user' ).getIsAdmin()>
	<p class="sideBarTitle">Adminitration</p>
	<ul>
		<li><a href="#event.getValue( 'myself' )##xfa.list#&type=announcement">Announcements</a></li>
		<li><a href="#event.getValue( 'myself' )##xfa.list#&type=issuetype">Issue Types</a></li>
		<li><a href="#event.getValue( 'myself' )##xfa.list#&type=project">Projects</a></li>
		<li><a href="#event.getValue( 'myself' )##xfa.list#&type=projectlocus">Project Loci</a></li>
		<li><a href="#event.getValue( 'myself' )##xfa.list#&type=severity">Severities</a></li>
		<li><a href="#event.getValue( 'myself' )##xfa.list#&type=status">Statuses</a></li>
		<li><a href="#event.getValue( 'myself' )##xfa.list#&type=user">Users</a></li>	
	</ul>
</cfif>	
<p class="sideBarTitle">Menu</p>
<ul>
	<li><a href="#event.getValue( 'myself' )##xfa.reports#">Reports</a></li>
	<li><a href="#event.getValue( 'myself' )##xfa.rss#">RSS Feeds</a></li>
</ul>
</cfoutput>