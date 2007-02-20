
<cfcomponent hint="I am the database agnostic custom Gateway object for the project object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.projectGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getAllProjectsWithIssues" returntype="query" access="public" output="false" hint="">
		<cfargument name="applicationId" type="string" required="true" hint="" />
		<cfargument name="order" type="string" default="name" hint="" />
		<cfargument name="sort" type="string" default="asc" hint="" />
		<cfset var qAllProjectsWithIssues =  StructNew() />
 		<cfquery name="qAllProjectsWithIssues" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT 	p.id
	   				, p.name
	   				,	(	SELECT count(*)
	   						FROM   cd_issue i
							WHERE  i.projectidfk = p.id 
									AND i.applicationid = <cfqueryparam value="#arguments.applicationid#" cfsqltype="cf_sql_varchar" />
						) AS number_of_issues	   
			FROM   	cd_project p
			WHERE 	p.applicationid = <cfqueryparam value="#arguments.applicationid#" cfsqltype="cf_sql_varchar" />
			ORDER BY	#arguments.order# #arguments.sort#
		</cfquery> 
		<cfreturn qAllProjectsWithIssues />
	</cffunction>
	
</cfcomponent>
	
