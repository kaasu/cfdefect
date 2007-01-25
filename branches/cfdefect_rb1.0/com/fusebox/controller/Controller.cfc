<cfcomponent output="false" displayname="Controller" hint="" extends="AbstractController">

<cffunction name="init" returntype="Controller" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getAnnouncementForUser" returntype="void" access="public" output="false" hint="I add a query in to event object which has all the announcement for the currently logged in user to be displayed on home page.">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'qAnnouncements', getBean( 'AnnouncementService' ).getAnnouncementForUser( arguments.event.getValue( 'user' ).getID() ) )  />
</cffunction>

<cffunction name="getUserProjectStats" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<!--- <cfdump var="#getBean( 'UserService' ).getUserProjectStats( arguments.event.getValue( 'user' ).getID() )#"><cfabort> --->
	<cfset arguments.event.setValue( 'userProjectStats', getBean( 'UserService' ).getUserProjectStats( arguments.event.getValue( 'user' ).getID() ) )  />
</cffunction>

<cffunction name="OnRequestStart" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfscript>
	arguments.event.setValue( 'skin', 'html' );
	//  injecting udf library in event scope so that views can use it.
	arguments.event.setValue( 'UDF', getBean( 'UDF' ) );;
	arguments.event.setValue( 'ApplicationConfig', getBean( 'ApplicationConfig' ) );
	arguments.event.setValue( 'ApplicationTitle', arguments.event.getValue( 'ApplicationConfig' ).getConfig( 'AppTitle' ) );
	</cfscript>
</cffunction>

<cffunction name="getUserRecord" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfif NOT arguments.event.valueExists( 'recordObject' )>
		<cfset arguments.event.setValue( 'recordObject', getBean( 'UserService' ).getRecord( arguments.event.getValue( 'user' ).getID() ) ) />	
	</cfif>
</cffunction>

<cffunction name="savePreferences" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var udf = arguments.event.getValue( 'UDF' ) />
	<cfset arguments.event.setValue( 'recordObject', getBean( 'UserService' ).validateAndProcess( udf.getSimpleValuesFromStruct( arguments.event.getAllValues() ) ) ) />
</cffunction>

<cffunction name="getIssueForProject" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset getBean( 'IssueService' ).getIssueForProject( projectid=arguments.event.getValue( 'projectid' ) ) />
</cffunction>

<cffunction name="getIssueHeader" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'columns', getBean( 'IssueService' ).getColumns() ) />
</cffunction>

<cffunction name="getIssueSupportingData" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfif NOT arguments.event.valueExists( 'supportingData' )>
		<cfset arguments.event.setValue( 'supportingData', getBean( 'IssueService' ).getSupportingData() ) />
	</cfif>
</cffunction>

<cffunction name="getIssueRecord" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfif NOT arguments.event.valueExists( 'recordObject' )>
		<cfset arguments.event.setValue( 'recordObject', getBean( 'IssueService' ).getRecord( arguments.event.getValue( 'id',  '0' ) , arguments.event.getValue( 'projectidfk' ) ) ) />	
	</cfif>
</cffunction>

<cffunction name="validateAndProcessIssue" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var udf = arguments.event.getValue( 'UDF' ) />
	<cfset arguments.event.setValue( 'recordObject', getBean( 'IssueService' ).validateAndProcess( udf.getSimpleValuesFromStruct( arguments.event.getAllValues() ) ) ) />
</cffunction>

<cffunction name="deleteIssue" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset getBean( 'IssueService' ).delete( arguments.event.getValue( 'chkid' ) ) />
</cffunction>

<cffunction name="getProjectForReport" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'qProject', getBean( 'ReportService' ).getProjects() ) />
</cffunction>

<cffunction name="generateReportOrChart" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfif arguments.event.getValue( 'option' ) eq 'chart'>
		<cfset arguments.event.setValue( 'reportData', getBean( 'ReportService' ).generateChart( arguments.event.getValue( 'projectidfk' ) ) ) />
	<cfelse>
		<cfset arguments.event.setValue( 'reportData', getBean( 'ReportService' ).generateReport( arguments.event.getValue( 'projectidfk' ), arguments.event.getValue( 'option' ) ) ) />
	</cfif>
	<cfif arguments.event.getValue( 'option' ) eq 'excel'>
		<cfset arguments.event.setValue( 'skin', 'excel' ) />
	</cfif>
	<!--- <cfset var bean = getBean( 'ReportService' ) />
	<cfset var option = arguments.event.getValue( 'option' ) />
	<cfset var local =  StructNew() />
	<cfinvoke component="#bean#" method="runReportQuery" returnvariable="local.reportQuery">
		<cfinvokeargument name="projectidfk" value="#arguments.event.getValue( 'projectidfk' )#" />
		<cfif arguments.event.getValue( 'projectidfk' ) eq -1>
			<cfinvokeargument name="useridfk" value="#arguments.event.getValue( 'user' ).getID()#" />
		</cfif>
	</cfinvoke>
	<cfset local.reportQuery = bean.runReportQuery( arguments.event.getValue( 'projectidfk' ) ) />
	
	<cfif ListFindNoCase( 'html~excel', option, '~' )>
		<cfset local.reportXML = bean.makeReportXML( local.reportQuery ) />	
		<cfset arguments.event.setValue( 'reportContent', bean.transformReport( local.reportXML, option ) ) />
		<cfif option eq 'excel'>
			<cfset arguments.event.setValue( 'skin', 'excel' ) />
		</cfif>
	<cfelse>
		<cfset arguments.event.setValue( 'reportCharts', bean.makeReportCharts( local.reportQuery ) ) />
	</cfif> --->
</cffunction>

<cffunction name="getProjectForRSS" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'qProject', getBean( 'RSSService' ).getProjects() ) />
</cffunction>

<cffunction name="generateRSS" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'xmlData', getBean( 'RSSService' ).generateRSS( arguments.event.getValue( 'projectidfk', '' ) ) ) />
	<cfset arguments.event.setValue( 'skin', 'xml' ) />
</cffunction>

<cffunction name="getProjectForUser" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'qUserProjects', getBean( 'UserService' ).getProjectForUser( arguments.event.getValue( 'user' ).getID() ) ) />
</cffunction>


<!--- PRIVATE METHODS --->
</cfcomponent>