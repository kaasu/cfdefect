<cfsilent>
<cfset qProject = event.getValue( 'qProject' )/>
</cfsilent>
<cfoutput>
<div class="lighterBox">
	<div class="left">
		<fieldset>
			<legend>RSS Feeds</legend>
			<ul id="rsslist">
				<li><a href="#event.getValue( 'myself' )##xfa.rss#">All Projects</a></li>
				<li><a href="#event.getValue( 'myself' )##xfa.rss#&projectidfk=-1">All Projects (My Issues)</a></li>
				<cfloop query="qProject">
					<li><a href="#event.getValue( 'myself' )##xfa.rss#&projectidfk=#URLEncodedFormat( id )#">#name#</a></li>
				</cfloop>
			</ul>
		</fieldset>
	</div>
	<div class="right">
		<div class="darkerBox help">
			<h4>Help</h4>
			<p>The follow links correspond to various RSS feeds for each of the projects you are assigned to. You can also subscribe to a link for all your projects or to a feed of just your issues..</p>
		</div>
	</div>
	<div class="clear"></div>
</div>
</cfoutput>
