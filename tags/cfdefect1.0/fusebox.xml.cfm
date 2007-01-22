<?xml version="1.0" encoding="UTF-8"?>
<fusebox>
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
		<!-- <parameter name="parsePath" value="/cfdefect/parsed" /> -->
		<!-- <parameter name="errortemplatesPath" value="/cfdefect/errortemplates" />  -->
		<!-- <parameter name="lexiconPath" value="/cfdefect/lexicon" /> -->
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
