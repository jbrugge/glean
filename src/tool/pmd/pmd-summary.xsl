<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" 
     indent="yes"  />
<xsl:template match="/pmd">
<xsl:value-of select="count(//violation)" /> violations in <xsl:value-of select="count(//file)"/> files
</xsl:template>
</xsl:stylesheet>