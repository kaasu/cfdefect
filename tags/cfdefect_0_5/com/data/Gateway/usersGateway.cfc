
<cfcomponent hint="I am the database agnostic custom Gateway object for the users object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.usersGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
		<cfset var qAllRecords =  "" />
 		<cfquery name="qAllRecords" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT	u.id
					, u.name
					, u.username
					, u.emailAddress AS email,
					CASE WHEN	 EXISTS ( 	SELECT 1			
	   				 		  				FROM	CD_USERS_GROUPS ug,
							  						CD_GROUPS g
							  				WHERE 	g.id = 	ug.groupidfk
							  						AND ug.useridfk = u.id
							  						AND g.name = 'admin'  )
						THEN 'Yes'
						ELSE 'No'
					END AS admin	
			FROM	CD_USERS		 u
		</cfquery>
		<cfreturn qAllRecords />
	</cffunction>
	
</cfcomponent>
	
