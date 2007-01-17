<cfsilent>
<cfset columns = ListToArray( event.getValue( 'columns' ),  '~' ) />
<cfimport taglib="/cfdefect/customtags" prefix="ui" />
</cfsilent>
<cfoutput>
<ui:dspDataTable myself="#myself#" xfa="#xfa#" type="issue" udf="#event.getValue( 'UDF' )#" headers="#columns#">
	
</ui:dspDataTable>
</cfoutput>