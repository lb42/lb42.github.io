<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    <xsl:output method="html" exclude-result-prefixes="#all" encoding="utf-8" indent="yes"/>
    <xsl:variable name="now" select="current-time()"/>
    <xsl:variable name="nLangs" select="15"/>
    <xsl:variable name="random">
        <xsl:value-of select="floor(seconds-from-time($now)) mod $nLangs + 1"/>
    </xsl:variable>
    <!--  <xsl:param name="lang">en</xsl:param>
 -->
    <xsl:param name="line">2</xsl:param>
    <xsl:param name="select">poem</xsl:param>
    <xsl:param name="lang1">en</xsl:param>
    <xsl:param name="lang2">fr</xsl:param>
    <xsl:param name="lang3">de</xsl:param>
    <xsl:param name="lang4">zh</xsl:param>
    <xsl:param name="lang5">ru</xsl:param>
    <xsl:variable name="today" select="current-date()"/>
    <xsl:template match="t:teiHeader/t:fileDesc/t:editionStmt/t:edition/t:date">
        <date>
            <xsl:value-of select="$today"/>
        </date>
    </xsl:template>
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <!--THIS FILE IS GENERATED FROM AN XML MASTER. DO NOT EDIT (5)-->
                <title>Poema sans grenzen</title>
                <meta name="author" content="Rip Bulkeley"/>
                <meta name="generator"
                    content="Text Encoding Initiative Consortium XSLT stylesheets"/>
                <meta name="DC.Title" content="Poema sans grenzen"/>
                <meta name="DC.Type" content="Text"/>
                <meta name="DC.Format" content="text/html"/>
                <link href="rip.css" rel="stylesheet" type="text/css"/>
                <!-- <link rel="stylesheet" media="print" type="text/css"
                    href="http://www.tei-c.org/release/xml/tei/stylesheet/tei-print.css" />-->
            </head>
            <body class="simple" id="TOP">
                <xsl:variable name="message">
                    <xsl:text>The time is </xsl:text>
                    <xsl:value-of select="$now"/>
                    <xsl:text> and today's random number is </xsl:text>
                    <xsl:value-of select="$random"/>
                    <xsl:text>
               </xsl:text>
                </xsl:variable>
                <xsl:for-each select="//t:body/t:lg">
                    <xsl:if test="position() = $random">
                        <xsl:comment>
                        <xsl:value-of select="$message"/>
                        <xsl:text> so </xsl:text>
                        <xsl:value-of select="@xml:lang"/> is our chosen language and </xsl:comment>
                        <xsl:variable name="scheme">
                            <xsl:choose>
                                <xsl:when test="@xml:lang = 'ar'">brownOnTeal</xsl:when>
                                <xsl:when test="@xml:lang = 'de'">tealOnBrown</xsl:when>
                                <xsl:when test="@xml:lang = 'dk'">redOnYellow</xsl:when>
                                <xsl:when test="@xml:lang = 'en'">yellowOnRed</xsl:when>
                                <xsl:when test="@xml:lang = 'eo'">blueOnGray</xsl:when>
                                <xsl:when test="@xml:lang = 'es'">grayOnBlue</xsl:when>
                                <xsl:when test="@xml:lang = 'fr'">greenOnPink</xsl:when>
                                <xsl:when test="@xml:lang = 'ga'">pinkOnGreen</xsl:when>
                                <xsl:when test="@xml:lang = 'gr'">brownOnPink</xsl:when>
                                <xsl:when test="@xml:lang = 'ha'">blackOnYellow</xsl:when>
                                <xsl:when test="@xml:lang = 'ja'">yellowOnBlack</xsl:when>
                                <xsl:when test="@xml:lang = 'ru'">greenOnYellow</xsl:when>
                                <xsl:when test="@xml:lang = 'sp'">yellowOnGreen</xsl:when>
                                <xsl:when test="@xml:lang = 'sw'">blackOnYellow</xsl:when>
                                <xsl:when test="@xml:lang = 'zh'">whiteOnBlack</xsl:when>
                                <xsl:otherwise> blackOnWhite </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="direction">
                            <xsl:choose>
                                <xsl:when test="@xml:lang = 'ar'">rtol</xsl:when>
                                <xsl:otherwise>ltor</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:comment><xsl:value-of select="$scheme"/>is our chosen colour scheme
             </xsl:comment>
                        <div class="{$scheme}" xml:lang="{@xml:lang}">
                            <xsl:apply-templates select="."/>
                        </div>
                    </xsl:if>
                </xsl:for-each>
                <xsl:choose>
                    <!--   <xsl:when test="$select = 'poem'">
                    <xsl:apply-templates select="//t:lg[@xml:lang = $lang]"/>
                </xsl:when>
             -->
                    <!-- <xsl:when test="$select = 'line'">
                    <xsl:apply-templates select="//t:lg[@xml:lang = $lang]/t:l[@n = $line]"/>
                </xsl:when>-->
                    <xsl:when test="$select = 'macaronic'">
                        <lg xml:lang="">
                            <xsl:apply-templates select="//t:lg[@xml:lang = $lang1]/t:head"/>
                            <xsl:apply-templates select="//t:lg[@xml:lang = $lang1]/t:l[@n = '1']"/>
                            <xsl:apply-templates select="//t:lg[@xml:lang = $lang2]/t:l[@n = '2']"/>
                            <xsl:apply-templates select="//t:lg[@xml:lang = $lang3]/t:l[@n = 3]"/>
                            <xsl:apply-templates select="//t:lg[@xml:lang = $lang4]/t:l[@n = 4]"/>
                            <xsl:apply-templates select="//t:lg[@xml:lang = $lang5]/t:l[@n = 5]"/>
                        </lg>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message>Unexpected select value</xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="t:l">
        <div class="l">
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="parent::t:lg/@xml:lang"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="t:head">
        <div class="head">
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="parent::t:lg/@xml:lang"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!--<xsl:template match="t:listChange">
        <change when="{$today}">auto derived from xml source </change>
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
