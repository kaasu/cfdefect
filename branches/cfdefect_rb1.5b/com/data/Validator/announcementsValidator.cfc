
<cfcomponent hint="I am the validator object for the announcements object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Validator.announcementsValidator">
	<!--- Place custom code here, it will not be overwritten --->
	
	<!--- validatePOSTED - Overriden as we do not need any validation on posted date --->
	<cffunction name="validatePOSTED" access="public" hint="I validate the POSTED field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="announcementsRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.announcementsRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.announcementsRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<cffunction name="validateUSERIDFK" access="public" hint="I validate the USERIDFK field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="announcementsRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.announcementsRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.announcementsRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
</cfcomponent>
	
