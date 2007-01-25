
<cfcomponent hint="I am the database agnostic custom TO object for the projects object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.To.projectsTo">
	<!--- Place custom code here, it will not be overwritten --->
	
	<cfproperty name="ProjectLociID" type="string" />
	<cfproperty name="ProjectUsersID" type="string" />
	
	<cfset this.ProjectLociID = "" />
	<cfset this.ProjectUsersID = "" />
	
</cfcomponent>
	
