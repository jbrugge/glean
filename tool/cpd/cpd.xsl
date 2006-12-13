<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" 
     indent="yes"  />
<xsl:param name="project" select="files"/>
<xsl:param name="today" select="today"/>
<xsl:param name="context-root" select="context-root"/>
<xsl:param name="source-root" select="source-root"/>

  <xsl:template match="/pmd-cpd">
    <html>
    <head>
    <META HTTP-EQUIV="Content-Style-Type" CONTENT="text/css"/>
    <title>CPD Analysis of <xsl:value-of select="$project"/> source code</title>
    <link rel="stylesheet" type="text/css" href="../reports.css"/>
    </head>
    <body>
    <h1>Copy/Paste Detector (CPD) Analysis of <xsl:value-of select="$project"/> source code</h1>
    <p align="right">Run with <a href="http://pmd.sourceforge.net">CPD</a> on <xsl:value-of select="$today"/></p>
    <hr size="2" />
    <!-- Add in a summary section here -->
    <xsl:apply-templates/>

    </body>
    </html>
  </xsl:template>

  <xsl:template match="//duplication">
    <xsl:variable name="filename" select="@name"/>
    <table class="details">
    <tr>
    <th>
    Found a <xsl:value-of select="@lines"/> line duplication in the following files
    </th>
    </tr>
    <xsl:apply-templates/>
    </table>
    <p/>
  </xsl:template>

  <xsl:template match="file">
    <xsl:variable name="path" select="@path"/>
    <xsl:variable name="line" select="@line"/>
    <xsl:variable name="linkpath" select="substring-after(@path, $source-root)"/>
    <tr>
    <td class="file">Starting at <a href="{$context-root}/{$linkpath}.html#{$line}">line <xsl:value-of select="@line"/></a> of <xsl:value-of select="$linkpath"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="codefragment">
    <tr>
    <td><pre><xsl:value-of select="."/></pre></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
