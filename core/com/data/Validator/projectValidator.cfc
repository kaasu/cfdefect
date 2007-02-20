
<cfcomponent hint="I am the validator object for the project object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Validator.projectValidator">
	<!--- Place custom code here, it will not be overwritten --->
	
	<!--- Place custom code here, it will not be overwritten --->
	<cffunction name="validate" access="public" hint="I validate an  record" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="projectsRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.projectsRecord" />
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.projectsRecord._getDictionary())#" />
		<cfset arguments.ErrorCollection = super.validate( argumentCollection=arguments ) />	
		<cfset arguments.ErrorCollection = validateProjectLociID( argumentCollection=arguments ) />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<cffunction name="validateProjectLociID" access="public" hint="I validate the ID field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="projectsRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.projectsRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.projectsRecord._getDictionary())#" />
		<cfif arguments.projectsRecord.getProjectLociID().trim().length() LTE 0>
			<cfset arguments.ErrorCollection.addError( 'projects.PROJECTLOCIID.REQUIRED' )>
		</cfif>
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<!--- validateID - Since ID is auto generated, we do not need validation --->
	<cffunction name="validateID" access="public" hint="I validate the ID field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="projectsRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.projectsRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.projectsRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
</cfcomponent>
	
