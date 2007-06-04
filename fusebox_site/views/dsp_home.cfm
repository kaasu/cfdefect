<cfparam name="content.userStats" type="string" default="" />
<cfparam name="content.userAnnouncements" type="string" default="" />
<cfoutput>
<div id="home"> 
	<div class="left">
		<div class="lighterBox">
			<h1>Introduction</h1>
		    <p>
				Welcome to CF_DEFECT, a web based issue and bug tracking system developed by Qasim Rasheed (qasim@qasimrasheed.com).
			</p>
		</div>
		#content.userAnnouncements.trim()#
	</div>
	<div class="right">
		#content.userStats.trim()#
	</div>
	<div class="clear"></div>
</div> 
</cfoutput>	