<cfset qAnnouncements = event.getValue( 'qAnnouncements', QueryNew( 'id' ) )>
<cfif qAnnouncements.recordcount>
<cfoutput>	
	<div class="lighterBox">
		<h1>Announcements</h1>
		<p>
			</cfoutput>	
			<cfoutput query="qAnnouncements" group="projectidfk">
				<h2 class="announcement">#project_name#</h2>
				<dl>
				<cfoutput>
					<dt>#title#</dt>
					<dd>#ParagraphFormat( body )#
						<br />
						#DateFormat( posted, 'medium' )# #TimeFormat( posted, 'short' )# - #user_name#
					</dd>
				</cfoutput>
				</dl>
			</cfoutput>
			<cfoutput>
		</p>
		
	</div>
</cfoutput>	
</cfif>
