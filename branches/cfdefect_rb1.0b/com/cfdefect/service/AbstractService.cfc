<cfcomponent output="false" displayname="AbstractService" hint="">

<cffunction name="init" returntype="AbstractService" output="false" access="public" hint="Constructor">
	<cfargument name="tableName" type="string" required="true" hint="" />
	<cfargument name="columns" type="string" default="" hint="" />
	<cfset setTableName( arguments.tableName ) />
	<cfset setColumns( arguments.columns ) />
	<cfreturn this />
</cffunction>

<!--- ABSTRACT METHODS --->
<cffunction name="getSupportingData" returntype="struct" access="public" output="false" hint="">
	<cfthrow 	type="AbstractSerice.MethodNotImplemented"
				message="Child classes should implement this method."
				detail="getSupporting Data failed in #getMetaData( this ).name# as I have not implemented this yet." />
</cffunction>

<cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
	<cfthrow 	type="AbstractSerice.MethodNotImplemented"
				message="Child classes should implement this method."
				detail="getAllRecords failed in #getMetaData( this ).name# as I have not implemented this yet." />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getAll" returntype="query" access="public" output="false" hint="">
	<cfreturn getReactorFactory().createGateway( getTableName() ).getAll() />
</cffunction>

<cffunction name="getRecord" returntype="reactor.base.AbstractRecord" access="public" output="false" hint="">
	<cfargument name="id" type="string" default="0" hint="" />
	<!--- <cfset var record = getReactorFactory().createRecord( getTableName() ) />
	<cfif StructKeyExists( arguments, 'id' ) AND arguments.id neq 0>
		<cfset record.load( id=arguments.id ) />
	</cfif> --->
	<cfreturn getReactorFactory().createRecord( getTableName() ).load( id=arguments.id ) />
</cffunction>

<cffunction name="validateAndProcess" returntype="reactor.base.AbstractRecord" access="public" output="false" hint="">
	<cfargument name="data" type="struct" required="true" hint="" />
	<cfset var record = getReactorFactory().createRecord( getTableName() ).init( argumentCollection=arguments.data ) />	
	<cfset record.validate() />
	<cfif NOT record._getErrorCollection().hasErrors()>
		<cfset record.save() />
	</cfif>
	<cfreturn record />
</cffunction>

<cffunction name="delete" returntype="void" access="public" output="false" hint="">
	<cfargument name="idsTobeDeleted" type="string" required="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset var i =  "" />
	<cfset arguments.idsTobeDeleted = ListToArray( arguments.idsTobeDeleted ) />
	<cftransaction>
		<cfloop from="1" to="#ArrayLen( arguments.idsTobeDeleted )#" index="i">
			<cfset getReactorFactory().createRecord( getTableName() ).load( id=arguments.idsTobeDeleted[i] ).delete( useTransaction=false ) />
		</cfloop>
	</cftransaction>
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getTableName" access="private" returntype="string" output="false" hint="Getter for TableName">
	<cfreturn variables.instance.TableName />
</cffunction>

<cffunction name="setTableName" access="private" returntype="void" output="false" hint="Setter for TableName">
	<cfargument name="TableName" type="string" required="true" />
	<cfset variables.instance.TableName = arguments.TableName>
</cffunction>

<cffunction name="getColumns" access="public" returntype="string" output="false" hint="Getter for Columns">
	<cfreturn variables.instance.Columns />
</cffunction>

<cffunction name="setColumns" access="private" returntype="void" output="false" hint="Setter for Columns">
	<cfargument name="Columns" type="string" required="true" />
	<cfset variables.instance.Columns = arguments.Columns>
</cffunction>

<cffunction name="getReactorFactory" access="private" returntype="reactor.ReactorFactory" output="false" hint="Getter for ReactorFactory">
	<cfreturn variables.instance.ReactorFactory />
</cffunction>

<cffunction name="setReactorFactory" access="public" returntype="void" output="false" hint="Setter for ReactorFactory">
	<cfargument name="ReactorFactory" type="reactor.ReactorFactory" required="true" />
	<cfset variables.instance.ReactorFactory = arguments.ReactorFactory>
</cffunction>

</cfcomponent>