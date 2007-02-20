
<cfcomponent hint="I am the mysql4 custom Metadata object for the user object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="userMetadata">
	<!--- Place custom code here, it will not be overwritten --->

	<cfset variables.metadata.owner = "" />
	<cfset variables.metadata.dbms = "mysql4" />
	
</cfcomponent>
	
