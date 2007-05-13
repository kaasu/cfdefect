<cfcomponent output="false" displayname="AdminController" hint="" extends="AbstractController">

<cffunction name="init" returntype="AdminController" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getAllRecords" returntype="void" access="public" output="false" hint="I return all records for a type.">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset arguments.event.setValue( 'qAll', getBean( arguments.event.getValue( 'type' ) & 'Service' ).getAll() ) />
	<cfset arguments.event.setValue( 'columns', getBean( arguments.event.getValue( 'type' ) & 'Service' ).getColumns() ) />
</cffunction>

<cffunction name="getRecord" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var record = '' />
	<cfif NOT arguments.event.valueExists( 'recordObject' )>
		<cfset record = getBean( arguments.event.getValue( 'type' ) & 'Service' ).getRecord( id = arguments.event.getValue( 'id', '0' ) ) />
		<cfset arguments.event.setValue( 'recordObject', record ) />	
	</cfif>
</cffunction>

<cffunction name="getSupportingData" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<!--- we only need supporting data for user and projects --->
	<cfif ListFindNoCase( 'user~project~announcement', arguments.event.getValue( 'type' ) , '~' )>
		<cfif NOT arguments.event.valueExists( 'supportingData' )>
			<cfset arguments.event.setValue( 'supportingData', getBean( arguments.event.getValue( 'type' ) & 'Service' ).getSupportingData() ) />
		</cfif>
	</cfif>
</cffunction>

<cffunction name="validateAndProcess" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var data = arguments.event.getValue( 'UDF' ).getSimpleValuesFromStruct( arguments.event.getAllValues() ) />
	<cfset arguments.event.setValue( 'recordObject', getBean( arguments.event.getValue( 'type' ) & 'Service' ).validateAndProcess( data ) ) />
</cffunction>

<cffunction name="delete" returntype="void" access="public" output="false" hint="">
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset getBean( arguments.event.getValue( 'type' ) & 'Service' ).delete( arguments.event.getValue( 'chkid' ) ) />
</cffunction>

<!--- PRIVATE METHODS --->


</cfcomponent>