
<cfcomponent hint="I am the database agnostic custom TO object for the users object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.To.usersTo">
	<!--- Place custom code here, it will not be overwritten --->
	<cfproperty name="UserProjects" type="string" />
	<cfproperty name="UserProjectEmails" type="string" />
	<cfproperty name="Admin" type="boolean" />
	<cfproperty name="NewPassword" type="string" />
	<cfproperty name="OldPassword" type="string" />
	
	<cfset this.UserProjects = "" />
	<cfset this.UserProjectEmails = "" />
	<cfset this.Admin = false />
	<cfset this.NewPassword = "" />
	<cfset this.OldPassword = "" />
	
</cfcomponent>
	
