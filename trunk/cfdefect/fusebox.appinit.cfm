<!---
Copyright 2006 Qasim Rasheed (www.qasimrasheed.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->
<cfsilent>
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
</cfscript>
</cfsilent>

