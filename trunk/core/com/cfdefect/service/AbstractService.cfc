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

<!--- <cffunction name="getAllRecords" returntype="query" access="public" output="false" hint="">
	<cfthrow 	type="AbstractSerice.MethodNotImplemented"
				message="Child classes should implement this method."
				detail="getAllRecords failed in #getMetaData( this ).name# as I have not implemented this yet." />
</cffunction> --->

<!--- PUBLIC METHODS --->
<cffunction name="getAll" returntype="query" access="public" output="false" hint="">
	<cfreturn getReactorFactory().createGateway( getTableName() ).getAllRecords(  applicationid = getApplicationId() ) />
</cffunction>

<cffunction name="getRecord" returntype="reactor.base.AbstractRecord" access="public" output="false" hint="">
	<cfargument name="id" type="string" default="0" hint="" />
	<cfreturn getReactorFactory().createRecord( getTableName() ).load( 	applicationid = getApplicationId(),
																		id = arguments.id ) />
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
			<cfset getReactorFactory().createRecord( getTableName() ).load( 	applicationid=getApplicationId(),
																				id=arguments.idsTobeDeleted[i] 
																			).delete( useTransaction=false ) />
		</cfloop>
	</cftransaction>
</cffunction>

<!--- PRIVATE METHODS --->
<cffunction name="getApplicationID" returntype="string" access="private" output="false" hint="">
	<cfreturn getApplicationConfiguration().getAppID() />
</cffunction>

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

<cffunction name="getApplicationConfiguration" access="private" returntype="cfdefect.com.cfdefect.config.ApplicationConfiguration" output="false" hint="Getter for ApplicationConfiguration">
	<cfreturn variables.instance.ApplicationConfiguration />
</cffunction>

<cffunction name="setApplicationConfiguration" access="public" returntype="void" output="false" hint="Setter for ApplicationConfiguration">
	<cfargument name="ApplicationConfiguration" type="cfdefect.com.cfdefect.config.ApplicationConfiguration" required="true" />
	<cfset variables.instance.ApplicationConfiguration = arguments.ApplicationConfiguration>
</cffunction>
</cfcomponent>