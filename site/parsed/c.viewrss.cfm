<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: c --->
<!--- fuseaction: viewrss --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "c">
<cfset myFusebox.thisFuseaction = "viewrss">
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
<cfset Controller.generateRSS( event ) >
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

