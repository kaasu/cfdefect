<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox:circuit PUBLIC "circuit.dtd" "circuit.dtd"> 
<!--
	Example circuit.xml file for the controller portion of an application.
	Only the controller circuit has public access - the controller circuit
	contains all of the fuseactions that are used in links and form posts
	within your application.
-->
<circuit access="public" xmlns:cs="/cfdefect/com/fusebox/lexicon/coldspring/" xmlns:cf="/cfdefect/com/fusebox/lexicon/cf/">
		
	<fuseaction name="list">
		<cs:get bean="AdminController" returnvariable="AdminController" />
		<xfa name="add" value="edit" />
		<xfa name="edit" value="edit" />
		<xfa name="delete" value="delete" />
		<invoke object="AdminController" method="getAllRecords">
			<argument value="#event#"/>
		</invoke>
		<cf:switch expression="#event.getValue( 'type' )#">
			<cf:case value="project">
				<xfa name="issues" value="c.issues" />
				<include template="admin/dsp_list_project.cfm" circuit="v" required="true" contentvariable="content.pageContent" />
			</cf:case>
			<cf:defaultcase>
				<include template="admin/dsp_list_generic.cfm" circuit="v" required="true" contentvariable="content.pageContent" />	
			</cf:defaultcase>
		</cf:switch>
		<do action="c.layout" />
	</fuseaction>
	
	<fuseaction name="edit">
		<cs:get bean="AdminController" returnvariable="AdminController" />
		<xfa name="process" value="save" />
		<xfa name="cancel" value="list" />
		<invoke object="AdminController" methodcall="getRecord( event )" />
		<invoke object="AdminController" methodcall="getSupportingData( event )" />
		<include template="admin/dsp_edit_#event.getValue( 'type' )#.cfm" circuit="v" required="true" contentvariable="content.pageContent" />
		<do action="c.layout" />
	</fuseaction>
	
	<fuseaction name="save">
		<cs:get bean="AdminController" returnvariable="AdminController" />
		<invoke object="AdminController" method="validateAndProcess">
			<argument value="#event#"/>
		</invoke>
		<if condition="NOT event.getValue( 'recordObject' ).hasErrors()">
			<true>
				<relocate url="#myself##myfusebox.originalcircuit#.list&amp;type=#event.getValue( 'type' )#" addtoken="false" type="client" />
			</true>
			<false>
				<do action="edit" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="delete">
		<cs:get bean="AdminController" returnvariable="AdminController" />
		<invoke object="AdminController" method="delete">
			<argument value="#event#"/>
		</invoke>
		<relocate url="#myself##myfusebox.originalcircuit#.list&amp;type=#event.getValue( 'type' )#" addtoken="false" type="client" />
	</fuseaction>
	
</circuit>
