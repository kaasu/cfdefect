<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox:circuit PUBLIC "circuit.dtd" "circuit.dtd"> 
<circuit access="internal" xmlns:cs="coldspring/" xmlns:cf="cf/">

	<fuseaction name="initialize">
		<!-- <set name="defaultProperties" value="#structnew()#" />
		<cs:initialize defaultproperties="#defaultProperties#">
			<cs:bean beanDefinitionFile="#myFuseBox.getApplication().approotdirectory#/config/appconfig.xml" />
		</cs:initialize>
		 -->
		<!-- <cs:get bean="IssueService" returnvariable="ApplicationConfig" /> -->
		
		<set name="application.servicefactory" value="#myfusebox.getApplication().getApplicationData().servicefactory#" />
		<!-- <cf:dump var="#StructKeyArray( application.servicefactory.GETBEANDEFINITIONLIST() )#" />  -->
		<!-- <cs:get bean="IssueService_Remote" />  -->
	</fuseaction>
	
	<fuseaction name="onRequestStart">
		<!-- some global fuseactions -->
		<xfa name="home" value="c.home" />
		<xfa name="logout" value="c.logout" />
		<!-- end global fuseactions -->
		<!-- <cs:get bean="Controller" returnvariable="Controller" />
		<cs:get bean="AdminController" returnvariable="AdminController" />
		<invoke object="Controller" methodcall="OnRequestStart( event )" />
		 -->
		<!-- 
		<cs:get bean="IssueService" returnvariable="bean" />
		<cf:dump var="#bean#" />
		 -->
		 <!-- 
		<cs:get bean="SecurityService" returnvariable="SecurityService" />
		
		
		<cs:get bean="AjaxController" returnvariable="AjaxController" />
		<cs:get bean="UDF" returnvariable="UDF" />
		
		<set value="#event.setValue( 'user', SecurityService.getUser() )#" />
		<set value="#event.setValue( 'isLoggedIn', SecurityService.isLoggedIn() )#" />
		<set value="#event.setValue( 'UDF', UDF )#" />
		 -->
	</fuseaction>
</circuit>
