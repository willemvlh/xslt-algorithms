<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="f" version="3.0">
    <xsl:include href="binary-tree.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="map" as="map(*)" select="f:tree(1)"/>
        <xsl:variable name="map-inserted" select="f:insert-into-tree($map, 2)"/>
        <xsl:assert test="map:get($map-inserted, 'value') = 1"/>
        <xsl:assert test="map:get($map-inserted, 'right') instance of map(*)"></xsl:assert>
        <xsl:assert test="map:get(map:get($map-inserted, 'right'), 'value') = 2"/>
    </xsl:template>

</xsl:stylesheet>
