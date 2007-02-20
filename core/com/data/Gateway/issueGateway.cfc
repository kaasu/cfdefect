
<cfcomponent hint="I am the database agnostic custom Gateway object for the issue object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.issueGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	
	<cffunction name="getIssuesForProject" returntype="query" access="public" output="false" hint="">
		<cfargument name="applicationid" type="string" required="true" hint="" />
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
			FROM   	cd_issue i
	   	 				JOIN cd_projectlocus pl ON pl.id = i.locusidfk
	   	 					AND pl.applicationid =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
	   	 					<cfif Len( Trim( arguments.locus_selected ) ) AND arguments.locus_selected neq '-1'>
								AND 	pl.id = <cfqueryparam value="#arguments.locus_selected#" cfsqltype="cf_sql_varchar" />
							</cfif>
		 	  				JOIN  cd_severity sev on sev.id = i.severityidfk
		 	  					AND sev.applicationid =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
		 	  					<cfif Len( Trim( arguments.severity_selected ) ) AND arguments.severity_selected neq '-1'>
									AND 	sev.id = <cfqueryparam value="#arguments.severity_selected#" cfsqltype="cf_sql_varchar" />
								</cfif>
			  					JOIN cd_status s ON s.id = i.statusidfk
			  						AND s.applicationid =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
			  						<cfif Len( Trim( arguments.status_selected ) ) AND arguments.status_selected neq '-1'>
										AND 	s.id = <cfqueryparam value="#arguments.status_selected#" cfsqltype="cf_sql_varchar" />
									</cfif>
						 			JOIN cd_user u ON u.id = i.useridfk
						 				AND u.applicationid =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
						 				<cfif Len( Trim( arguments.user_selected ) ) AND arguments.user_selected neq '-1'>
											AND 	u.id = <cfqueryparam value="#arguments.user_selected#" cfsqltype="cf_sql_varchar" />
										</cfif>
										JOIN cd_issuetype it ON it.id = i.issuetypeidfk
											AND it.applicationid =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
											<cfif Len( Trim( arguments.issue_type_selected ) ) AND arguments.issue_type_selected neq '-1'>
												AND 	it.id = <cfqueryparam value="#arguments.issue_type_selected#" cfsqltype="cf_sql_varchar" />
											</cfif>
			WHERE 	i.applicationid =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
					AND i.projectidfk = <cfqueryparam value="#arguments.projectidfk#" cfsqltype="cf_sql_varchar" />
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
		<cfargument name="applicationid" type="string" required="true" hint="" />
		<cfargument name="projectidfk" type="string" required="false" hint="" />
		<cfargument name="useridfk" type="string" required="false" hint="" />
		<cfargument name="sort" type="string" default="updated">
		<cfargument name="sortdir" type="string" default="desc">
		<cfset var qIssuesForProjectUser =  StructNew() />
		<cfquery name="qIssuesForProjectUser.data" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#" result="qIssuesForProjectUser.result">
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
			FROM	cd_issue i
						INNER JOIN  CD_PROJECTLOCUS pl ON pl.id = i.locusidfk
							AND	pl.applicationid = 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
							INNER JOIN CD_SEVERITY sev ON sev.id = i.severityidfk
								AND	sev.applicationid = 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
							  	INNER JOIN CD_USER owner ON owner.id = i.useridfk
							  		AND	owner.applicationid = 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
									INNER JOIN CD_USER creator ON creator.id = i.creatoridfk
										AND	creator.applicationid = 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
										INNER JOIN CD_STATUS s ON s.id = i.statusidfk
											AND	s.applicationid = 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
											INNER JOIN CD_PROJECT p ON p.id = i.projectidfk
												AND	p.applicationid = 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
												INNER JOIN cd_issuetype it ON it.id = i.issuetypeidfk
													AND	it.applicationid = 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />
			WHERE	i.applicationid =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationid#" maxlength="35" />										  
				   <cfif StructKeyExists( arguments, 'projectidfk' ) AND arguments.projectidfk neq "" AND arguments.projectidfk neq -1>
							AND	i.projectidfk IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.projectidfk#" list="true" />)
						</cfif>
						<cfif StructKeyExists( arguments, 'useridfk' ) AND arguments.useridfk neq "">
							AND	i.useridfk = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.useridfk#" maxlength="35" />
						</cfif>
			ORDER BY  	i.projectidfk, i.publicid, #arguments.sort# #arguments.sortdir# 
		</cfquery>
		<cfreturn qIssuesForProjectUser.data />
	</cffunction>
	
	
</cfcomponent>
	
