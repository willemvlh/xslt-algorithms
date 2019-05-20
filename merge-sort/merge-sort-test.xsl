<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="f"
    version="3.0">
    <xsl:import href="merge-sort.xsl"/>
    <xsl:template match="/">
        <xsl:assert test="f:merge-sort((3,1,2)) = (1,2,3)"/>
        <xsl:assert test="f:merge-sort(('y','q','z')) = ('q','y','z')"/>
        <xsl:assert test="empty(f:merge-sort(()))"/>
    </xsl:template>
</xsl:stylesheet>