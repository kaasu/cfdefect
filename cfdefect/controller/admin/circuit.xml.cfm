<?xml version="1.0" encoding="UTF-8"?>
<circuit access="public" xmlns:cs="/cfdefect/com/fusebox/lexicon/coldspring/">
	
	<prefuseaction callsuper="false">
		<cs:get bean="AdminController" returnvariable="AdminController" />
	</prefuseaction>	
	
	<fuseaction name="list">
		<xfa name="add" value="edit">
			<parameter name="type" value="#event.getValue( 'type' )#" />
			<parameter name="id" value="0" />
		</xfa>
		<xfa name="edit" value="edit">
			<parameter name="type" value="#event.getValue( 'type' )#" />
		</xfa>
		<xfa name="delete" value="delete">
			<parameter name="type" value="#event.getValue( 'type' )#" />
		</xfa>
		<invoke object="AdminController" methodcall="getAllRecords( event )" />
		<if condition="event.getValue( 'type' ) eq 'project'">
			<true>
				<xfa name="issues" value="c.issues" />
				<include template="admin/dsp_list_project.cfm" circuit="v" required="true" contentvariable="content.pageContent" />
			</true>
			<false>
				<include template="admin/dsp_list_generic.cfm" circuit="v" required="true" contentvariable="content.pageContent" />				
			</false>
		</if>
		<do action="c.layout" />
	</fuseaction>
	
	<fuseaction name="edit">
		<xfa name="process" value="save">
			<parameter name="type" value="#event.getValue( 'type' )#" />
			<parameter name="id" value="#event.getValue( 'id' )#" />
		</xfa>
		<xfa name="cancel" value="list">
			<parameter name="type" value="#event.getValue( 'type' )#" />
		</xfa>
		<invoke object="AdminController" methodcall="getRecord( event )" />
		<invoke object="AdminController" methodcall="getSupportingData( event )" />
		<include template="admin/dsp_edit_#event.getValue( 'type' )#.cfm" circuit="v" required="true" contentvariable="content.pageContent" />
		<do action="c.layout" />
	</fuseaction>
	
	<fuseaction name="save">
		<invoke object="AdminController" methodcall="validateAndProcess( event )" />
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
		<invoke object="AdminController" methodcall="delete( event )" />
		<relocate url="#myself##myfusebox.originalcircuit#.list&amp;type=#event.getValue( 'type' )#" addtoken="false" type="client" />
	</fuseaction>
	
</circuit>
