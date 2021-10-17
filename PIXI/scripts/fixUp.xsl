<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:e="http://distantreading.net/eltec/ns"
 exclude-result-prefixes="xs e t" version="2.0">
 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="p[hi[@rend = 'italic bold']]">
  <xsl:variable name="ident">
   <xsl:value-of select="hi[@rend = 'italic bold']"/>
  </xsl:variable>
 <xsl:variable name="type">
  <xsl:choose>
   <xsl:when test="starts-with($ident,'/')">encounter</xsl:when>
  <xsl:otherwise>tape</xsl:otherwise></xsl:choose>
 </xsl:variable>
   <milestone xmlns="http://www.tei-c.org/ns/1.0" >
    <xsl:attribute name="unit" select="$type"/>
   <xsl:attribute name="n">
    <xsl:value-of select="$ident"/>
   </xsl:attribute>
  </milestone>
 </xsl:template>
 
 <xsl:template match="t:teiHeader"/>
 
 <xsl:template match="hi[@rend = 'bold']"/>
 <xsl:template match="p[hi[@rend = 'bold']]">
    <u xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:attribute name="who">
      <xsl:value-of select="hi[@rend = 'bold']"/>
     <xsl:if test="hi[@rend='italic'][following-sibling::hi[@rend='bold']]">?</xsl:if>
    </xsl:attribute>
      <xsl:if test="contains(., '=')">
      <xsl:attribute name="trans">latching</xsl:attribute>
     </xsl:if>
    <xsl:apply-templates />
   </u>
 </xsl:template>
 
<!-- //p[hi[@rend="italic"][following-sibling::hi[@rend='bold']]]
-->



 <xsl:template match="//g">
<!--  <g xmlns="http://www.tei-c.org/ns/1.0" ref="{@n}"/>
-->  <xsl:choose>
   <xsl:when test="@n='F0DA'">&#x25BC;<!-- down --></xsl:when>
   <xsl:when test="@n='F0D7'">&#x25C0;<!-- left --></xsl:when>
   <xsl:when test="@n='F0D9'">&#x25B2;<!-- up --></xsl:when>
  <xsl:otherwise>
   <xsl:message>!! unexpected g/@ref</xsl:message>
  </xsl:otherwise></xsl:choose>
  
 </xsl:template>

 <xsl:template match="hi[@rend = 'underline']">
  <emph xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates/>
  </emph>
 </xsl:template>
 
 <xsl:template match="p[note and not(hi)]">
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="note/hi[@rend = 'italic']">
    <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="p/hi[@rend='italic']">
  <xsl:if test="not(contains(.,'?'))">
   <rs xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates/></rs>
  </xsl:if>
 </xsl:template>
 <xsl:template match="unclear/hi[@rend='italic']">
  <xsl:if test="not(contains(.,'?'))">
   <rs xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates/></rs>
  </xsl:if>
 </xsl:template>
 <xsl:template match="note[pause]">
  <incident xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="dur">
    <xsl:value-of select="pause/@dur"/>
   </xsl:attribute>
   <desc xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates/></desc>
  </incident>
 </xsl:template>
 <xsl:template match="note/pause"/>
 
 <xsl:template match="p[pause and not(hi) and not(note)]">
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="unclear[hi[@rend='italic']]">
  <xsl:variable name="string">
   <xsl:value-of select="hi[@rend='italic']"/>
  </xsl:variable>
  <xsl:choose>
  <xsl:when test="matches($string, '\d+syll')">
   <unclear xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:attribute name="extent">
     <xsl:value-of select="$string"/>
    </xsl:attribute>
   </unclear>
  </xsl:when><xsl:when test="matches($string, '\?+')">
   <unclear xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:value-of select="$string"/>
   </unclear>  
  </xsl:when>
   <xsl:otherwise>
    <unclear xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:apply-templates/>
    </unclear>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
</xsl:stylesheet>
