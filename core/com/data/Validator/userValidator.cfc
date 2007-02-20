
<cfcomponent hint="I am the validator object for the user object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Validator.userValidator">
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="validate" access="public" hint="I validate an  record" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="usersRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.usersRecord" />
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.usersRecord._getDictionary())#" />
		<cfset arguments.ErrorCollection = super.validate( argumentCollection=arguments ) />
		<cfset arguments.ErrorCollection = validateConfirmPassword( argumentCollection=arguments ) />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<cffunction name="validateConfirmPassword" access="public" hint="I validate that password matches" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="usersRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.usersRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.usersRecord._getDictionary())#" />
		<cfif arguments.usersRecord.getNewPassword().trim().length() GT 0 AND arguments.usersRecord.getNewPassword().trim() neq arguments.usersRecord.getOldPassword().trim()>
			<cfset arguments.ErrorCollection.addError( 'users.PASSWORD.doNotMatch' ) />
		</cfif>
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<!--- TODO: add validation for unique userid --->
	<!--- validateID - Since ID is auto generated, we do not need validation --->
	<cffunction name="validateID" access="public" hint="I validate the ID field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="usersRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.usersRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.usersRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
</cfcomponent>
	
