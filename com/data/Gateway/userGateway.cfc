
<cfcomponent hint="I am the database agnostic custom Gateway object for the user object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.userGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
		<cfargument name="applicationid" type="string" required="true" hint="" />
		<cfset var qAllRecords =  "" />
 		<cfquery name="qAllRecords" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT	u.id
					, u.name
					, u.username
					, u.emailAddress AS email
					, CASE 	WHEN	u.isAdmin = 1
							THEN 'Yes'
							ELSE 'No'
					END AS admin
					, u.isAdmin
			FROM	cd_user		 u
			WHERE	applicationid = <cfqueryparam value="#arguments.applicationid#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		<cfreturn qAllRecords />
	</cffunction>
	
</cfcomponent>
	
