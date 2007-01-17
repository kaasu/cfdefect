<!---
	fusebox.appinit.cfm is included by the framework when the application is
	started, i.e., on the very first request (in production mode) or whenever
	the framework is reloaded, either with development-full-load mode or when
	fusebox.load=true or fusebox.loadclean=true is specified.
	It is included within a cfsilent tag so it cannot generate output. It is
	intended to be for per-application initialization that can not easily be
	done in the appinit global fuseaction.
	It is included inside a conditional lock, ensuring that only one request
	can execute this file.
	
	For example, if you are sharing application variables between a Fusebox
	application and a non-Fusebox application, you can initialize them here
	and then cfinclude this file into your non-Fusebox application.
--->
<cfsilent>
<!--- cfset >
<cfif getPageContext().getRequest().isSecure()>
	<cfset applicationURL = 'https://'>
</cfif>
<cfset applicationURL = applicationURL & getPageContext().getRequest().getServerName().toString() />

<cfif getPageContext().getRequest().getServerPort() neq '80'>
	<cfset applicationURL = applicationURL &  ':' & getPageContext().getRequest().getServerPort()/>
</cfif>
<!--- <cfset applicationURL = applicationURL & '/'> --->
<!--- <cfset applicationURL = applicationURL & getPageContext().getRequest().getRequestURI() & '?' & myfusebox.getApplication().fuseactionVariable & '=' />  --->

<cfset applicationURL = applicationURL & getPageContext().getRequest().getRequestURI() />
<cfdump var="#applicationURL#"><cfabort> --->
<cfscript>
applicationURL = 'http://';
if ( getPageContext().getRequest().isSecure() ){
	applicationURL = 'https://';
}	
applicationURL = applicationURL & getPageContext().getRequest().getServerName();

if ( getPageContext().getRequest().getServerPort() neq '80' ){
	applicationURL = applicationURL &  ':' & getPageContext().getRequest().getServerPort();
}	
applicationURL = applicationURL & ListDeleteAt( getPageContext().getRequest().getRequestURI(), ListLen( getPageContext().getRequest().getRequestURI(), '/' ) , '/');
defaultProperties = StructNew();	
defaultProperties.applicationURL = applicationURL;
serviceFactory = CreateObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init ( defaultProperties=defaultProperties );
serviceFactory.loadBeans( beanDefinitionFileName=myFuseBox.getApplication().approotdirectory & '/config/appconfig.xml' );
myFusebox.getApplication().getApplicationData().put( COLDSPRING_FACTORY_NAME, serviceFactory );
application.serviceFactory = myFusebox.getApplication().getApplicationData().get( COLDSPRING_FACTORY_NAME ); 
//reactorCompiler = myFusebox.getApplication().getApplicationData().get( COLDSPRING_FACTORY_NAME ).getBean( 'reactorCompiler_remote' );
</cfscript>
</cfsilent>

