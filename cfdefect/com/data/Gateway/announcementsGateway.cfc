
<cfcomponent hint="I am the database agnostic custom Gateway object for the announcements object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.announcementsGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	<cffunction name="getAll" returntype="query" access="public" output="false" hint="">
		<cfargument name="order" type="string" default="posted" hint="" />
		<cfargument name="sort" type="string" default="desc" hint="" />
		<cfset var qAll =  "" />
 		<cfquery name="qAll" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT	*
			FROM	cd_announcements
			ORDER BY	#arguments.order# #arguments.sort#
		</cfquery>
		<cfreturn qAll />
	</cffunction>
	
	<cffunction name="getAnnouncementForUser" returntype="query" access="public" output="false" hint="">
		<cfargument name="user_id" type="string" required="true" hint="" />
		<cfset var qAnnouncementForUser =  "" />
		<cfquery name="qAnnouncementForUser" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT 	a.title
	   				, a.body
	   				, p.name AS project_name
	   				, a.posted
	   				, u.name AS user_name
	   				, a.projectidfk
			FROM   	cd_announcements a
	   					INNER JOIN CD_projects p ON p.id = a.projectidfk
			  				INNER JOIN CD_users u ON u.id = a.useridfk
			WHERE	EXISTS ( 	SELECT 1
			   	 				FROM	CD_projects_users pu
				 				WHERE 	pu.projectidfk = p.id
				 						AND pu.useridfk = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_varchar" />
				 			)
			ORDER BY 	a.projectidfk
		</cfquery>
		<cfreturn qAnnouncementForUser />
	</cffunction>
</cfcomponent>
	
