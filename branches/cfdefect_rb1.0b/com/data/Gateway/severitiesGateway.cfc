
<cfcomponent hint="I am the database agnostic custom Gateway object for the severities object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Gateway.severitiesGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	<cffunction name="getAll" returntype="query" access="public" output="false" hint="">
		<cfargument name="order" type="string" default="rank" hint="" />
		<cfargument name="sort" type="string" default="asc" hint="" />
		<cfset var qAll =  "" />
 		<cfquery name="qAll" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT	*
			FROM	cd_severities
			ORDER BY	#arguments.order# #arguments.sort#
		</cfquery>
		<cfreturn qAll />
	</cffunction>
</cfcomponent>
	
