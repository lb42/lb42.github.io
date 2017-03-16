<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t"
    version="2.0">
    <xsl:output encoding="UTF-8" method="html"/>
    
    <xsl:variable name="source">
        <xsl:value-of select="tokenize(document-uri(), '/')[last()]"/>
    </xsl:variable>
    <xsl:param name="CSSfile">css/tei.css</xsl:param>
    <xsl:param name="CETEIfile">js/CETEI.js</xsl:param>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                <link rel="stylesheet" href="{$CSSfile}" media="screen" title="no title" />
                <link type="application/tei+xml" rel="alternative" href="{$source}"/>
                <script src="{$CETEIfile}" charset="utf-8"></script><xsl:text>
                </xsl:text>
                <script type="text/javascript">
                    <xsl:value-of select="concat('(new CETEI).getHTML5(&quot;',  $source,'&quot;,
                      function(data) {')"/>
                    document.getElementsByTagName("body")[0].appendChild(data);
                    });
                </script>
                <title>
                    <xsl:value-of select="t:TEI/t:teiHeader/t:fileDesc/t:titleStmt/t:title[1]"/>
                </title>
            </head>
            <body>
                
            </body>
        </html>
        
    </xsl:template>
</xsl:stylesheet>
