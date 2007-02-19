
<cfcomponent hint="I am the database agnostic custom TO object for the issues object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.To.issuesTo">
	<!--- Place custom code here, it will not be overwritten --->
	
	<cfproperty name="ProjectName" type="string" />
	<cfproperty name="CreatorName" type="string" />
	<cfproperty name="PublicID" type="string" />
	
	<cfset this.ProjectName = "" />
	<cfset this.CreatorName = "" />
	<cfset this.PublicID = "0" />
	
</cfcomponent>
	
