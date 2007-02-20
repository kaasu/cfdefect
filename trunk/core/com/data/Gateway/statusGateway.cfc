
<cfcomponent hint="I am the database agnostic custom Gateway object for the status object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.statusGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
		<cfargument name="applicationid" type="string" required="true" hint="" />
		<cfargument name="order" type="string" default="rank" hint="" />
		<cfargument name="sort" type="string" default="asc" hint="" />
		<cfset var qAllRecords =  "" />
 		<cfquery name="qAllRecords" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT	*
			FROM	cd_status
			WHERE	applicationid = <cfqueryparam value="#arguments.applicationid#" cfsqltype="cf_sql_varchar" />
			ORDER BY	#arguments.order# #arguments.sort#
		</cfquery>
		<cfreturn qAllRecords />
	</cffunction>
	
</cfcomponent>
	
