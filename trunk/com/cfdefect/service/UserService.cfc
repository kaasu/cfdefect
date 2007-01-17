<cfcomponent output="false" displayname="UserService" hint="" extends="AbstractService">

<cffunction name="init" returntype="UserService" output="false" access="public" hint="Constructor">
	<cfargument name="tableName" type="string" required="true" hint="" />
	<cfreturn super.init( argumentCollection=arguments ) />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getSupportingData" returntype="struct" access="public" output="false" hint="">
	<cfset var supportingData =  StructNew() />
	<cfset supportingData['projects'] = getProjectService().getAll() />
	<cfreturn supportingData />
</cffunction>

<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
	<cfreturn getReactorFactory().createGateway( getTableName() ).getAllRecords() />
</cffunction>

<cffunction name="getProjectForUser" returntype="query" access="public" output="false" hint="">
	<cfargument name="user_id" type="string" required="true" hint="" />
	<!--- TODO: Modify this to use a query instead --->
	<cfreturn getRecord( arguments.user_id ).getProjectsIterator().getQuery() />
	<!--- <cfset var gateway = getReactorFactory().createGateway( getTableName() ) /> --->
</cffunction>

<cffunction name="getUserProjectStats" returntype="struct" access="public" output="false" hint="">
	<cfargument name="useridfk" type="string" required="false" hint="" />
	<cfset var issues = getIssueService().getIssuesForProjectUser( useridfk=arguments.useridfk )>
	<cfset var ret = StructNew() />
	<cfset ret['total'] = issues.recordcount />
	<cfset ret['open'] = getOpenIssues( issues ) />
	<cfset ret['projects'] = getIssuesByProjects( issues ) />
	<cfset ret['oldest'] = getOldestIssue( issues ) />
	<cfset ret['newest'] = getNewestIssue( issues ) />
	<cfset ret['overdue'] = getOverDueIssues( issues ) />
	<cfreturn ret />
</cffunction>

<!--- PRIVATE METHODS --->
<cffunction name="getOverDueIssues" returntype="query" access="private" output="false" hint="">
	<cfargument name="issues" type="query" required="true" hint="" />
	<cfset var temp = '' />
	<cfquery name="temp" dbtype="query" maxrows="1">
		SELECT	id
				,publicid
				,issue_name
				, projectidfk
				, created
		FROM	arguments.issues
		WHERE	duedate IS NOT NULL 
				AND duedate < <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#" />
		ORDER	BY created DESC
	</cfquery>
	<cfreturn temp />
</cffunction>

<cffunction name="getNewestIssue" returntype="query" access="private" output="false" hint="">
	<cfargument name="issues" type="query" required="true" hint="" />
	<cfset var temp = '' />
	<cfquery name="temp" dbtype="query" maxrows="1">
		SELECT	id
				,publicid
				,issue_name
				, projectidfk
				, created
		FROM	arguments.issues
		ORDER	BY created DESC
	</cfquery>
	<cfreturn temp />
</cffunction>

<cffunction name="getOldestIssue" returntype="query" access="private" output="false" hint="">
	<cfargument name="issues" type="query" required="true" hint="" />
	<cfset var temp = '' />
	<cfquery name="temp" dbtype="query" maxrows="1">
		SELECT	id
				,publicid
				,issue_name
				, projectidfk
				, created
		FROM	arguments.issues
		ORDER	BY created ASC
	</cfquery>
	<cfreturn temp />
</cffunction>

<cffunction name="getOpenIssues" returntype="string" access="public" output="false" hint="">
	<cfargument name="issues" type="query" required="true" hint="" />
	<cfset var temp = '' />
	<cfquery name="temp" dbtype="query">
		SELECT	COUNT( * ) AS NumberOfOpenIssues
		FROM	arguments.issues
		WHERE	UPPER( status ) = 'OPEN'
	</cfquery>
	<cfif temp.recordcount>
		<cfreturn temp.NumberOfOpenIssues />
	</cfif>
	<cfreturn 0 />
</cffunction>

<cffunction name="getIssuesByProjects" returntype="query" access="private" output="false" hint="">
	<cfargument name="issues" type="query" required="true" hint="" />
	<cfset var temp =  "" />
	<cfquery name="temp" dbtype="query">
		SELECT	projectidfk
				, project
				, COUNT( id ) AS numberOfOpenIssues
		FROM	arguments.issues
		WHERE	UPPER( status ) = 'OPEN'
		GROUP BY	projectidfk,project
	</cfquery>
	<cfreturn temp />
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getIssueService" access="public" returntype="cfdefect.com.cfdefect.service.IssueService" output="false" hint="Getter for IssueService">
	<cfreturn variables.instance.IssueService />
</cffunction>

<cffunction name="setIssueService" access="public" returntype="void" output="false" hint="Setter for IssueService">
	<cfargument name="IssueService" type="cfdefect.com.cfdefect.service.IssueService" required="true" />
	<cfset variables.instance.IssueService = arguments.IssueService>
</cffunction>

<cffunction name="getProjectService" access="public" returntype="cfdefect.com.cfdefect.service.Projectservice" output="false" hint="Getter for ProjectService">
	<cfreturn variables.instance.ProjectService />
</cffunction>

<cffunction name="setProjectService" access="public" returntype="void" output="false" hint="Setter for ProjectService">
	<cfargument name="ProjectService" type="cfdefect.com.cfdefect.service.Projectservice" required="true" />
	<cfset variables.instance.ProjectService = arguments.ProjectService>
</cffunction>

</cfcomponent>