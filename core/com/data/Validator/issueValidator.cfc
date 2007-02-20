
<cfcomponent hint="I am the validator object for the issue object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Validator.issueValidator">
	<!--- Place custom code here, it will not be overwritten --->
	
	<!--- validateID - Since ID is auto generated, we do not need validation --->
	<cffunction name="validateID" access="public" hint="I validate the ID field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="issueRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.issueRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.issueRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<!--- validateCREATED --->
	<cffunction name="validateCREATED" access="public" hint="I validate the CREATED field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="issueRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.issueRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.issueRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<!--- validateUPDATED --->
	<cffunction name="validateUPDATED" access="public" hint="I validate the UPDATED field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="issueRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.issueRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.issueRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<!--- validateCREATORIDFK --->
	<cffunction name="validateCREATORIDFK" access="public" hint="I validate the CREATORIDFK field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="issueRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.issueRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.issueRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<!--- validatePUBLICID --->
	<cffunction name="validatePUBLICID" access="public" hint="I validate the PUBLICID field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="issueRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.issueRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.issueRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	<!--- validateHISTORY --->
	<cffunction name="validateHISTORY" access="public" hint="I validate the HISTORY field" output="false" returntype="any" _returntype="reactor.util.ErrorCollection">
		<cfargument name="issueRecord" hint="I am the Record to validate." required="no" type="any" _type="reactor.project.cfdefect.Record.issueRecord"/>
		<cfargument name="ErrorCollection" hint="I am the error collection to populate. If not provided a new collection is created." required="no" type="any" _type="reactor.util.ErrorCollection" default="#createErrorCollection(arguments.issueRecord._getDictionary())#" />
		<cfreturn arguments.ErrorCollection />
	</cffunction>
	
	
</cfcomponent>
	
