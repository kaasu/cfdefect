<cfcomponent output="false" displayname="AjaxController" hint="" extends="AbstractController">

<cffunction name="init" returntype="AjaxController" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getIssuesForProject"  returntype="void" access="public" output="true" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfargument name="myself" type="string" required="true" hint="" />
	<cfargument name="editXFA" type="string" required="true" hint="" />
	<cfset var temp =  "" />
	<cfinvoke component="#getBean( 'IssueService' )#" method="formatIssuesForProject" returnvariable="temp">
		<cfinvokeargument name="projectidfk" value="#URLDecode( arguments.event.getValue( 'projectidfk' ) )#" />
		<cfinvokeargument name="editlink" value="#arguments.myself##arguments.editXFA#" />
		<cfinvokeargument name="issue_type_selected" value="#arguments.event.getValue( 'issue_type_selected','' )#" />
		<cfinvokeargument name="locus_selected" value="#arguments.event.getValue( 'locus_selected', '' )#" />
		<cfinvokeargument name="severity_selected" value="#arguments.event.getValue( 'severity_selected', '' )#" />
		<cfinvokeargument name="status_selected" value="#arguments.event.getValue( 'status_selected', '' )#" />
		<cfinvokeargument name="user_selected" value="#arguments.event.getValue( 'user_selected', '' )#" />
		<cfinvokeargument name="keyword" value="#arguments.event.getValue( 'keyword', '' )#" />
	</cfinvoke>
	<cfsetting showdebugoutput="false" />
	<cfcontent reset="true" /><cfoutput>#temp#</cfoutput>
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->


</cfcomponent>