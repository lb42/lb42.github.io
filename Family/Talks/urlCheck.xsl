<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output method="text"/>
 <xsl:template match="/">
  <xsl:for-each select="//*:graphic[@url]">
   <xsl:variable name="f"><xsl:value-of select="@url"/></xsl:variable>
   <xsl:value-of select="concat('mv ',$f,' ../media')"/>
   <xsl:if test="unparsed-text-available($f)">
 exists
   </xsl:if><xsl:text>
</xsl:text>
   
  </xsl:for-each>
  
 </xsl:template>
</xsl:stylesheet>