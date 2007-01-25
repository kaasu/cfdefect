
<cfcomponent hint="I am the database agnostic custom Gateway object for the projects object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.projectsGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	<cffunction name="getAllProjectsWithIssues" returntype="query" access="public" output="false" hint="">
		<cfargument name="order" type="string" default="name" hint="" />
		<cfargument name="sort" type="string" default="asc" hint="" />
		<cfset var qAllProjectsWithIssues =  "" />
 		<cfquery name="qAllProjectsWithIssues" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT 	p.id
	   				, p.name
	   				,	(	SELECT count(*)
	   						FROM   cd_issues i
							WHERE  i.projectidfk = p.id 
						) AS number_of_issues	   
			FROM   cd_projects p
			ORDER BY	#arguments.order# #arguments.sort#
		</cfquery> 
		<cfreturn qAllProjectsWithIssues />
	</cffunction>
	
</cfcomponent>
	
