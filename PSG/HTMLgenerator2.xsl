<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:my="http://lb42.github.io"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    <xsl:output method="html" exclude-result-prefixes="#all" encoding="utf-8" indent="yes"/>
    <xsl:variable name="now" select="current-time()"/>
    <xsl:variable name="today" select="current-date()"/>
    <xsl:variable name="nLangs" select="15"/>
    <xsl:param name="iterations">10</xsl:param>
    <xsl:variable name="leadLang" select="3"/>
    <!--    <xsl:variable name="randomLines"
        select="tokenize(unparsed-text(
        'https://www.random.org/integers/?num=10&amp;min=1&amp;max=5&amp;col=5&amp;base=10&amp;format=plain&amp;rnd=new'), '\s')"/>
-->
    <!-- give me $nLangs*$iterations numbers between 1 and $nLangs -->
    <xsl:variable name="randomLangs"
        select="tokenize(unparsed-text(
        'https://www.random.org/integers/?num=150&amp;min=1&amp;max=15&amp;col=5&amp;base=10&amp;format=plain&amp;rnd=new'),'\s')"/>
    <xsl:function name="my:next" as="xs:integer">
        <xsl:param name="in" as="xs:integer"/>
        <xsl:sequence select="$in + 5"/>
    </xsl:function>
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
            </head>
            <body class="simple" id="TOP">
                
                <xsl:variable name="offsets" as="xs:integer *">
                    <xsl:for-each select="0 to $iterations">
                        <xsl:value-of select=". * 5"/>
                    </xsl:for-each>
                </xsl:variable>
              
                <xsl:variable name="message">
                    <xsl:text>The time is </xsl:text>
                    <xsl:value-of select="$now"/>
                    <xsl:text>Today's random numbers are  </xsl:text>
                    <xsl:value-of select="$randomLangs"/><xsl:text>
               </xsl:text>
                    <!--        and <xsl:value-of select="$randomLines"/>
            -->
                    <xsl:text>Offsets are </xsl:text>
                    <xsl:value-of select="$offsets"/><xsl:text>
               </xsl:text>
                </xsl:variable>
                <xsl:comment><xsl:value-of select="$message"/></xsl:comment>
              
                <xsl:variable name="ROOT" select="."/>
                <xsl:for-each select="$offsets">
                    <xsl:variable name="offset" select="."/>
                    <div class="stanza">
                        <xsl:for-each select="1 to 5">
                            <xsl:variable name="line" select="."/>
                             <xsl:variable name="rLang" select="$randomLangs[$line + $offset]"/>
                            <xsl:comment>Stanza <xsl:value-of select="$rLang"/> Line <xsl:value-of select="$line"/></xsl:comment>
                            <xsl:apply-templates
                                select="
                                    $ROOT//t:body/t:lg[string(position()) =
                                    $rLang]/t:l[position() = $line]"
                            />
                        </xsl:for-each>
                    </div>
                    <div class="nextLink">
                        <a href="simple2.html">
                            <img src="hand.jpg" height="40"/>
                        </a>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="t:lg">
        <div class="stanza" xml:lang="{@xml:lang}">
            <xsl:for-each select="t:l">
                <div class="l">
                    <xsl:apply-templates/>
                </div>
            </xsl:for-each>
            <xsl:apply-templates select="t:head"/>
        </div>
    </xsl:template>
    <xsl:template match="t:l">
        <xsl:variable name="ln">
            <xsl:value-of select="concat('l', @n)"/>
        </xsl:variable>
        <div class="{$ln}">
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
