
<cfcomponent hint="I am the database agnostic custom Gateway object for the announcement object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.announcementGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="I return all announcements for this application.">
		<cfargument name="applicationid" type="string" required="true" hint="" />
		<cfargument name="order" type="string" default="posted" hint="" />
		<cfargument name="sort" type="string" default="desc" hint="" />
		<cfset var qAllRecords =  "" />
 		<cfquery name="qAllRecords" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT	*
			FROM	cd_announcement
			WHERE	applicationid = <cfqueryparam value="#arguments.applicationid#" cfsqltype="cf_sql_varchar" />
			ORDER BY	#arguments.order# #arguments.sort#
		</cfquery>
		<cfreturn qAllRecords />
	</cffunction>
	
	<cffunction name="getAnnouncementForUser" returntype="query" access="public" output="false" hint="I return all announcement for a user based on the project that he/she is assigned to.">
		<cfargument name="applicationid" type="string" required="true" hint="" />
		<cfargument name="userid" type="string" required="true" hint="" />
		<cfset var qAnnouncementForUser =  "" />
		<cfquery name="qAnnouncementForUser" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT 	a.title
	   				, a.body
	   				, p.name AS project_name
	   				, a.posted
	   				, u.name AS user_name
	   				, a.projectidfk
			FROM   	cd_announcement a
	   					INNER JOIN cd_project p ON p.id = a.projectidfk
	   						AND p.applicationid = <cfqueryparam value="#arguments.applicationid#" cfsqltype="cf_sql_varchar" />
			  					INNER JOIN cd_user u ON u.id = a.useridfk
			  						AND u.applicationid = <cfqueryparam value="#arguments.applicationid#" cfsqltype="cf_sql_varchar" />
			WHERE	a.applicationid = <cfqueryparam value="#arguments.applicationid#" cfsqltype="cf_sql_varchar" />
					AND EXISTS ( 	SELECT 1
			   	 					FROM	cd_project_user pu
				 					WHERE 	pu.projectidfk = p.id
				 							AND pu.useridfk = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_varchar" />
				 			)
			ORDER BY 	a.projectidfk
		</cfquery>
		<cfreturn qAnnouncementForUser />
	</cffunction>
	
</cfcomponent>
	
