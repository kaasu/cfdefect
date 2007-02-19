<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: admin --->
<!--- fuseaction: delete --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "admin">
<cfset myFusebox.thisFuseaction = "delete">
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
<cfset AdminController.delete( event ) >
<cflocation url="#myFusebox.getMyself()##xfa.list#" addtoken="false">
<cfabort>
<cfcatch><cfrethrow></cfcatch>
</cftry>
<cfsetting enablecfoutputonly="false" />

