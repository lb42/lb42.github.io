<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    <xsl:output method="html" exclude-result-prefixes="#all" encoding="utf-8" indent="yes"/>
    <xsl:variable name="now" select="current-time()"/>
    <xsl:variable name="nLangs" select="15"/>
    <xsl:variable name="today" select="current-date()"/>
    <xsl:variable name="randomLines"
        select="tokenize(unparsed-text(
        'https://www.random.org/integers/?num=20&amp;min=1&amp;max=5&amp;col=5&amp;base=10&amp;format=plain&amp;rnd=new'), '\s')"/>
    <xsl:variable name="randomLangs"
        select="tokenize(unparsed-text(
        'https://www.random.org/integers/?num=20&amp;min=1&amp;max=15&amp;col=5&amp;base=10&amp;format=plain&amp;rnd=new'),'\s')"/>
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
                <xsl:variable name="message">
                    <xsl:text>The time is </xsl:text>
                    <xsl:value-of select="$now"/>
                    <xsl:text> and today's random variables are </xsl:text>
                    <xsl:value-of select="$randomLangs"/> and <xsl:value-of select="$randomLines"/>
                    <xsl:text>
               </xsl:text>
                </xsl:variable>
                <xsl:comment><xsl:value-of select="$message"/></xsl:comment>
                <xsl:variable name="ROOT" select="."/>
                <xsl:for-each select="$randomLangs">
                    <xsl:variable name="rLang" select="."/>
                 
                    <xsl:comment>Lang is<xsl:value-of select="$rLang"/></xsl:comment>
         
                    <xsl:apply-templates select="$ROOT//t:body/t:lg[string(position()) = $rLang]"/>
                    
                    <div class="lines">
                        <xsl:for-each select="$randomLines">
                        <xsl:variable name="rLine">
                            <xsl:value-of select="."/>
                        </xsl:variable>
                        <xsl:variable name="ix" select="position()"/>
             <!--           <xsl:comment>ix: <xsl:value-of select="$ix"/></xsl:comment>
           -->             <xsl:variable name="rLang2">
                            <xsl:value-of select="$randomLangs[$ix]"/>
                        </xsl:variable>
            <!--            <xsl:comment> <xsl:value-of select="$rLang2"/> : <xsl:value-of select="$rLine"/></xsl:comment>
          -->            
                       
                            <xsl:apply-templates
                                select="$ROOT//t:lg[string(position()) = $rLang2]/t:l[string(position()) = $rLine]"
                        />
                            
                    </xsl:for-each>
                    </div>
                </xsl:for-each>
            </body>
            <script>
                var myIndex = 0;
                carousel();
                
                function carousel() {
                var i;
                var x = document.getElementsByClassName("stanza");
                for (i = 0; i &lt; x.length; i++) {
                x[i].style.display = "none";  
                }
                myIndex++;
                if (myIndex > x.length) {myIndex = 1}    
                x[myIndex-1].style.display = "block";  
                setTimeout(carousel, 3500); // millisecs
                }
            </script>
        </html>
    </xsl:template>
    <xsl:template match="t:lg">
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
        <!-- change background image here -->
        <div class="stanza {$scheme}" xml:lang="{@xml:lang}">
            <xsl:for-each select="t:l">
                <div class="l"><xsl:apply-templates/></div>
            </xsl:for-each>
            <xsl:apply-templates select="t:head"/>
        </div>
         
    </xsl:template>
    <xsl:template match="t:l">
        <xsl:variable name="ln">
            <xsl:value-of select="concat('stanza l',@n)"/>
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
