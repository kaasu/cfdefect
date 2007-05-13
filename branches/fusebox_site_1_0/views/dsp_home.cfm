<cfparam name="content.userStats" type="string" default="" />
<cfparam name="content.userAnnouncements" type="string" default="" />
<cfoutput>
<div id="home"> 
	<div class="left">
		<div class="lighterBox">
			<h1>Introduction</h1>
		    <p>
				Welcome to CF_DEFECT, a web based issue and bug tracking system developed by Qasim Rasheed (qasimrasheed@gmail.com).
			</p>
		</div>
		#content.userAnnouncements.trim()#
	</div>
	<div class="right">
		#content.userStats.trim()#
	</div>
	<div class="clear"></div>
</div> 
<!--- <div>
	<div>
		<div class="lighterBox">
			<h1>Introduction</h1>
		    <p>
				Welcome to CF_DEFECT, a web based issue and bug tracking system developed by Qasim Rasheed (qasimrasheed@gmail.com).
			</p>
		</div>
	</div>
	<div class="left">
		<cfif qAnnouncements.recordcount>
			<div class="darkerBox">
				<cfloop query="qAnnouncements">
					<h1>#title#</h1>
					<p>#body#</p>
				</cfloop>
			</div>
		</cfif>
	</div>
</div>	 --->
<!--- <table width="100%" border="1">
	<tr>	
		<td>
			<div class="lighterBox">
				<h1>Introduction</h1>
			    <p>
					Welcome to CF_DEFECT, a web based issue and bug tracking system developed by Qasim Rasheed (qasimrasheed@gmail.com).
				</p>
			</div>
		</td>
		<td rowspan="2">
			<div class="lighterBox">
				<h1 class="title">Project Stats</h1>
				<p>
					
				</p>
			</div>
		</td>
	</tr>	
	<tr>
		<td>
			<cfif qAnnouncements.recordcount>
				<div class="darkerBox">
					<cfloop query="qAnnouncements">
						<h1>#title#</h1>
						<p>#body#</p>
					</cfloop>
				</div>
			</cfif>
		</td>
	</tr>
</table> --->

<!--- <cfif StructCount( userProjectStats )>
	<div class="lighterBox">
		<h1 class="title">Project Stats</h1>
		<p>
			
		</p>
	</div>
</cfif> --->

</cfoutput>	