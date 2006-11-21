<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- Simple styleseet to render findbugs xml output into html.  -->
<!-- Use at own risk -->

<xsl:template match="/BugCollection">
<html>
<head>
<title>FindBugs Results</title>
<style type="text/css">
<xsl:text>
body {
font:normal 68% arial,helvetica;
color:#000000;
}
}

h1 {
margin: 0px 0px 5px; font: 165% arial,helvetica
}
h2 {
margin-top: 1em; margin-bottom: 0.5em; font: bold 125% arial,helvetica
}
h3 {
margin-bottom: 0.5em;
font: bold 115% arial,helvetica;
background-color:#eeeee0;
}
</xsl:text>
</style>

</head>
<body>
<h1>
&#160;&#160;&#160;FindBugs Results</h1>

<xsl:apply-templates select="Project"/>
<h2>Short summary</h2>
Number of prio 1 bugs: <xsl:value-of select="count(BugInstance[@priority=1])"/><br/>
Number of prio 2 bugs: <xsl:value-of select="count(BugInstance[@priority=2])"/><br/>
Number of bugs total: <xsl:value-of select="count(BugInstance)"/><br/>
<h2>Issue list</h2>
<xsl:apply-templates select="BugInstance">
  <xsl:sort select="@priority"/>
  <xsl:sort select="@type"/>
</xsl:apply-templates>
</body>
</html>

</xsl:template>

<xsl:template match="BugInstance">
<xsl:variable name="type" select="@type"/>
<h3><xsl:value-of select="Class/@classname"/></h3>
Typ: <a href="http://findbugs.sf.net/bugDescriptions.html#{$type}"><xsl:value-of select="$type"/></a>
, Prio: <xsl:value-of select="@priority"/><br/>
Method: 
<b><xsl:value-of select="Method/@name"/></b><br/>
SrcLine <xsl:value-of select="SourceLine/@start"/><br/>

</xsl:template>

<xsl:template match="Project">
Findbugs-Project: <xsl:value-of select="@filename"/><br/>
Analyzed classes: <xsl:value-of select="Jar"/><br/>
<xsl:for-each select="SrcDir">
  SrcDir: <xsl:value-of select="."/><br/>
</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
