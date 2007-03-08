<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" 
     indent="yes"  />
     
<xsl:template match="/">
    <xsl:apply-templates select="//tags/tag/name"/>
</xsl:template>

<xsl:template match="name">
    <xsl:value-of select="."/><xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>
