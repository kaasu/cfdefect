
<cfcomponent hint="I am the database agnostic custom TO object for the application object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.To.applicationTo">
	<!--- Place custom code here, it will not be overwritten --->
	
	<cfproperty name="ID" type="string" />
	<cfset this.ID = "0" />
	
</cfcomponent>
	
