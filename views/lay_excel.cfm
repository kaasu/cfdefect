<cfsilent>
<cfsetting showdebugoutput="false" />
</cfsilent>
<cfcontent reset="true" type="application/msexcel">
<cfheader name="content-disposition" value="attachment;filename=stats.xls"> 
<cfoutput>#content.pageContent#</cfoutput>

