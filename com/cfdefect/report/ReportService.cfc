<cfcomponent output="false" displayname="ReportService" hint="">

<cffunction name="init" returntype="cfdefect.com.cfdefect.report.ReportService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="generateReport" returntype="any" access="public" output="false" hint="">
	<cfargument name="projectidfk" type="string" required="true" hint="" />
	<cfargument name="option" type="string" required="true" hint="either html, excel or chart. XML and PDF will be added later" />
	<cfset var qReport = runReportQuery( arguments.projectidfk ) />
	<cfset var reportXML = makeReportXML( qReport ) />
	<cfreturn transformReport( reportXML, arguments.option ) />
</cffunction>

<cffunction name="generateChart" returntype="struct" access="public" output="false" hint="">
	<cfargument name="projectidfk" type="string" required="true" hint="" />
	<cfset var charts = StructNew() />
	<cfset var qReport = runReportQuery( arguments.projectidfk ) />
	<cfset var chartData = formatDataForChart( qReport ) />
	<cfset charts['issue_types'] = makeChart( chartData,  'issue_types', 'Issue Types' ) /> 
	<cfset charts['statuses'] = makeChart( chartData,  'statuses', 'Statuses' ) /> 
	<cfset charts['severities'] = makeChart( chartData,  'severities', 'Severities' ) /> 
	<cfset charts['loci'] = makeChart( chartData,  'loci', 'Loci', '500' ) /> 
	<cfset charts['users'] = makeChart( chartData,  'users', 'Issue per User' ) /> 
	<cfreturn charts />
</cffunction>


<cffunction name="getProjects" returntype="query" access="public" output="false" hint="">
	<cfif getSecurityService().getUser().getAdmin()>
		<cfreturn getProjectService().getAll() />
	<cfelse>
		<cfreturn getUserService().getProjectForUser( getSecurityService().getUser().getID() ) />
	</cfif>
</cffunction>

<cffunction name="makeReportXML" returntype="xml" access="private" output="false" hint="">
	<cfargument name="reportData" type="query" required="true" hint="" />
	<cfset var ret =  "" />
	<cfxml variable="ret">
		<cfoutput>
		<report>
		</cfoutput>
		<cfoutput query="arguments.reportData" group="projectidfk">
			<project>
				<id>#XMLFormat( projectidfk )#</id>
				<project_name>#XMLFormat( project )#</project_name>
				<issues>
				<cfoutput>
					<issue>
						<id>#XMLFormat( id )#</id>
						<publicid>#XMLFormat( publicid )#</publicid>
						<name>#XMLFormat( issue_name )#</name>
						<owner>#XMLFormat( owner )#</owner>
						<creator>#XMLFormat( creator )#</creator>
						<issue_type>#XMLFormat( issue_type )#</issue_type>
						<locus>#XMLFormat( locus )#</locus>
						<severity>#XMLFormat( severity )#</severity>
						<status>#XMLFormat( status )#</status>
						<created>#DateFormat( created , 'mm/dd/yyyy' )#  #TimeFormat( created, 'short' )#</created>
						<updated>#DateFormat( updated , 'mm/dd/yyyy' )#  #TimeFormat( updated, 'short' )#</updated>
					</issue>				
				</cfoutput>
				</issues>
			</project>
		</cfoutput>
		<cfoutput>
		</report>
		</cfoutput>
	</cfxml>
	
	<cfreturn ret />
</cffunction>

<cffunction name="runReportQuery" returntype="query" access="private" output="false" hint="">
	<cfargument name="projectidfk" type="string" required="true" hint="" />
	<!--- get Issues for logged in user only --->
	<cfif arguments.projectidfk eq -1>
		<cfreturn getIssueService().getIssuesForProjectUser( useridfk=getSecurityService().getUser().getID() ) />
	</cfif>
	<cfreturn getIssueService().getIssuesForProjectUser( projectidfk=arguments.projectidfk ) />
</cffunction>

<cffunction name="transformReport" returntype="string" access="private" output="false" hint="I transform a report based on the skin provided to me as the argument.">
	<cfargument name="reportXML" type="xml" required="true" hint="" />
	<cfargument name="skin" type="string" required="true" hint="" />
	<cfset var xsltPath = ExpandPath( getApplicationConfiguration().getConfig( 'xsltPath' ) ) />
	<cfreturn XMLTransform( arguments.reportXML, xsltPath & '\' & arguments.skin & '.xsl' ) />
</cffunction>

<cffunction name="makeReportCharts" returntype="struct" access="public" output="false" hint="">
	<cfargument name="reportData" type="query" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset local.charts = StructNew() />
	<cfset local.chartData = formatDataForChart( arguments.reportData ) />
	<cfset local.charts['issue_types'] = makeChart( local.chartData,  'issue_types', 'Issue Types' ) /> 
	<cfset local.charts['statuses'] = makeChart( local.chartData,  'statuses', 'Statuses' ) /> 
	<cfset local.charts['severities'] = makeChart( local.chartData,  'severities', 'Severities' ) /> 
	<cfset local.charts['loci'] = makeChart( local.chartData,  'loci', 'Loci', '500' ) /> 
	<cfset local.charts['users'] = makeChart( local.chartData,  'users', 'Issue per User' ) /> 
	<cfreturn local.charts />
</cffunction>

<!--- PRIVATE METHODS --->
<cffunction name="formatDataForChart" returntype="struct" access="private" output="false" hint="">
	<cfargument name="reportData" type="query" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset local.projects = StructNew() />
	<cfoutput query="arguments.reportdata" group="projectidfk">
		<cfset local.projects[projectidfk] = StructNew() />
		<cfset local.projects[projectidfk].project_name = project />
		<cfset local.projects[projectidfk].statuses = populateWithQuery( getStatusService().getAll(), local.projects[projectidfk] ) />
		<cfset local.projects[projectidfk].severities = populateWithQuery( getSeverityService().getAll(), local.projects[projectidfk] ) />
		<cfset local.projects[projectidfk].users = populateWithQuery( getUserService().getAll(), local.projects[projectidfk] ) />
		<cfset local.projects[projectidfk].loci = populateWithQuery( getProjectLocusService().getAll(), local.projects[projectidfk] ) />
		<cfset local.projects[projectidfk].issue_types =  populateWithQuery( getIssueTypeService().getAll(), local.projects[projectidfk] ) />
		<cfoutput>
			<cfset local.projects[projectidfk].issue_types[issuetypeidfk].total = local.projects[projectidfk].issue_types[issuetypeidfk].total + 1 />
			<cfset local.projects[projectidfk].statuses[statusidfk].total = local.projects[projectidfk].statuses[statusidfk].total + 1 />
			<cfset local.projects[projectidfk].severities[severityidfk].total = local.projects[projectidfk].severities[severityidfk].total + 1 />
			<cfset local.projects[projectidfk].loci[locusidfk].total = local.projects[projectidfk].loci[locusidfk].total + 1 />
			<cfset local.projects[projectidfk].users[useridfk].total = local.projects[projectidfk].users[useridfk].total + 1 />
		</cfoutput>
	</cfoutput>
	<cfreturn local.projects />
</cffunction>

<cffunction name="populateWithQuery" returntype="struct" access="private" output="false" hint="">
	<cfargument name="query" type="query" required="true" hint="" />
	<cfargument name="struct" type="struct" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfloop query="arguments.query">
		<cfset ret[id] = StructNew() />
		<cfset ret[id].name = name />
		<cfset ret[id].total = 0 />
	</cfloop>
	<cfreturn ret />
</cffunction>

<cffunction name="makeChart" returntype="string" access="private" output="false" hint="">
	<cfargument name="chartData" type="struct" required="true" hint="" />
	<cfargument name="chartKey" type="string" required="true" hint="" />
	<cfargument name="chartTitle" type="string" required="true" hint="" />
	<cfargument name="width" type="string" default="300" hint="" />
	<cfset var local =  StructNew() />
	<cfset var i =  "" />
	<cfset var j = '' />
	<cfoutput>
	<cfsavecontent variable="local.chart">
		<cfchart showLegend="true" title="#arguments.chartTitle#" show3d="true" chartwidth="#arguments.width#">
			<cfloop item="i" collection="#arguments.chartData#">
				<cfchartseries type="bar" seriesLabel="#arguments.chartData[i].project_name#">
					<cfset local.chartTypeData = arguments.chartData[i][arguments.chartKey] />
					<cfloop collection="#local.chartTypeData#" item="j">
						<cfchartdata item="#local.chartTypeData[j].name#" value="#local.chartTypeData[j].total#">
					</cfloop>
				</cfchartseries>
			</cfloop>
		</cfchart>
	</cfsavecontent>
	</cfoutput>
	<cfreturn local.chart />
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getApplicationConfiguration" access="private" returntype="cfdefect.com.cfdefect.core.ApplicationConfiguration" output="false" hint="Getter for ApplicationConfiguration">
	<cfreturn variables.instance.ApplicationConfiguration />
</cffunction>

<cffunction name="setApplicationConfiguration" access="public" returntype="void" output="false" hint="Setter for ApplicationConfiguration">
	<cfargument name="ApplicationConfiguration" type="cfdefect.com.cfdefect.core.ApplicationConfiguration" required="true" />
	<cfset variables.instance.ApplicationConfiguration = arguments.ApplicationConfiguration>
</cffunction>

<cffunction name="getIssueService" access="private" returntype="cfdefect.com.cfdefect.service.IssueService" output="false" hint="Getter for IssueService">
	<cfreturn variables.instance.IssueService />
</cffunction>

<cffunction name="setIssueService" access="public" returntype="void" output="false" hint="Setter for IssueService">
	<cfargument name="IssueService" type="cfdefect.com.cfdefect.service.IssueService" required="true" />
	<cfset variables.instance.IssueService = arguments.IssueService>
</cffunction>

<cffunction name="getIssueTypeService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for IssueTypeService">
	<cfreturn variables.instance.IssueTypeService />
</cffunction>

<cffunction name="setIssueTypeService" access="public" returntype="void" output="false" hint="Setter for IssueTypeService">
	<cfargument name="IssueTypeService" type="cfdefect.com.cfdefect.service.GenericService" required="true" />
	<cfset variables.instance.IssueTypeService = arguments.IssueTypeService>
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

<cffunction name="getStatusService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for SeverityService">
	<cfreturn variables.instance.StatusService />
</cffunction>

<cffunction name="setStatusService" access="public" returntype="void" output="false" hint="Setter for SeverityService">
	<cfargument name="StatusService" type="cfdefect.com.cfdefect.service.AbstractService" required="true" />
	<cfset variables.instance.StatusService = arguments.StatusService>
</cffunction>

<cffunction name="getSeverityService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for SeverityService">
	<cfreturn variables.instance.SeverityService />
</cffunction>

<cffunction name="setSeverityService" access="public" returntype="void" output="false" hint="Setter for SeverityService">
	<cfargument name="SeverityService" type="cfdefect.com.cfdefect.service.AbstractService" required="true" />
	<cfset variables.instance.SeverityService = arguments.SeverityService>
</cffunction>

<cffunction name="getProjectLocusService" access="private" returntype="cfdefect.com.cfdefect.service.AbstractService" output="false" hint="Getter for ProjectLocusService">
	<cfreturn variables.instance.ProjectLocusService />
</cffunction>

<cffunction name="setProjectLocusService" access="public" returntype="void" output="false" hint="Setter for ProjectLocusService">
	<cfargument name="ProjectLocusService" type="cfdefect.com.cfdefect.service.AbstractService" required="true" />
	<cfset variables.instance.ProjectLocusService = arguments.ProjectLocusService>
</cffunction>
</cfcomponent>