<cfswitch expression="#thisTag.ExecutionMode#">
	<cfcase value="start">
	<cfsilent>
	<cfparam name="attributes.myself" type="string" />
	<cfparam name="attributes.xfa" type="struct" />	
	<cfparam name="attributes.type" type="string" />
	<cfparam name="attributes.UDF" />
	<cfparam name="attributes.help" type="string" />
	<cfparam name="attributes.formEnctype" type="string" default="" />
	<cfset myself = attributes.myself />
	<cfset xfa = attributes.xfa />
	<cfset type = attributes.type />
	<cfset UDF = attributes.UDF />
	<cfset help = attributes.help />
	<cfset formEnctype = attributes.formEnctype />
	</cfsilent>
	
	</cfcase>
	<cfcase value="end">
		<cfoutput>
		<div class="lighterBox">
			<div class="left">
			<form name="#type#form" method="post" action="#myself##xfa.process#" class="data" <cfif formEnctype.trim().length() GT 0> enctype="#formEnctype#"</cfif>>
				<fieldset>
					<legend>Add/Edit #UDF.capFirstTitle( type )#</legend>
						#thisTag.GeneratedContent#
						<cfset thisTag.GeneratedContent = '' />
						<label for="kludge"></label>
						<input type="submit" value="Save" id="submit" class="button"> 
						<input type="button" value="Cancel" id="cancel" class="button cancel" location="#myself##xfa.cancel#"> 
				</fieldset>
				<br />
			</form>
			</div>
			<div class="right">
				<div class="darkerBox help">
					<h4>Help</h4>
					<p>#help.trim()#</p>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		</cfoutput>
	</cfcase>
</cfswitch>