<cfcomponent output="false" displayname="RSSService" hint="">

<cffunction name="init" returntype="cfdefect.com.cfdefect.rss.RSSService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<cffunction name="configure" returntype="void" access="public" output="false" hint="">
	<cfset var meta =  StructNew() />
	<cfset meta.title = getApplicationConfiguration().getAppTitle() />
	<cfset meta.link = getApplicationConfiguration().getAppLink() />
	<cfset meta.description = getApplicationConfiguration().getAppTitle() & ' Site'>
	<cfset setMeta( meta ) />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getProjects" returntype="query" access="public" output="false" hint="">
	<cfset var user = getSecurityService().getUser() />
	<cfif user.getIsAdmin()>
		<cfreturn getProjectService().getAll() />
	<cfelse>
		<cfreturn getUserService().getProjectForUser( user_id = user.getID() ) />
	</cfif>
</cffunction>

<cffunction name="generateRSS" returntype="xml" access="public" output="false" hint="">
	<cfargument name="projectidfk" type="string" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset local.issues = getIssues( argumentCollection=arguments ) />
	<cfset local.rss  = getRSS().generateRSS( 'RSS1', local.issues, getMeta() )>
	<cfreturn local.rss />
</cffunction>


<!--- PRIVATE METHODS --->
<cffunction name="getIssues" returntype="query" access="private" output="false" hint="">
	<cfargument name="projectidfk" type="string" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset local.ret = QueryNew( 'link,title,body,date', 'VARCHAR,VARCHAR,VARCHAR,VARCHAR')>
	<cfif arguments.projectidfk eq -1>
		<cfset local.issues = getIssueService().getIssuesForProjectUser( useridfk = getSecurityService().getUser().getID() ) />
	<cfelse>	
		<cfset local.issues = getIssueService().getIssuesForProjectUser( projectidfk=arguments.projectidfk ) />
	</cfif>
	<cfloop query="local.issues">
		<!--- <cfset local.date = DateFormat( updated,  'yyyy-mm-dd' ) />
		<cfset local.date = local.date & 'T' & TimeFormat( updated, 'HH:mm:ss' ) & '-' & NumberFormat( .utcHourOffset, '00' ) & ':00'> --->
		<cfset QueryAddRow( local.ret ) />
		<cfset QuerySetCell( local.ret, 'link',  getApplicationConfiguration().getAppLink() & 'c.issues&projectidfk=' & URLEncodedFormat( projectidfk ) ) />
		<cfset QuerySetCell( local.ret, 'title', project & ' ' & issue_name ) />
		<cfset QuerySetCell( local.ret, 'body', description ) />
		<cfset QuerySetCell( local.ret, 'date', updated ) /> 
	</cfloop>
	<cfreturn local.ret />
</cffunction>



<!--- GETTER & SETTER --->
<cffunction name="getMeta" access="private" returntype="struct" output="false" hint="Getter for Meta">
	<cfreturn variables.instance.Meta />
</cffunction>

<cffunction name="setMeta" access="private" returntype="void" output="false" hint="Setter for Meta">
	<cfargument name="Meta" type="struct" required="true" />
	<cfset variables.instance.Meta = arguments.Meta>
</cffunction>

<cffunction name="getApplicationConfiguration" access="private" returntype="cfdefect.com.cfdefect.config.ApplicationConfiguration" output="false" hint="Getter for ApplicationConfiguration">
	<cfreturn variables.instance.ApplicationConfiguration />
</cffunction>

<cffunction name="setApplicationConfiguration" access="public" returntype="void" output="false" hint="Setter for ApplicationConfiguration">
	<cfargument name="ApplicationConfiguration" type="cfdefect.com.cfdefect.config.ApplicationConfiguration" required="true" />
	<cfset variables.instance.ApplicationConfiguration = arguments.ApplicationConfiguration>
</cffunction>

<cffunction name="getRSS" access="private" returntype="RSS" output="false" hint="Getter for RSS">
	<cfreturn variables.instance.RSS />
</cffunction>

<cffunction name="setRSS" access="public" returntype="void" output="false" hint="Setter for RSS">
	<cfargument name="RSS" type="RSS" required="true" />
	<cfset variables.instance.RSS = arguments.RSS>
</cffunction>

<cffunction name="getIssueService" access="private" returntype="cfdefect.com.cfdefect.service.IssueService" output="false" hint="Getter for IssueService">
	<cfreturn variables.instance.IssueService />
</cffunction>

<cffunction name="setIssueService" access="public" returntype="void" output="false" hint="Setter for IssueService">
	<cfargument name="IssueService" type="cfdefect.com.cfdefect.service.IssueService" required="true" />
	<cfset variables.instance.IssueService = arguments.IssueService>
</cffunction>

<cffunction name="getProjectService" access="private" returntype="cfdefect.com.cfdefect.service.ProjectService" output="false" hint="Getter for ProjectService">
	<cfreturn variables.instance.ProjectService />
</cffunction>

<cffunction name="setProjectService" access="public" returntype="void" output="false" hint="Setter for ProjectService">
	<cfargument name="ProjectService" type="cfdefect.com.cfdefect.service.ProjectService" required="true" />
	<cfset variables.instance.ProjectService = arguments.ProjectService>
</cffunction>

<cffunction name="getUserService" access="private" returntype="cfdefect.com.cfdefect.service.UserService" output="false" hint="Getter for UserService">
	<cfreturn variables.instance.UserService />
</cffunction>

<cffunction name="setUserService" access="public" returntype="void" output="false" hint="Setter for UserService">
	<cfargument name="UserService" type="cfdefect.com.cfdefect.service.UserService" required="true" />
	<cfset variables.instance.UserService = arguments.UserService>
</cffunction>

<cffunction name="getSecurityService" access="private" returntype="cfdefect.com.cfdefect.core.SecurityService" output="false" hint="Getter for SecurityService">
	<cfreturn variables.instance.SecurityService />
</cffunction>

<cffunction name="setSecurityService" access="public" returntype="void" output="false" hint="Setter for SecurityService">
	<cfargument name="SecurityService" type="cfdefect.com.cfdefect.core.SecurityService" required="true" />
	<cfset variables.instance.SecurityService = arguments.SecurityService>
</cffunction>

</cfcomponent>