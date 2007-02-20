<cfcomponent output="false" displayname="IssueNotificationAdvice" hint="" extends="coldspring.aop.MethodInterceptor">

<cffunction name="init" returntype="cfdefect.com.cfdefect.aop.IssueNotificationAdvice" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="invokeMethod" returntype="any" access="public" output="false" hint="">
	<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" hint="" />
	<cfset var local =  StructNew() />
	<cfset var issueService = arguments.methodInvocation.getTarget() />
	<cfset local.recordHolder = StructNew() />
	<!--- This is not a new record so let's keep the old record for reference. --->
	<cfif arguments.methodInvocation.getArguments().data.id GT 0>
		<cfset local.recordHolder['old'] = issueService.getRecord( 	id = arguments.methodInvocation.getArguments().data.id, 
																	projectidfk = arguments.methodInvocation.getArguments().data.projectidfk ) />	
	</cfif>
	<!--- proceed with the normal method --->
	<cfset local.recordHolder['new'] = arguments.methodInvocation.proceed() />
		
	<!--- if there were no errors --->
	<cfif NOT local.recordHolder['new'].hasErrors()>
		<cfset getIssueNotificationProcessor().sendNotification( local.recordHolder ) />
	</cfif>
	<cfreturn local.recordHolder['new'] />
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getIssueNotificationProcessor" access="public" returntype="cfdefect.com.cfdefect.aop.IssueNotificationProcessor" output="false" hint="Getter for IssueNotificationProcessor">
	<cfreturn variables.instance.IssueNotificationProcessor />
</cffunction>

<cffunction name="setIssueNotificationProcessor" access="public" returntype="void" output="false" hint="Setter for IssueNotificationProcessor">
	<cfargument name="IssueNotificationProcessor" type="cfdefect.com.cfdefect.aop.IssueNotificationProcessor" required="true" />
	<cfset variables.instance.IssueNotificationProcessor = arguments.IssueNotificationProcessor>
</cffunction>

</cfcomponent>