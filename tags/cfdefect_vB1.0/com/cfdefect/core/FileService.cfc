<cfcomponent output="false" displayname="FileService" hint="">

<cffunction name="init" returntype="FileService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<cffunction name="configure" returntype="void" access="public" output="false" hint="">
	<cfset setPath( getApplicationConfiguration().getConfig( 'attachmentPath' ) ) />
	<cfif NOT DirectoryExists( getPath() )>
		<cfdirectory action="create" directory="#getPath()#" />
	</cfif>
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="delete" returntype="void" access="public" output="false" hint="">
	<cfargument name="filename" type="string" required="true" hint="" />
	<cfif FileExists( getPath() & '\' & arguments.filename )>
		<cffile action="delete" file="#getPath()#\#arguments.filename#" />
	</cfif>
</cffunction>

<cffunction name="upload" returntype="struct" access="public" output="false" hint="">
	<cfargument name="fileField" required="true" type="string" />
	<cfset var fileResult =  '' />
	<cffile action="upload" filefield="#arguments.fileField#" destination="#getPath()#" nameconflict="makeunique" result="fileResult" />
	<cfreturn fileResult />
</cffunction>
<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getApplicationConfiguration" access="public" returntype="cfdefect.com.cfdefect.core.ApplicationConfiguration" output="false" hint="Getter for ApplicationConfiguration">
	<cfreturn variables.instance.ApplicationConfiguration />
</cffunction>

<cffunction name="setApplicationConfiguration" access="public" returntype="void" output="false" hint="Setter for ApplicationConfiguration">
	<cfargument name="ApplicationConfiguration" type="cfdefect.com.cfdefect.core.ApplicationConfiguration" required="true" />
	<cfset variables.instance.ApplicationConfiguration = arguments.ApplicationConfiguration>
</cffunction>

<cffunction name="getPath" access="public" returntype="string" output="false" hint="Getter for Path">
	<cfreturn variables.instance.Path />
</cffunction>

<cffunction name="setPath" access="public" returntype="void" output="false" hint="Setter for Path">
	<cfargument name="Path" type="string" required="true" />
	<cfset variables.instance.Path = ExpandPath( arguments.Path ) />
</cffunction>

</cfcomponent>