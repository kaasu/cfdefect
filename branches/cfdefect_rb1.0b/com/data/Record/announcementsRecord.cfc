
<cfcomponent hint="I am the database agnostic custom Record object for the announcements object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Record.announcementsRecord" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<!--- beforeSave --->
	<cffunction name="beforeSave" access="private" hint="I am code executed before saving the record." output="false" returntype="void">
		<cfset super.beforeSave() />
		<cfif getID() eq '' OR getID() eq 0>
			<cfset setID( CreateUUID() ) />
		</cfif>
		<cfset setUserIDFK( _getBean( 'SecurityService' ).getUser().getID() ) />
		<cfset setPosted( Now() ) />
	</cffunction>
</cfcomponent>
	
