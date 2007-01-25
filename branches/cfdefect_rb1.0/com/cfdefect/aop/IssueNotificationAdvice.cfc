<cfcomponent output="false" displayname="IssueNotificationAdvice" hint="" extends="coldspring.aop.MethodInterceptor">

<cffunction name="init" returntype="cfdefect.com.cfdefect.aop.IssueNotificationAdvice" output="false" access="public" hint="Constructor">
	<cfargument name="applicationLink" type="string" required="true" hint="" />
	<cfset setApplicationLink( arguments.ApplicationLink ) />
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="invokeMethod" returntype="any" access="public" output="false" hint="">
	<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" hint="" />
	<cfset var local =  StructNew() />
	<cfset local.recordHolder = StructNew() />
	<!--- This is not a new record so let's keep the old record for reference. --->
	<cfif arguments.methodInvocation.getArguments().data.id GT 0>
		<cfset local.recordHolder['old'] = getIssueService().getRecord( id=arguments.methodInvocation.getArguments().data.id, projectidfk=arguments.methodInvocation.getArguments().data.projectidfk ) />	
	</cfif>
	<!--- proceed with the normal method --->
	<cfset local.recordHolder['new'] = arguments.methodInvocation.proceed() />
	
	<!--- if there were no errors --->
	<cfif NOT local.recordHolder['new'].hasErrors()>
		<cfset local.recordForEmail = prepareRecordForEmail( local.recordHolder ) />
		
		<cfset local.email = getEmailService().createEmail()>
		<cfset local.email.setTO( getEmailRecipients( local.recordHolder ) ) /> 
		<cfset local.email.setSubject( getSubject( local.recordHolder['new'] ) ) />
		<cfset local.email.setTextMessage( makeTextMessage( local.recordForEmail ) ) />
		<cfset local.email.setHTMLMessage( makeHTMLMessage( local.recordForEmail ) ) />
		<cfset local.email.addHeader( 'Importance', local.recordHolder['new'].getSeverityName() ) />
		<cfset local.email.addHeader( 'X-Message-Flag', 'Follow up' ) />
		<!--- TODO: Implement Reply By functionality --->
		<cfset local.email.send() />
	</cfif>
	<cfreturn local.recordHolder['new'] />
</cffunction>

<!--- PRIVATE METHODS --->
<cffunction name="makeHTMLMessage" returntype="string" access="private" output="false" hint="">
	<cfargument name="emailRecord" type="struct" required="true" hint="" />
	<cfset var ret = '' />
	<cfoutput>
	<cfsavecontent variable="ret">
<dl>
	<dt>Project:</dt>
	<dd>#arguments.emailRecord.project#</dd>
	<dt>Issue:</dt>
	<dd>#arguments.emailRecord.issue#</dd>
	<dt>Locus:</dt>
	<dd>#arguments.emailRecord.locus#</dd>
	<dt>Severity:</dt>
	<dd>#arguments.emailRecord.severity#</dd>
	<dt>Status:</dt>
	<dd>#arguments.emailRecord.status#</dd>
	<dt>Type:</dt>
	<dd>#arguments.emailRecord.type#</dd>	
	<dt>Related URL:</dt>
	<dd>#arguments.emailRecord.relatedURL#</dd>
	<dt>Creator:</dt>
	<dd>#arguments.emailRecord.creator#</dd>
	<dt>Created:</dt>
	<dd>#arguments.emailRecord.created#</dd>
	<dt>Updated:</dt>
	<dd>#arguments.emailRecord.updated#</dd>
	<dt>Owner:</dt>
	<dd>#arguments.emailRecord.owner#</dd>
	<dt>Description:</dt>
	<dd>#arguments.emailRecord.description#</dd>
	<dt>History:</dt>
	<dd>#arguments.emailRecord.history#</dd>
	<dt>Link:</dt>
	<dd><a href="#arguments.emailRecord.link#">Log in to update issue</a></dd>
</dl>	
	</cfsavecontent>
	</cfoutput>
	<cfreturn ret />
</cffunction>

<cffunction name="makeTextMessage" returntype="string" access="private" output="false" hint="">
	<cfargument name="emailRecord" type="struct" required="true" hint="" />
	<cfset var ret = '' />
	<cfoutput>
	<cfsavecontent variable="ret">
Project: #arguments.emailRecord.project#

Issue: #arguments.emailRecord.issue#

Locus: #arguments.emailRecord.locus#

Severity: #arguments.emailRecord.severity#

Status: #arguments.emailRecord.status#

Type: #arguments.emailRecord.type#

Related URL: #arguments.emailRecord.relatedURL#

Creator: #arguments.emailRecord.creator#

Created: #arguments.emailRecord.created#

Updated: #arguments.emailRecord.updated#

Owner: #arguments.emailRecord.owner#
<!--- Owner: #user.getName()# <cfif isDefined("arguments.oldBean") and user.getName() neq oldUser.getName()> (was #oldUser.getName()#)</cfif> --->

Description: #arguments.emailRecord.description#

History:#arguments.emailRecord.history#

Link: #arguments.emailRecord.link#
	
	</cfsavecontent>
	</cfoutput>
	<cfreturn ret />
</cffunction>

<cffunction name="getSubject" returntype="string" access="private" output="false" hint="">
	<cfargument name="record" type="reactor.base.AbstractRecord" required="true" hint="" />
	<cfset var toObj = arguments.record._getTO() />
	<cfset var subject = 'Project ' & toObj.projectName & ' : '/>
	<cfif Len( toObj.name ) GT 100>
		<cfset subject = subject & Left( toObj.name, 100 ) & '...' />
	<cfelse>	
		<cfset subject = subject & toObj.name />
	</cfif>
	<cfreturn subject />
</cffunction>

<cffunction name="prepareRecordForEmail" returntype="struct" access="private" output="false" hint="">
	<cfargument name="recordHolder" type="struct" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset local.ret = StructNew() />
	<cfset local.toHolder = StructNew() />
	<cfset local.toHolder['new'] = arguments.recordHolder['new']._getTO() />
	<cfif StructKeyExists( arguments.recordHolder, 'old' )>
		<cfset local.toHolder['old'] = arguments.recordHolder['old']._getTO() />
	</cfif>
	<cfset local.ret['project'] = local.toHolder['new'].projectName />
	<cfset local.ret['issue'] = printWithOldValueIfExists( arguments.recordHolder, local.toHolder, 'name', 'name' ) />
	<cfset local.ret['locus'] = printWithOldValueIfExists( arguments.recordHolder, local.toHolder, 'locusidfk', 'locusname' ) />
	<cfset local.ret['severity'] = printWithOldValueIfExists( arguments.recordHolder, local.toHolder, 'severityidfk', 'severityname' ) />
	<cfset local.ret['status'] = printWithOldValueIfExists( arguments.recordHolder, local.toHolder, 'statusidfk', 'statusname' ) />
	<cfset local.ret['type'] = printWithOldValueIfExists( arguments.recordHolder, local.toHolder, 'issuetypeidfk', 'issuetypename' ) />
	<cfset local.ret['relatedurl'] = local.toHolder['new'].relatedurl />
	<cfset local.ret['creator'] = local.toHolder['new'].creatorName />
	<cfset local.ret['created'] = DateFormat( local.toHolder['new'].created,  'mm/dd/yyyy' ) & ' ' & TimeFormat( local.toHolder['new'].created, 'short' )/>
	<cfset local.ret['updated'] = DateFormat( local.toHolder['new'].updated,  'mm/dd/yyyy' ) & ' ' & TimeFormat( local.toHolder['new'].updated, 'short' )/>
	<cfset local.ret['owner'] = printWithOldValueIfExists( arguments.recordHolder, local.toHolder, 'useridfk', 'ownername' ) />
	<cfset local.ret['description'] = local.toHolder['new'].description />
	<cfset local.ret['history'] = local.toHolder['new'].history />
	<cfset local.ret['link'] = getApplicationLink() & 'c.editissue&id=' & URLEncodedFormat( arguments.recordHolder['new'].getID() ) & '&projectidfk=' & URLEncodedFormat( arguments.recordHolder['new'].getProjectIDFK() ) />
	<cfreturn local.ret />
</cffunction>

<cffunction name="printWithOldValueIfExists" returntype="string" access="private" output="false" hint="">
	<cfargument name="recordHolder" type="struct" required="true" hint="" />
	<cfargument name="toHolder" type="struct" required="true" hint="" />
	<cfargument name="compareKey" type="string" required="true" hint="" />
	<cfargument name="valueKey" type="string" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset var newValue = '' />
	<cfset var oldValue = '' />
	<cfinvoke component="#arguments.recordHolder['new']#" method="get#arguments.valueKey#" returnvariable="newValue" />
	<cfif StructKeyExists( arguments.toHolder, 'old' )
			AND arguments.toHolder['new'][arguments.compareKey] neq arguments.toHolder['old'][arguments.compareKey]>
		<cfinvoke component="#arguments.recordHolder['old']#" method="get#arguments.valueKey#" returnvariable="oldValue" />
	</cfif>
	<cfif Len( Trim( oldValue ) )>
		<cfset newValue = newValue & ' (was ' & oldValue & ')'>
	</cfif>
	<cfreturn newValue />	
</cffunction>

<cffunction name="getEmailRecipients" returntype="string" access="private" output="false" hint="">
	<cfargument name="recordHolder" type="struct" required="true" hint="" />
	<cfset var emailRecipients = '' />
	<!--- <cfset emailRecipients = arguments.recordHolder['new'].getProjects().getProjectsEmailIterator().getValueList( 'emailAddress',  '~' ) /> --->
	<!--- First see if logged in user is in the list. --->
	<cfif NOT ListFindNoCase( emailRecipients, arguments.recordHolder['new'].getOwner().getEmailAddress(), '~' )>
		<cfset emailRecipients = ListAppend( emailRecipients, arguments.recordHolder['new'].getOwner().getEmailAddress() , '~' ) />
	</cfif>
	<cfif NOT ListFindNoCase( emailRecipients, arguments.recordHolder['new'].getCreator().getEmailAddress(), '~' )>
		<cfset emailRecipients = ListAppend( emailRecipients, arguments.recordHolder['new'].getCreator().getEmailAddress() , '~' ) />
	</cfif> 
	<!--- last but not least, if old user, check him --->
	<cfif StructKeyExists( arguments.recordHolder, 'old' )>
		<cfif NOT ListFindNoCase( emailRecipients, arguments.recordHolder['old'].getOwner().getEmailAddress(), '~' )>
			<cfset emailRecipients = ListAppend( emailRecipients, arguments.recordHolder['old'].getOwner().getEmailAddress() , '~' ) />
		</cfif> 
	</cfif>
	<cfreturn emailRecipients />
</cffunction>








<!--- GETTER & SETTER --->
<cffunction name="getEmailService" access="public" returntype="cfdefect.com.cfdefect.email.EmailService" output="false" hint="Getter for EmailService">
	<cfreturn variables.instance.EmailService />
</cffunction>

<cffunction name="setEmailService" access="public" returntype="void" output="false" hint="Setter for EmailService">
	<cfargument name="EmailService" type="cfdefect.com.cfdefect.email.EmailService" required="true" />
	<cfset variables.instance.EmailService = arguments.EmailService>
</cffunction>

<cffunction name="getIssueService" access="private" returntype="cfdefect.com.cfdefect.service.IssueService" output="false" hint="Getter for IssueService">
	<cfreturn variables.instance.IssueService />
</cffunction>

<cffunction name="setIssueService" access="public" returntype="void" output="false" hint="Setter for IssueService">
	<cfargument name="IssueService" type="cfdefect.com.cfdefect.service.IssueService" required="true" />
	<cfset variables.instance.IssueService = arguments.IssueService>
</cffunction>


<cffunction name="getApplicationLink" access="private" returntype="string" output="false" hint="Getter for ApplicationLink">
	<cfreturn variables.instance.ApplicationLink />
</cffunction>

<cffunction name="setApplicationLink" access="private" returntype="void" output="false" hint="Setter for ApplicationLink">
	<cfargument name="ApplicationLink" type="string" required="true" />
	<cfset variables.instance.ApplicationLink = arguments.ApplicationLink>
</cffunction>

</cfcomponent>