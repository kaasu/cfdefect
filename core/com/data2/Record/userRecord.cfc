
<cfcomponent hint="I am the database agnostic custom Record object for the user object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.cfdefect.Record.userRecord" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="init" access="public" hint="I configure and return this record object." output="false" returntype="any" _returntype="reactor.project.cfdefect.Record.userRecord">
		<cfargument name="UserProjects" type="string" default="" hint="" />
		<cfargument name="UserProjectEmails" type="string" default="" hint="" />
		<cfargument name="Admin" type="string" default="false" hint="" />
		<cfargument name="newPassword" type="string" default="" hint="" />
		<cfargument name="oldPassword" type="string" default="" hint="" />
		<cfargument name="fromPreference" type="string" default="false" hint="" />
		<cfset setUserProjects( arguments.UserProjects ) />
		<cfset setUserProjectEmails( arguments.UserProjectEmails ) />
		<cfset setAdmin( arguments.Admin ) />
		<cfset setNewPassword( arguments.newPassword ) />
		<cfset setOldPassword( arguments.oldPassword ) />
		<cfset setFromPreference( arguments.fromPreference ) />
		<cfreturn super.init( argumentCollection=arguments ) />
	</cffunction>
	
	<!--- save --->
	<cffunction name="save" access="public" hint="I save the record." output="false" returntype="void">
		<cfargument name="useTransaction" hint="I indicate if this save should be executed within a transaction." required="no" type="any" _type="boolean" default="true" />
		<cftransaction>
			<cfset super.save( useTransaction=false ) />
		</cftransaction>
	</cffunction>	
		
	<!--- afterDelete --->
	<cffunction name="afterDelete" access="private" hint="I am code executed after deleting the record." output="false" returntype="void">
		<!--- delete project users --->
		<cfset deleteRelatedRecords( 'ProjectUser' ) />
		<!--- delete user projects  email --->
		<cfset deleteRelatedRecords( 'ProjectUserEmail' ) />
		<!--- call super method --->
		<cfset super.afterDelete() />
	</cffunction>
	
	<!--- beforeSave --->
	<cffunction name="beforeSave" access="private" hint="I am code executed before saving the record." output="false" returntype="void">
		<cfset var local =  StructNew() />
		<cfset var i =  "" />
		<cfset super.beforeSave() />
		<cfif NOT getFromPreference()>
			<!--- generate id for new records --->
			<cfif getID() eq 0>
				<cfset setID( CreateUUID() ) />
			</cfif>
			
			<!--- save user projects  --->
			<cfset saveRelatedRecords( 'ProjectUser', getUserProjects(), 'projectidfk' ) />
		
			<!--- save user projects  email --->
			<cfset saveRelatedRecords( 'ProjectUserEmail', filterProjectEmailUsers( getUserProjects(), getUserProjectEmails() ), 'projectidfk' ) />			
		
		<cfelse>
			<!--- if there is a new password - from preferences then update the userpassword with this one. --->
			<cfif getNewPassword().trim().length() GT 0>
				<cfset setPassword( getNewPassword().trim() ) />
			</cfif>
			
			<!--- save user projects  email --->
			<cfset saveRelatedRecords( 'ProjectUserEmail', getUserProjectEmails(), 'projectidfk' ) />			
			
		</cfif>
		
	</cffunction>
	
	
	<!--- afterLoad --->
	<cffunction name="afterLoad" access="private" hint="I am code executed after loading the record." output="false" returntype="void">
		<!--- not a new record --->
		<cfif getID() neq 0>
			<cfset setUserProjects( getProjectIterator().getValueList( 'id' ) ) />
			<cfset setUserProjectEmails( getUserEmailIterator().getValueList( 'id' ) ) />
		</cfif>
	</cffunction>
	
	<cffunction name="saveRelatedRecords" returntype="void" access="private" output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="" />
		<cfargument name="values" type="string" required="true" hint="" />
		<cfargument name="field" type="string" required="true" hint="" />
			
		<cfset var local =  StructNew() />
		<cfset var i =  "" />

		<cfinvoke method="get#arguments.name#Iterator" returnvariable="local.iterator" />
		
		<!--- delete existing records --->
		<cfset deleteRelatedRecords( arguments.name ) />
		
		<!--- load iterator --->
		<cfloop list="#arguments.values#" index="i">
			<cfinvoke component="#_getReactorFactory().createRecord( arguments.name )#" method="init" returnvariable="local.tempRecord">
				<cfinvokeargument name="useridfk" value="#getID()#" />
				<cfinvokeargument name="#arguments.field#" value="#i#" />
			</cfinvoke>
			<cfset local.iterator.add( local.tempRecord )>
		</cfloop>
		
		<!--- save iterator --->
		<cfset local.iterator.save( useTransaction=false ) />	
		
	</cffunction>
	
	<cffunction name="deleteRelatedRecords" returntype="void" access="private" output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="" />
		<cfargument name="id" type="uuid" default="#getID()#" hint="" />
		<cfargument name="field" type="string" default="useridfk" hint="" />
		<cfinvoke component="#_getReactorFactory().createGateway( arguments.name )#" method="deleteByFields">
			<cfinvokeargument name="#arguments.field#" value="#arguments.id#" />
		</cfinvoke>
	</cffunction>
	
	<cffunction name="filterProjectEmailUsers" returntype="string" access="private" output="false" hint="">
		<cfargument name="UserProjects" type="string" required="true" hint="UserProjects" />
		<cfargument name="UserProjectEmails" type="string" required="true" hint="UserProjectEmails" />
		<cfset var i =  "" />
		
		<cfloop list="#arguments.UserProjectEmails#" index="i">
			<cfif NOT ListFindNoCase( arguments.UserProjects, i )>
				<cfset arguments.UserProjectEmails = ListDeleteAt( arguments.UserProjectEmails, ListFind( arguments.UserProjectEmails, i ) )>
			</cfif>
		</cfloop>
		<cfreturn arguments.UserProjectEmails />
	</cffunction>
		
	<cffunction name="getUserProjects" access="public" returntype="string" output="false" hint="Getter for UserProjects">
		<cfreturn _getTO().UserProjects />
	</cffunction>
	
	<cffunction name="setUserProjects" access="public" returntype="void" output="false" hint="Setter for UserProjects">
		<cfargument name="UserProjects" type="string" required="true" hint="UserProjects" />
		<cfset _getTO().UserProjects = arguments.UserProjects>
	</cffunction>
	
	
	<cffunction name="getUserProjectEmails" access="public" returntype="string" output="false" hint="Getter for UserProjectEmails">
		<cfreturn _getTO().UserProjectEmails />
	</cffunction>
	
	<cffunction name="setUserProjectEmails" access="public" returntype="void" output="false" hint="Setter for UserProjectEmails">
		<cfargument name="UserProjectEmails" type="string" required="true" hint="UserProjectEmails" />
		<cfset _getTO().UserProjectEmails = arguments.UserProjectEmails>
	</cffunction>
	
	<cffunction name="getAdmin" access="public" returntype="boolean" output="false" hint="Getter for Admin">
		<cfreturn _getTO().Admin />
	</cffunction>
	
	<cffunction name="setAdmin" access="public" returntype="void" output="false" hint="Setter for Admin">
		<cfargument name="Admin" type="boolean" required="true" hint="Admin" />
		<cfset _getTO().Admin = arguments.Admin>
	</cffunction>
	
	<cffunction name="getNewPassword" access="public" returntype="string" output="false" hint="Getter for NewPassword">
		<cfreturn _getTO().NewPassword />
	</cffunction>
	
	<cffunction name="setNewPassword" access="public" returntype="void" output="false" hint="Setter for NewPassword">
		<cfargument name="NewPassword" type="string" required="true" hint="NewPassword" />
		<cfset _getTO().NewPassword = arguments.NewPassword>
	</cffunction>
	
	<cffunction name="getOldPassword" access="public" returntype="string" output="false" hint="Getter for OldPassword">
		<cfreturn _getTO().OldPassword />
	</cffunction>
	
	<cffunction name="setOldPassword" access="public" returntype="void" output="false" hint="Setter for OldPassword">
		<cfargument name="OldPassword" type="string" required="true" hint="OldPassword" />
		<cfset _getTO().OldPassword = arguments.OldPassword>
	</cffunction>
	
	<cffunction name="getFromPreference" access="public" returntype="string" output="false" hint="Getter for FromPreference">
		<cfreturn _getTO().FromPreference />
	</cffunction>
	
	<cffunction name="setFromPreference" access="public" returntype="void" output="false" hint="Setter for FromPreference">
		<cfargument name="FromPreference" type="string" required="true" hint="FromPreference" />
		<cfset _getTO().FromPreference = arguments.FromPreference>
	</cffunction>

</cfcomponent>
	
