<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="f"
    version="3.0">
    <xsl:include href="binary-search.xsl"/>
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:value-of select="f:get-index(7, (1,2,3,4,5,7,7,9,16))"/>
    </xsl:template>
    
</xsl:stylesheet>