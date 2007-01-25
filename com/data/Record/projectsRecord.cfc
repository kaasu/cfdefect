
<cfcomponent hint="I am the database agnostic custom Record object for the projects object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Record.projectsRecord" >
	<!--- Place custom code here, it will not be overwritten --->
	<cffunction name="init" access="public" hint="I configure and return this record object." output="false" returntype="any" _returntype="reactor.project.cfdefect.Record.projectsRecord">
		<cfargument name="ProjectLociID" type="string" default="" hint="" />
		<cfargument name="ProjectUsersID" type="string" default="" hint="" />
		<cfset setProjectLociID( ListChangeDelims( arguments.ProjectLociID,  '~' ) ) />
		<cfset setProjectUsersID( ListChangeDelims( arguments.ProjectUsersID,  '~' ) ) />
		<cfreturn super.init( argumentCollection=arguments ) />
	</cffunction>
	
	<cffunction name="save" access="public" hint="I save the record." output="false" returntype="void">
		<cfargument name="useTransaction" hint="I indicate if this save should be executed within a transaction." required="no" type="any" _type="boolean" default="true" />
		<cftransaction>
			<cfset super.save( useTransaction=false ) />
		</cftransaction>
	</cffunction>	
	
	<!--- beforeSave --->
	<cffunction name="beforeSave" access="private" hint="I am code executed before saving the record." output="false" returntype="void">
		<cfset var local =  StructNew() />
		<cfset var i =  "" />
		
		<cfset super.beforeSave() />
		
		<!--- generate id for new records --->
		<cfif getID() eq 0>
			<cfset setID( CreateUUID() ) />
		</cfif>
		<!--- save project loci --->
		<cfset saveRelatedRecords( 'projectsProjectLoci', getID(), getProjectLociID(), 'projectidfk', 'projectlociidfk' ) />
		<!--- save project users --->
		<cfset saveRelatedRecords( 'projectUsers', getID(), getProjectUsersID(), 'projectidfk', 'useridfk' ) />

	</cffunction>

	<cffunction name="saveRelatedRecords" returntype="void" access="private" output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="" />
		<cfargument name="id" type="uuid" required="true" hint="" />
		<cfargument name="values" type="string" required="true" hint="" />
		<cfargument name="field1" type="string" required="true" hint="" />
		<cfargument name="field2" type="string" required="true" hint="" />
		
		<cfset var local =  StructNew() />
		<cfset var i =  "" />
		
		<cfinvoke method="get#arguments.name#Iterator" returnvariable="local.iterator" />
		
		<!--- delete existing records --->
		<cfset deleteRelatedRecords( arguments.name, arguments.id, arguments.field1 ) />
		
		<!--- load iterator --->
		<cfloop list="#arguments.values#" index="i" delimiters="~">
			<cfinvoke component="#_getReactorFactory().createRecord( arguments.name )#" method="init" returnvariable="local.tempRecord">
				<cfinvokeargument name="#arguments.field1#" value="#arguments.id#" />
				<cfinvokeargument name="#arguments.field2#" value="#i#" />
			</cfinvoke>
			<cfset local.iterator.add( local.tempRecord )>
		</cfloop>
		
		<!--- save iterator --->
		<cfset local.iterator.save( useTransaction=false ) />	
		
	</cffunction>
	
	<cffunction name="deleteRelatedRecords" returntype="void" access="private" output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="" />
		<cfargument name="id" type="uuid" required="true" hint="" />
		<cfargument name="field" type="string" required="true" hint="" />
		<cfinvoke component="#_getReactorFactory().createGateway( arguments.name )#" method="deleteByFields">
			<cfinvokeargument name="#arguments.field#" value="#arguments.id#" />
		</cfinvoke>
		
	</cffunction>
	
	<!--- afterLoad --->
	<cffunction name="afterLoad" access="private" hint="I am code executed after loading the record." output="false" returntype="void">
		<cfset super.afterLoad() />
		<!--- not a new record --->
		<cfif getID() neq '' AND getID() neq 0>
			<cfset setProjectLociID( getProjectlociIterator().getValueList(  'id', '~' ) ) />
			<cfset setProjectUsersID( getUsersIterator().getValueList(  'id', '~' ) ) />
		</cfif>
	</cffunction>
	
	<!--- afterDelete --->
	<cffunction name="afterDelete" access="private" hint="I am code executed after deleting the record." output="false" returntype="void">
		<!--- delete project users --->
		<cfset deleteRelatedRecords( 'projectUsers', getID(), 'projectidfk' ) />
		<!--- delete project loci --->
		<cfset deleteRelatedRecords( 'projectsProjectLoci', getID(), 'projectidfk' ) />
		<!--- delete project announcements --->
		<cfset deleteRelatedRecords( 'announcements', getID(), 'projectidfk' ) />
		<!--- delete project issues --->
		<cfset deleteRelatedRecords( 'issues', getID(), 'projectidfk' ) />
		<!--- call super method --->
		<cfset super.afterDelete() />
	</cffunction>
	
	<cffunction name="getProjectLociID" access="public" returntype="string" output="false" hint="Getter for ProjectLociID">
		<cfreturn _getTO().ProjectLociID />
	</cffunction>
	
	<cffunction name="setProjectLociID" access="public" returntype="void" output="false" hint="Setter for ProjectLociID">
		<cfargument name="ProjectLociID" type="string" required="true" hint="ProjectLociID" />
		<cfset _getTO().ProjectLociID = arguments.ProjectLociID>
	</cffunction>
	
	<cffunction name="getProjectUsersID" access="public" returntype="string" output="false" hint="Getter for ProjectUsersID">
		<cfreturn _getTO().ProjectUsersID />
	</cffunction>
	
	<cffunction name="setProjectUsersID" access="public" returntype="void" output="false" hint="Setter for ProjectUsersID">
		<cfargument name="ProjectUsersID" type="string" required="true" hint="ProjectUsersID" />
		<cfset _getTO().ProjectUsersID = arguments.ProjectUsersID>
	</cffunction>
	
</cfcomponent>
	
