<cfcomponent output="false" displayname="ApplicationConfiguration" hint="">

<cffunction name="init" returntype="cfdefect.com.cfdefect.config.ApplicationConfiguration" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<cffunction name="configure" returntype="void" access="public" output="false" hint="I am called by ColdSpring during initialization.">
	<cfset var appRecord =  getReactorFactory().createRecord( 'application' ) />
	<cfif getAppKey().trim().length() GT 0>
		<cfset appRecord.load( id = Hash( getAppKey() ) ) />
	<cfelse>
		<cfset appRecord.load( id = Hash( getAppURL() ) )>
	</cfif>
	<cfif NOT appRecord.exists()>
		<cftransaction>
			<cfset appRecord.setTitle( getAppTitle() ) />
			<cfset loadData( appRecord ) />
			<cfset appRecord.save( useTransaction=false ) />
		</cftransaction>
	</cfif>
	<cfset setAppKey( appRecord.getID() ) />
</cffunction>

<cffunction name="loadData" returntype="void" access="private" output="false" hint="">
	<cfargument name="appRecord" type="reactor.base.AbstractRecord" required="true" hint="" />
	<cfset var local = StructNew() />
	<cfset var i = '' />
	<!--- <cfset local.dataSetXML = XMLParse( getDataSet() ) /> --->
	<cfset local.tables = XMLSearch( XMLParse( getDataSet() ), '//dataset/table' ) />
	<cfloop from="1" to="#ArrayLen( local.tables )#" index="i">
	<!--- <cfloop from="1" to="1" index="i"> --->
		<cfset local.tableName = local.tables[i].XMLAttributes.name />
		<cfset local.hasIterator = true />
		<cfif StructKeyExists( local.tables[i].XMLAttributes, 'iterator' )>
			<cfset local.hasIterator = local.tables[i].XMLAttributes.iterator />
		</cfif>
		<cfinvoke component="#getReactorFactory().createGateway( local.tableName )#" method="deleteByFields">
			<cfinvokeargument name="applicationid" value="#arguments.appRecord.getID()#" />
		</cfinvoke>
		
		<cfif local.hasIterator>
			<cfinvoke component="#arguments.appRecord#" method="get#local.tableName#Iterator" returnvariable="local.iterator" />	
			<!--- Reactor's deleteAll on Iterator doesn't have an argument for useTransaction so we are manually looping through the iterator and deleting records --->
			<!--- <cfloop condition="#local.iterator.hasMore()#">
				<cfset local.iterator.getAt(1).delete( useTransaction=false ) />
			</cfloop> --->
			<cfset local.rows = XMLSearch( local.tables[i], '//dataset/table[@name="' &  local.tableName & '"]/*' ) />
			<cfloop from="1" to="#ArrayLen( local.rows )#" index="j">
				<cfinvoke component="#local.iterator#" method="add">
					<cfinvokeargument name="applicationid" value="#arguments.appRecord.getID()#" />
					<cfinvokeargument name="id" value="0" />
					<cfloop from="1" to="#ArrayLen( local.rows[j].XMLChildren )#" index="k">
						<cfinvokeargument name="#local.rows[j].XMLChildren[k].XMLAttributes.name#" value="#local.rows[j].XMLChildren[k].XMLAttributes.value#" />		
					</cfloop>
				</cfinvoke>
			</cfloop> 
		</cfif>
		
	</cfloop>
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getVersion" returntype="string" access="public" output="false" hint="">
	<cfreturn '1.0b' />
</cffunction>

<cffunction name="getAppURL" access="public" returntype="string" output="false" hint="Getter for AppURL">
	<cfreturn variables.instance.AppURL />
</cffunction>

<cffunction name="setAppURL" access="public" returntype="void" output="false" hint="Setter for AppURL">
	<cfargument name="AppURL" type="string" required="true" />
	<cfset variables.instance.AppURL = arguments.AppURL>
</cffunction>

<cffunction name="getAppKey" access="public" returntype="string" output="false" hint="Getter for AppKey">
	<cfreturn variables.instance.AppKey />
</cffunction>

<cffunction name="setAppKey" access="public" returntype="void" output="false" hint="Setter for AppKey">
	<cfargument name="AppKey" type="string" required="true" />
	<cfset variables.instance.AppKey = arguments.AppKey>
</cffunction>

<cffunction name="getAppLink" access="public" returntype="string" output="false" hint="Getter for AppLink">
	<cfreturn variables.instance.AppLink />
</cffunction>

<cffunction name="setAppLink" access="public" returntype="void" output="false" hint="Setter for AppLink">
	<cfargument name="AppLink" type="string" required="true" />
	<cfset variables.instance.AppLink = arguments.AppLink>
</cffunction>

<cffunction name="getAppTitle" access="public" returntype="string" output="false" hint="Getter for AppTitle">
	<cfreturn variables.instance.AppTitle />
</cffunction>

<cffunction name="setAppTitle" access="public" returntype="void" output="false" hint="Setter for AppTitle">
	<cfargument name="AppTitle" type="string" required="true" />
	<cfset variables.instance.AppTitle = arguments.AppTitle>
</cffunction>

<cffunction name="getAttachmentPath" access="public" returntype="string" output="false" hint="Getter for AttachmentPath">
	<cfreturn variables.instance.AttachmentPath />
</cffunction>

<cffunction name="setAttachmentPath" access="public" returntype="void" output="false" hint="Setter for AttachmentPath">
	<cfargument name="AttachmentPath" type="string" required="true" />
	<cfset variables.instance.AttachmentPath = arguments.AttachmentPath>
</cffunction>

<cffunction name="getXSLTPath" access="public" returntype="string" output="false" hint="Getter for XSLTPath">
	<cfreturn variables.instance.XSLTPath />
</cffunction>

<cffunction name="setXSLTPath" access="public" returntype="void" output="false" hint="Setter for XSLTPath">
	<cfargument name="XSLTPath" type="string" required="true" />
	<cfset variables.instance.XSLTPath = arguments.XSLTPath>
</cffunction>

<cffunction name="getDataSet" access="public" returntype="string" output="false" hint="Getter for DataSet">
	<cfreturn variables.instance.DataSet />
</cffunction>

<cffunction name="setDataSet" access="public" returntype="void" output="false" hint="Setter for DataSet">
	<cfargument name="DataSet" type="string" required="true" />
	<cfset variables.instance.DataSet = ExpandPath( arguments.DataSet ) />
</cffunction>

<cffunction name="getMailServer" access="public" returntype="string" output="false" hint="Getter for MailServer">
	<cfreturn variables.instance.MailServer />
</cffunction>

<cffunction name="setMailServer" access="public" returntype="void" output="false" hint="Setter for MailServer">
	<cfargument name="MailServer" type="string" required="true" />
	<cfset variables.instance.MailServer = arguments.MailServer>
</cffunction>

<cffunction name="getMailPort" access="public" returntype="string" output="false" hint="Getter for MailPort">
	<cfreturn variables.instance.MailPort />
</cffunction>

<cffunction name="setMailPort" access="public" returntype="void" output="false" hint="Setter for MailPort">
	<cfargument name="MailPort" type="string" required="true" />
	<cfset variables.instance.MailPort = arguments.MailPort>
</cffunction>

<cffunction name="getMailDefaultFrom" access="public" returntype="string" output="false" hint="Getter for MailDefaultFrom">
	<cfreturn variables.instance.MailDefaultFrom />
</cffunction>

<cffunction name="setMailDefaultFrom" access="public" returntype="void" output="false" hint="Setter for MailDefaultFrom">
	<cfargument name="MailDefaultFrom" type="string" required="true" />
	<cfset variables.instance.MailDefaultFrom = arguments.MailDefaultFrom>
</cffunction>

<cffunction name="getMailCSS" access="public" returntype="string" output="false" hint="Getter for MailCSS">
	<cfreturn variables.instance.MailCSS />
</cffunction>

<cffunction name="setMailCSS" access="public" returntype="void" output="false" hint="Setter for MailCSS">
	<cfargument name="MailCSS" type="string" required="true" />
	<cfset variables.instance.MailCSS = arguments.MailCSS>
</cffunction>

<cffunction name="getReactorFactory" access="public" returntype="reactor.ReactorFactory" output="false" hint="Getter for ReactorFactory">
	<cfreturn variables.instance.ReactorFactory />
</cffunction>

<cffunction name="setReactorFactory" access="public" returntype="void" output="false" hint="Setter for ReactorFactory">
	<cfargument name="ReactorFactory" type="reactor.ReactorFactory" required="true" />
	<cfset variables.instance.ReactorFactory = arguments.ReactorFactory>
</cffunction>

</cfcomponent>