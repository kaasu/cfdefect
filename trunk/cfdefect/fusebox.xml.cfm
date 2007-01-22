<!--
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
-->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox PUBLIC "fusebox.dtd" "fusebox.dtd"> 
<fusebox xmlns:cf="cf/" >
	<circuits>
		<circuit alias="m" path="model/" parent=""  />
		<circuit alias="v" path="views/" parent="" />
		<circuit alias="c" path="controller/" />
		<circuit alias="admin" path="controller/admin/" /> 
	</circuits>

	<classes>
	</classes>

	<parameters>
		<parameter name="defaultFuseaction" value="c.home" />
		<!-- you may want to change this to development-full-load mode: -->
		<parameter name="mode" value="development-circuit-load" />
		<parameter name="password" value="cfdefect" />
		<parameter name="strictMode" value="true" />
		<parameter name="fuseactionVariable" value="do" />
		<parameter name="precedenceFormOrUrl" value="form" />
		<parameter name="scriptFileDelimiter" value="cfm" />
		<parameter name="maskedFileDelimiters" value="htm,cfm,cfml,php,php4,asp,aspx" />
		<parameter name="characterEncoding" value="utf-8" />
		<parameter name="allowImplicitCircuits" value="true" />
		<!-- comment this if you want parsed files to be generated in your application's directory.  -->
		<!-- <parameter name="parsePath" value="/cfdefect/parsed" /> -->
		<!-- comment this if you want to process errortemplates in your website folders. For the most part, keep it like this.  -->
		<!-- <parameter name="errortemplatesPath" value="/cfdefect/errortemplates" />  -->
		<!--  <parameter name="lexiconPath" value="/cfdefect/lexicon" /> -->
		<!-- <parameter name="pluginsPath" value="/cfdefect/plugins" />  -->
		<parameter name="debug" value="false" />
	</parameters>

	<globalfuseactions>
		<appinit>
		</appinit>
		<preprocess>
		</preprocess>
		<postprocess>
		</postprocess>
	</globalfuseactions>

	<plugins>
		<phase name="preProcess">
			<plugin name="Security" template="security.cfm" path="/cfdefect/com/fusebox/plugins">
				<parameter name="factory" value="serviceFactory"/>
				<parameter name="bean" value="SecurityService"/>
				<parameter name="skipFuseactions" value="c.doLogin" />
				<parameter name="failed" value="c.login"/>
			</plugin>
		</phase>
		<phase name="preFuseaction">
		</phase>
		<phase name="postFuseaction">
		</phase>
		<phase name="fuseactionException">
		</phase>
		<phase name="postProcess">
		</phase>
		<phase name="processError">
		</phase>
	</plugins>

</fusebox>
