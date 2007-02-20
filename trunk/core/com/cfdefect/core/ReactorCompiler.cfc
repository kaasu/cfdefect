<cfcomponent output="false" displayname="ReactorCompiler" hint="">

<cffunction name="init" returntype="ReactorCompiler" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<cffunction name="getReactorConfiguration" access="public" returntype="any" output="false" hint="Getter for ReactorConfiguration">
	<cfreturn variables.instance.ReactorConfiguration />
</cffunction>

<cffunction name="setReactorConfiguration" access="public" returntype="void" output="false" hint="Setter for ReactorConfiguration">
	<cfargument name="ReactorConfiguration" type="any" required="true" />
	<cfset variables.instance.ReactorConfiguration = arguments.ReactorConfiguration>
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="compile" returntype="void" access="public" output="true" hint="">
	<cfargument name="deleteFirst" type="boolean" default="true" hint="" />
	<cfset var local =  StructNew() />
	<cfset var i =  "" />
	<cfsetting requesttimeout="10000" />
	<cfset local.rFactory = CreateObject( 'component', 'reactor.ReactorFactory' ).init( getReactorConfiguration() )>
	<cfset local.objects = getReactorConfiguration().getObjectNames() />
	<cfset local.projectName = getReactorConfiguration().getProject() />
	<cfset local.projectPath = ExpandPath( '/reactor/project/' & local.projectName ) />
	<cfset local.tickStart = getTickCount() />
	<!--- <cfif arguments.deleteFirst and DirectoryExists( local.projectPath )>
		<cfdirectory action="delete" directory="#local.projectPath#" recurse="true" />
	</cfif> --->
	<cfoutput>
		Generating Reactor objects for project #local.projectName# (#ArrayLen( local.objects )# object tags):<br><br>
		<cfflush />
		<cfloop from="1" to="#arrayLen( local.objects )#" index="i">
			<cfset local.objectXML = getReactorConfiguration().getObjectConfig( local.objects[i] ).object />
			<cfif StructKeyExists( local.objectXML.XMLAttributes, 'alias' )>
				<cfset local.thisObj = local.objectXML.XMLAttributes.alias>
			<cfelse>
				<cfset local.thisObj = local.objectXML.XMLAttributes.name>
			</cfif> 
			&nbsp;&nbsp;&nbsp;&nbsp;(#i#) Generating objects for: #local.thisObj#<br> <cfflush />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Record object...<br><cfflush />
			<cfset local.rFactory.createRecord( local.thisObj )>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gateway object...<br><cfflush />
			<cfset local.rFactory.createGateway( local.thisObj )>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Metadata object...<br><cfflush />
			<cfset local.rFactory.createMetadata( local.thisObj )>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Transfer object...<br><cfflush />
			<cfset local.rFactory.createTo( local.thisObj )>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DAO object...<br><cfflush />
			<cfset local.rFactory.createDao( local.thisObj )>
			&nbsp;&nbsp;&nbsp;&nbsp;Object #local.thisObj# done!<br><br><cfflush />
		</cfloop>
		Finished generating #arrayLen( local.objects )# Reactor object sets for project #local.projectName# in #(getTickCount() - local.tickStart) / 1000# seconds.<br><br>
	</cfoutput>
</cffunction>


<!--- PRIVATE METHODS --->
<cffunction name="throwBadConfigPath" access="private" returntype="void" output="false">
	<cfargument name="config" type="string" required="true" hint="" />
	<cfthrow 	type="ReactorCompiler.BadConfigPath"
			 	message="Bath path to config"
				detail="You have specified an invalid path to your Reactor Config File (#arguments.config#)." />	
</cffunction>
<!--- GETTER & SETTER --->
<cffunction name="getConfig" access="public" returntype="string" output="false" hint="Getter for Config">
	<cfreturn variables.instance.Config />
</cffunction>

<cffunction name="setConfig" access="public" returntype="void" output="false" hint="Setter for Config">
	<cfargument name="Config" type="string" required="true" />
	<cfset variables.instance.Config = arguments.Config>
</cffunction>


</cfcomponent>