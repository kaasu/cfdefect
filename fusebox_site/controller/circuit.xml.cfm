<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox:circuit PUBLIC "circuit.dtd" "circuit.dtd"> 
<!-- lexicons are utilized by using a mapped path -->
<circuit 	access="public" 
			xmlns:cf="/cfdefect/com/fusebox/lexicon/cf" 
			xmlns:cs="/cfdefect/com/fusebox/lexicon/coldspring">
	
	<!-- public fuseactions -->
	<fuseaction name="home">
		<do action="userannoucements" contentvariable="content.userAnnouncements" />
		<do action="userprojectstats" contentvariable="content.userStats" />
		<include template="dsp_home.cfm" circuit="v" required="true" contentvariable="content.pageContent" />	
		<do action="layout" />
	</fuseaction>
	
	<fuseaction name="login">
		<xfa name="dologin" value="doLogin" />
		<include template="dsp_login" circuit="v" required="true" contentvariable="content.pageContent" />	
		<do action="layout" />
	</fuseaction>
	
	<fuseaction name="doLogin">
		<invoke object="SecurityController" methodcall="validateUser( event )" />
		<if condition="event.getValue( 'isValid', 'false' )">
			<true>
				<relocate xfa="home" addtoken="false" type="client" />
			</true>
			<false>
				<do action="login" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="logout">
		<invoke object="SecurityController" methodcall="logout( event )" />
		<relocate xfa="home" addtoken="false" type="client" />
	</fuseaction>
	
	<fuseaction name="preferences">
		<invoke object="Controller" methodcall="getUserRecord( event )" />
		<xfa name="process" value="c.savePreferences">
			<parameter name="id" value="#event.getValue( 'recordObject' ).getID()#" />
		</xfa>
		<xfa name="cancel" value="c.home" />
		<include template="dsp_edit_preferences.cfm" circuit="v" required="true" contentvariable="content.pageContent" />
		<do action="layout" />
	</fuseaction>
	
	<fuseaction name="savePreferences">
		<invoke object="Controller" methodcall="savePreferences( event )" />
		<if condition="NOT event.getValue( 'recordObject' )._getErrorCollection().hasErrors()">
			<true>
				<relocate url="#myself#c.preferences&amp;saved=true" addtoken="false" type="client" />
			</true>
			<false>
				<do action="preferences" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="issues">
		<xfa name="add" value="editIssue">
			<parameter name="projectidfk" value="#event.getValue( 'projectidfk' )#" />
		</xfa>
		<xfa name="delete" value="deleteIssue">
			<parameter name="projectidfk" value="#event.getValue( 'projectidfk' )#" />
		</xfa>
		<xfa name="edit" value="editIssue">
			<parameter name="projectidfk" value="#event.getValue( 'projectidfk' )#" />
		</xfa>
		<invoke object="Controller" methodcall="getProjectName( event )" />
		<invoke object="Controller" methodcall="getIssueHeader( event )" />
		<invoke object="Controller" methodcall="getIssueSupportingData( event )" />
		<include template="dsp_issues.cfm" circuit="v" required="true" contentvariable="content.pageContent" />
		<do action="layout" />
	</fuseaction>
	
	<fuseaction name="editIssue">
		<invoke object="Controller" methodcall="getIssueRecord( event )" />
		<invoke object="Controller" methodcall="getIssueSupportingData( event )" />
		<xfa name="process" value="saveIssue">
			<parameter name="projectidfk" value="#event.getValue( 'projectidfk' )#" />
			<parameter name="id" value="#event.getValue( 'recordObject' ).getID()#" />
		</xfa> 
		<xfa name="cancel" value="issues">
			<parameter name="projectidfk" value="#event.getValue( 'projectidfk' )#" />
		</xfa> 
		<include template="dsp_edit_issue.cfm" circuit="v" required="true" contentvariable="content.pageContent" />
		<do action="layout" />
	</fuseaction>
	
	<fuseaction name="saveIssue">
		<xfa name="issues" value="issues">
			<parameter name="projectidfk" value="#URLEncodedFormat( event.getValue( 'projectidfk' ) )#" />
		</xfa>
		<invoke object="Controller" methodcall="validateAndProcessIssue( event )" />
		<if condition="event.getValue( 'recordObject' ).hasErrors()">
			<true>
				<do action="editIssue" />
			</true>
			<false>
				<relocate xfa="issues" type="client" addtoken="false" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="deleteIssue">
		<xfa name="issues" value="issues">
			<parameter name="projectidfk" value="#URLEncodedFormat( event.getValue( 'projectidfk' ) )#" />
		</xfa>
		<invoke object="Controller" methodcall="deleteIssue( event )" />
		<relocate xfa="issues" type="client" addtoken="false" />
	</fuseaction>
	
	<fuseaction name="ajax_issues">
		<cs:get bean="AjaxController" returnvariable="AjaxController" />
		<xfa name="edit" value="editIssue">
			<parameter name="projectidfk" value="#event.getValue( 'projectidfk' )#" />
		</xfa>
		<xfa name="add" value="editIssue">
			<parameter name="projectidfk" value="#event.getValue( 'projectidfk' )#" />
		</xfa>
		<xfa name="delete" value="deleteIssue">
			<parameter name="projectidfk" value="#event.getValue( 'projectidfk' )#" />
		</xfa>
		<invoke object="AjaxController" methodcall="getIssuesForProject( event, myself, xfa )" />
	</fuseaction>
		
	<fuseaction name="reports">
		<do action="reportform" contentvariable="content.pageContent" />
		<do action="layout" />
	</fuseaction>
	
	<fuseaction name="viewreport">
		<invoke object="Controller" methodcall="generateReportOrChart( event )" />
		<if condition="event.getValue( 'skin' ) eq 'html'">
			<true>
				<do action="reportform" contentvariable="content.pageContent" />	
			</true>
		</if>
		<include template="dsp_report.cfm" circuit="v" required="true" contentvariable="content.pageContent" append="true" />
		<do action="layout" />
	</fuseaction>
	
	<fuseaction name="reportform" access="private">
		<xfa name="report" value="viewreport" />
		<invoke object="Controller" methodcall="getProjectForReport( event )" />
		<include template="dsp_form_report.cfm" circuit="v" required="true" />
	</fuseaction>
	
	<fuseaction name="rss">
		<xfa name="rss" value="viewrss" />
		<invoke object="Controller" methodcall="getProjectForRSS( event )" />
		<include template="dsp_select_rss.cfm" circuit="v" required="true" contentvariable="content.pageContent"  />
		<do action="layout" />
	</fuseaction>
	
	<fuseaction name="viewrss">
		<invoke object="Controller" methodcall="generateRSS( event )" />
		<do action="layout" />
	</fuseaction>
	
	<!-- internal fuseactions -->
	<fuseaction name="layout" access="internal">
		<if condition="event.getValue( 'skin') eq 'html' AND event.getValue( 'isLoggedIn' )">
			<true>
				<xfa name="list" value="admin.list" />
				<xfa name="preferences" value="c.preferences" />
				<xfa name="reports" value="c.reports" />
				<xfa name="rss" value="c.rss" />
				<xfa name="issues" value="c.issues" />
				<xfa name="addissue" value="editissue" />
				<invoke object="Controller" methodcall="getProjectForUser( event )" />
				<include template="dsp_sidebar.cfm" circuit="v" contentvariable="content.sidebar" />
			</true>
		</if>
		<include template="lay_#event.getValue( 'skin')#.cfm" circuit="v" required="true" />
	</fuseaction>
	
	<fuseaction name="OnRequestStart">
		<!-- this is cfdefect's version of xfa which copies the name to event object instead of placing it in variables scope. -->
	</fuseaction>
	
	<!-- private fuseactions -->
	<fuseaction name="userprojectstats" access="private">
		<xfa name="issues" value="issues"/>
		<xfa name="issue" value="editIssue"/>
		<invoke object="Controller" methodcall="getUserProjectStats( event )" />
		<include template="dsp_userstats.cfm" circuit="v" required="true" />
	</fuseaction>
	
	<fuseaction name="userannoucements" access="private">
		<invoke object="Controller" methodcall="getAnnouncementForUser( event )" />
		<include template="dsp_userannouncements.cfm" circuit="v" required="true" />
	</fuseaction>
	
</circuit>
