<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:e="http://distantreading.net/eltec/ns"
 exclude-result-prefixes="xs t e" version="2.0">

 <xsl:param name="corpus">xxx</xsl:param>
 <xsl:variable name="prefix">
  <xsl:value-of select="concat('https://lb42.github.io/PIXI/audio/', $corpus, '/')"/>
 </xsl:variable>
 <xsl:variable name="hdrFileName" select="concat('../Work/', $corpus, 'Header.xml')"/>
 <xsl:variable name="hdrFile" select="document($hdrFileName)"/>

 <xsl:template match="@* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="t:body/t:note[1]"/>
 <xsl:template match="//t:milestone[@unit = 'tape']"/>

 <xsl:template match="/">
  <TEI xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:copy-of select="$hdrFile/teiHeader"/>
   <text>
    <xsl:apply-templates select="//t:body"/>
   </text>
  </TEI>
 </xsl:template>

 <xsl:template match="t:body">
  <!--  <xsl:if test="t:note">
            <front xmlns="http://www.tei-c.org/ns/1.0">
                <div type="speakers">
                    <list>
                        <item>
                            <xsl:value-of select="t:note[1]"/>
                        </item>
                   
                    </list>
                </div>
            </front>
        </xsl:if>-->
  <body xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:for-each-group select="*" group-starting-with="t:milestone[@unit = 'tape']">
    <xsl:if test="@n">
     <xsl:variable name="tapeId">
      <xsl:value-of select="@n"/>
     </xsl:variable>
     <xsl:for-each-group select="current-group()"
      group-starting-with="t:milestone[@unit = 'encounter']">
      <xsl:variable name="encId">
       <xsl:if test="starts-with(@n, '/')">
        <xsl:value-of select="@n"/>
       </xsl:if>
      </xsl:variable>
      <xsl:variable name="mediaFile">
       <xsl:value-of select="replace(concat($tapeId, $encId), '[‑/\s]', '_')"/>
      </xsl:variable>
      <xsl:if test="count(current-group()) gt 1">
       <!--                           <xsl:message>Group has <xsl:value-of select="count(current-group())"/></xsl:message>
-->
       <div xmlns="http://www.tei-c.org/ns/1.0" type="encounter">
        <xsl:attribute name="n">
         <xsl:value-of select="concat($tapeId, $encId)"/>
        </xsl:attribute>
        <xsl:attribute name="corresp">
         <xsl:value-of select="concat($prefix, $mediaFile, '.mp3')"/>
        </xsl:attribute>
        <xsl:for-each select="current-group()">
         <xsl:if test="not(name(.) eq 'milestone')">
          <xsl:copy>
           <xsl:apply-templates select="@*"/>
           <xsl:apply-templates/>
          </xsl:copy>
         </xsl:if>
        </xsl:for-each>
       </div>
      </xsl:if>
     </xsl:for-each-group>

    </xsl:if>
   </xsl:for-each-group>
  </body>
 </xsl:template>

</xsl:stylesheet>
