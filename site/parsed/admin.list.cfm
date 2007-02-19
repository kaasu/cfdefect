<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: admin --->
<!--- fuseaction: list --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "admin">
<cfset myFusebox.thisFuseaction = "list">
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
<cfset AdminController = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="AdminController")/> 
<cfset xfa.list = "admin.list&type=#event.getValue( 'type' )#" />
<cfset xfa.add = "admin.edit&type=#event.getValue( 'type' )#&id=0" />
<cfset xfa.edit = "admin.edit&type=#event.getValue( 'type' )#" />
<cfset xfa.delete = "admin.delete&type=#event.getValue( 'type' )#" />
<cfset AdminController.getAllRecords( event ) >
<cfif event.getValue( 'type' ) eq 'project'>
<cfset xfa.issues = "c.issues" />
<cftry>
<cfsavecontent variable="content.pageContent"><cfoutput><cfinclude template="../views/admin/dsp_list_project.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 26 and right(cfcatch.MissingFileName,26) is "admin/dsp_list_project.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse admin/dsp_list_project.cfm in circuit v which does not exist (from fuseaction admin.list).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfelse>
<cftry>
<cfsavecontent variable="content.pageContent"><cfoutput><cfinclude template="../views/admin/dsp_list_generic.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 26 and right(cfcatch.MissingFileName,26) is "admin/dsp_list_generic.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse admin/dsp_list_generic.cfm in circuit v which does not exist (from fuseaction admin.list).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
<!--- do action="c.layout" --->
<cfset myFusebox.thisCircuit = "c">
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

