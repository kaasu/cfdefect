<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:output method="html"/>

<xsl:template match="/report">
	<table border="1" width="100%">
		<thead>
			<tr>
				<th>Project</th>
				<th>Public Id</th>
				<th>Name</th>
				<th>Owner</th>
				<th>Creator</th>
				<th>Issue Type</th>
				<th>Locus</th>
				<th>Severity</th>
				<th>Status</th>
				<th>Created</th>
				<th>Updated</th>
			</tr>
		</thead>
		<tbody>
			<xsl:apply-templates select="project" /> 
		</tbody>
	</table>
</xsl:template>

<xsl:template match="project">
	<xsl:for-each select="issues/*">
		<xsl:call-template name="issues">
			<xsl:with-param name="projectname"><xsl:value-of select="../../project_name" /></xsl:with-param>
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>

<xsl:template name="issues">
	<xsl:param name="projectname" />
	<tr>
		<td><xsl:value-of select="$projectname"/></td>
		<td><xsl:value-of select="publicid"/></td>
		<td><xsl:value-of select="name"/></td>
		<td><xsl:value-of select="owner"/></td>
		<td><xsl:value-of select="creator"/></td>
		<td><xsl:value-of select="issue_type"/></td>
		<td><xsl:value-of select="locus"/></td>
		<td><xsl:value-of select="severity"/></td>
		<td><xsl:value-of select="status"/></td>
		<td><xsl:value-of select="created"/></td>
		<td><xsl:value-of select="updated"/></td>
	</tr>
</xsl:template>

</xsl:stylesheet>