
<cfcomponent hint="I am the database agnostic custom Gateway object for the issues object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.issuesGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getIssuesForProject" returntype="query" access="public" output="false" hint="">
		<cfargument name="projectidfk" type="string" required="true" hint="" />
		<cfargument name="issue_type_selected" type="string" default="" hint="" />
		<cfargument name="locus_selected" type="string" default="" hint="" />
		<cfargument name="severity_selected" type="string" default="" hint="" />
		<cfargument name="status_selected" type="string" default="" hint="" />
		<cfargument name="user_selected" type="string" default="" hint="" />
		<cfargument name="keyword" type="string" default="" hint="" />
		<cfset var qIssuesForProject =  StructNew() />
 		<cfquery name="qIssuesForProject.data" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#" result="qIssuesForProject.result">
			SELECT 	i.id
	   				,i.publicid
	   				,i.name
	   				, it.name AS type	  
	   				,pl.name AS locus
	   				,sev.name AS severity
	   				,s.name AS status
	   				,u.name AS owner
	   				,i.duedate AS due_date
	   				,i.updated
			FROM   	cd_issues i
	   	 				JOIN cd_projectloci pl ON pl.id = i.locusidfk
	   	 					<cfif Len( Trim( arguments.locus_selected ) ) AND arguments.locus_selected neq '-1'>
								AND 	pl.id = <cfqueryparam value="#arguments.locus_selected#" cfsqltype="cf_sql_varchar" />
							</cfif>
		 	  				JOIN  cd_severities sev on sev.id = i.severityidfk
		 	  					<cfif Len( Trim( arguments.severity_selected ) ) AND arguments.severity_selected neq '-1'>
									AND 	sev.id = <cfqueryparam value="#arguments.severity_selected#" cfsqltype="cf_sql_varchar" />
								</cfif>
			  					JOIN cd_statuses s ON s.id = i.statusidfk
			  						<cfif Len( Trim( arguments.status_selected ) ) AND arguments.status_selected neq '-1'>
										AND 	s.id = <cfqueryparam value="#arguments.status_selected#" cfsqltype="cf_sql_varchar" />
									</cfif>
						 			JOIN cd_users u ON u.id = i.useridfk
						 				<cfif Len( Trim( arguments.user_selected ) ) AND arguments.user_selected neq '-1'>
											AND 	u.id = <cfqueryparam value="#arguments.user_selected#" cfsqltype="cf_sql_varchar" />
										</cfif>
										JOIN cd_issuetypes it ON it.id = i.issuetypeidfk
										<cfif Len( Trim( arguments.issue_type_selected ) ) AND arguments.issue_type_selected neq '-1'>
											AND 	it.id = <cfqueryparam value="#arguments.issue_type_selected#" cfsqltype="cf_sql_varchar" />
										</cfif>
			WHERE 	i.projectidfk = <cfqueryparam value="#arguments.projectidfk#" cfsqltype="cf_sql_varchar" />
					<cfif Len( Trim( arguments.keyword ) )>
						AND ( 	
								UPPER( i.name ) LIKE <cfqueryparam value="%#UCase( arguments.keyword )#%" cfsqltype="cf_sql_varchar" />
								OR
								UPPER( i.description ) LIKE <cfqueryparam value="%#UCase( arguments.keyword )#%" cfsqltype="cf_sql_varchar" />
								)
					</cfif>
		</cfquery>
		<cfreturn qIssuesForProject.data />
	</cffunction>

	
	<!--- Report Queries --->
	<cffunction name="getIssuesForProjectUser" returntype="query" access="public" output="false" hint="">
		<cfargument name="projectidfk" type="string" required="false" hint="" />
		<cfargument name="useridfk" type="string" required="false" hint="" />
		<cfargument name="sort" type="string" default="updated">
		<cfargument name="sortdir" type="string" default="desc">
		<cfset var qIssuesForReport =  "" />
		<cfquery name="qIssuesForReport" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#" result="temp">
			SELECT	i.id
					, i.publicid
					,  i.projectidfk
					, i.statusidfk
					, i.locusidfk
					, i.severityidfk
					, i.useridfk
					, i.issuetypeidfk
					, p.name AS project
					, i.name AS issue_name
					, i.description AS description
					, owner.name AS owner
					, creator.name AS creator
					, it.name AS issue_type
					, pl.name AS locus
					, sev.name AS severity
					, s.name AS status
					, created 
					, updated	
					, duedate   
			FROM	cd_issues i
						INNER JOIN  CD_PROJECTLOCI pl ON pl.id = i.locusidfk
							  INNER JOIN CD_SEVERITIES sev ON sev.id = i.severityidfk
							  		INNER JOIN CD_USERS owner ON owner.id = i.useridfk
										  INNER JOIN CD_USERS creator ON creator.id = i.creatoridfk
										  		INNER JOIN CD_STATUSES s ON s.id = i.statusidfk
													  INNER JOIN CD_PROJECTS p ON p.id = i.projectidfk
													  	INNER JOIN cd_issuetypes it ON it.id = i.issuetypeidfk
			WHERE	1 = 1 										  
				   <cfif StructKeyExists( arguments, 'projectidfk' ) AND arguments.projectidfk neq "" AND arguments.projectidfk neq -1>
							AND	i.projectidfk IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.projectidfk#" list="true" />)
						</cfif>
						<cfif StructKeyExists( arguments, 'useridfk' ) AND arguments.useridfk neq "">
							AND	i.useridfk = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.useridfk#" maxlength="35">
						</cfif>
			ORDER BY  	i.projectidfk, i.publicid, #arguments.sort# #arguments.sortdir# 
		</cfquery>
		<cfreturn qIssuesForReport />
	</cffunction>
	
	
		
</cfcomponent>
	
