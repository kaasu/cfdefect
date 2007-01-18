<cfcomponent output="false" displayname="AbstractController" hint="I am an Abstract COntroller for Fusebox Controllers.">

<cffunction name="init" returntype="AbstractController" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PRIVATE METHODS --->
<cffunction name="getBean" returntype="any" access="private" output="false" hint="I return a ColdSpring bean. It is just a shorthand method.">
	<cfargument name="name" type="string" required="true" hint="" />
	<cfreturn getBeanFactory().getBean( arguments.name ) />
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getBeanFactory" access="private" returntype="coldspring.beans.BeanFactory" output="false" hint="Getter for BeanFactory">
	<cfreturn variables.instance.BeanFactory />
</cffunction>

<cffunction name="setBeanFactory" access="public" returntype="void" output="false" hint="Setter for BeanFactory">
	<cfargument name="BeanFactory" type="coldspring.beans.BeanFactory" required="true" />
	<cfset variables.instance.BeanFactory = arguments.BeanFactory>
</cffunction>

</cfcomponent>