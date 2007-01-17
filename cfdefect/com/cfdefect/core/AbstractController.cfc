<cfcomponent output="false" displayname="AbstractController" hint="">

<cffunction name="init" returntype="cfdefect.com.cfdefect.core.AbstractController" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->

<!--- PRIVATE METHODS --->
<cffunction name="getBean" returntype="any" access="private" output="false" hint="">
	<cfargument name="name" type="string" required="true" hint="" />
	<cfreturn getBeanFactory().getBean( arguments.name ) />
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getBeanFactory" access="public" returntype="coldspring.beans.BeanFactory" output="false" hint="Getter for BeanFactory">
	<cfreturn variables.instance.BeanFactory />
</cffunction>

<cffunction name="setBeanFactory" access="public" returntype="void" output="false" hint="Setter for BeanFactory">
	<cfargument name="BeanFactory" type="coldspring.beans.BeanFactory" required="true" />
	<cfset variables.instance.BeanFactory = arguments.BeanFactory>
</cffunction>

<cffunction name="getUDF" access="private" returntype="cfdefect.com.cfdefect.core.UDF" output="false" hint="Getter for UDF">
	<cfreturn variables.instance.UDF />
</cffunction>

<cffunction name="setUDF" access="public" returntype="void" output="false" hint="Setter for UDF">
	<cfargument name="UDF" type="cfdefect.com.cfdefect.core.UDF" required="true" />
	<cfset variables.instance.UDF = arguments.UDF>
</cffunction>

</cfcomponent>