<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" 
     indent="yes"  />
<xsl:param name="project" select="files"/>
<xsl:param name="today" select="today"/>
<xsl:param name="context-root" select="context-root"/>

<xsl:template match="/BugCollection">
    <html>
    <head>
    <meta http-equiv="Content-Style-Type" content="text/css"/>
    <title>FindBugs Results for <xsl:value-of select="$project"/></title>
    <link rel="stylesheet" type="text/css" href="../reports.css"/>
    </head>
    <body>
    <h1>FindBugs Analysis of <xsl:value-of select="$project"/> source code</h1>
    <p align="right">Run with <a href="http://findbugs.sourceforge.net">FindBugs <xsl:value-of select="//BugCollection/@version"/></a> on <xsl:value-of select="$today"/></p>
    <table class="summary">
        <tr><th>Classes</th>
            <th>Items Found</th>
            <th>Priority 1</th>
            <th>Priority 2</th>
            <th>Priority 3</th>
        </tr>
        <tr><td><xsl:value-of select="//FindBugsSummary/@total_classes"/></td>
            <td><xsl:value-of select="//FindBugsSummary/@total_bugs" /></td>
            <td><div class="p1"><xsl:value-of select="count(//BugInstance[@priority = 1])"/></div></td>
            <td><div class="p2"><xsl:value-of select="count(//BugInstance[@priority = 2])"/></div></td>
            <td><div class="p3"><xsl:value-of select="count(//BugInstance[@priority = 3])"/></div></td>
        </tr>
    </table>
    <hr size="2" />
    <xsl:apply-templates/>
    </body>
    </html>
</xsl:template>

<xsl:template name="priorityDiv">
<xsl:if test="@priority = 1">p1</xsl:if>
<xsl:if test="@priority = 2">p2</xsl:if>
<xsl:if test="@priority = 3">p3</xsl:if>
</xsl:template>

<xsl:template match="//BugInstance">
    <xsl:variable name="filename" select="Class/SourceLine/@sourcepath"/>
    <table class="details">
    <tr>
    <th colspan="4">
        <xsl:value-of select="$filename"/></th>
    </tr>
    <tr>
    <td style="padding: 3px" align="right"><div><xsl:attribute name="class"><xsl:call-template name="priorityDiv"/></xsl:attribute><xsl:value-of disable-output-escaping="yes" select="@priority"/></div></td>
    <xsl:variable name="lineNum" select="SourceLine/@start"/>
    <td><a href="{$context-root}/{$filename}.html#{$lineNum}">Line <xsl:value-of select="$lineNum"/></a></td>
    <td><xsl:value-of select="@category"/></td>
    <td><xsl:value-of select="ShortMessage"/></td>
    </tr>
    </table>
    <p/>
</xsl:template>

<!-- Parts of the output that we don't care about -->
<xsl:template match="Project" />
<xsl:template match="BugCategory" />
<xsl:template match="BugCode" />
<xsl:template match="BugPattern" />
<xsl:template match="FindBugsSummary" />

</xsl:stylesheet>
