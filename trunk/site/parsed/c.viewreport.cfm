<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: c --->
<!--- fuseaction: viewreport --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "c">
<cfset myFusebox.thisFuseaction = "viewreport">
<cfif myFusebox.applicationStart>
	<cfif not myFusebox.getApplication().applicationStarted>
		<cflock name="#application.ApplicationName#_fusebox_#FUSEBOX_APPLICATION_KEY#_appinit" type="exclusive" timeout="30">
			<cfif not myFusebox.getApplication().applicationStarted>
				<cfset myFusebox.getApplication().applicationStarted = true />
			</cfif>
		</cflock>
	</cfif>
</cfif>
<cfset myFusebox.plugins.Security.parameters.skipFuseactions = "c.doLogin" />
<cfset myFusebox.plugins.Security.parameters.failed = "c.login" />
<cfset myFusebox.thisPhase = "preProcess">
<cfset myFusebox.thisPlugin = "Security"/>
<cfoutput><cfinclude template="/cfdefect/com/fusebox/plugins/security.cfm"/></cfoutput>
<!--- fuseaction action="c.onRequestStart" --->
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfset Controller.generateReportOrChart( event ) >
<cfif event.getValue( 'skin' ) eq 'html'>
<!--- do action="reportform" --->
<cfset myFusebox.thisFuseaction = "reportform">
<cfsavecontent variable="content.pageContent">
<cfset xfa.report = "c.viewreport" />
<cfset Controller.getProjectForReport( event ) >
<cftry>
<cfoutput><cfinclude template="../views/dsp_form_report.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 19 and right(cfcatch.MissingFileName,19) is "dsp_form_report.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_form_report.cfm in circuit v which does not exist (from fuseaction c.reportform).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfsavecontent>
<cfset myFusebox.thisFuseaction = "viewreport">
</cfif>
<cftry>
<cfparam name="content.pageContent" default=""><cfsavecontent variable="content.pageContent"><cfoutput>#content.pageContent#<cfinclude template="../views/dsp_report.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 14 and right(cfcatch.MissingFileName,14) is "dsp_report.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_report.cfm in circuit v which does not exist (from fuseaction c.viewreport).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<!--- do action="layout" --->
<cfset myFusebox.thisFuseaction = "layout">
<cfif event.getValue( 'skin') eq 'html' AND event.getValue( 'isLoggedIn' )>
<cfset xfa.list = "admin.list" />
<cfset xfa.preferences = "c.preferences" />
<cfset xfa.reports = "c.reports" />
<cfset xfa.rss = "c.rss" />
<cfset xfa.issues = "c.issues" />
<cfset xfa.addissue = "c.editissue" />
<cfset Controller.getProjectForUser( event ) >
<cftry>
<cfsavecontent variable="content.sidebar"><cfoutput><cfinclude template="../views/dsp_sidebar.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 15 and right(cfcatch.MissingFileName,15) is "dsp_sidebar.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_sidebar.cfm in circuit v which does not exist (from fuseaction c.layout).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
<cftry>
<cfoutput><cfinclude template="../views/lay_#event.getValue( 'skin')#.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte len("lay_#event.getValue( 'skin')#.cfm") and right(cfcatch.MissingFileName,len("lay_#event.getValue( 'skin')#.cfm")) is "lay_#event.getValue( 'skin')#.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_#event.getValue( 'skin')#.cfm in circuit v which does not exist (from fuseaction c.layout).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfcatch><cfrethrow></cfcatch>
</cftry>
<cfsetting enablecfoutputonly="false" />

