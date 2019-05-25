<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" xmlns:f="f">
    <xsl:include href="bubble-sort.xsl"/>
    <xsl:template match="/">
        <xsl:assert test="f:bubble-sort((9,6,4)) = (4,6,9)"/>
        <xsl:assert test="f:bubble-sort(1) = (1)"/>
        <xsl:assert test="f:bubble-sort((1,2,3)) = (1,2,3)"/>
    </xsl:template>
</xsl:stylesheet>