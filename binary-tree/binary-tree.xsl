<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="f"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map" exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:function name="f:insert-into-tree">
        <xsl:param name="tree" as="map(*)?"/>
        <xsl:param name="element"/>
        <xsl:choose>
            <xsl:when test="empty($tree)">
                <xsl:sequence select="f:tree($element)"/>
            </xsl:when>
            <xsl:when test="$element &lt;= map:get($tree, 'value')">
                <xsl:map>
                    <xsl:map-entry key="'value'" select="map:get($tree, 'value')"/>
                    <xsl:map-entry key="'left'" select="f:insert-left($tree, $element)"/>
                    <xsl:map-entry key="'right'" select="map:get($tree, 'right')"/>
                </xsl:map>
            </xsl:when>
            <xsl:otherwise>
                <xsl:map>
                    <xsl:map-entry key="'value'" select="map:get($tree, 'value')"/>
                    <xsl:map-entry key="'right'" select="f:insert-right($tree, $element)"/>
                    <xsl:map-entry key="'left'" select="map:get($tree, 'left')"/>
                </xsl:map>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="f:insert-left">
        <xsl:param name="tree"/>
        <xsl:param name="element"/>
        <xsl:sequence select="f:insert($tree, $element, 'left')"/>
    </xsl:function>

    <xsl:function name="f:insert-right" as="map(*)">
        <xsl:param name="tree"/>
        <xsl:param name="element"/>
        <xsl:sequence select="f:insert($tree, $element, 'right')"/>
    </xsl:function>
    
    <xsl:function name="f:insert" as="map(*)">
        <xsl:param name="tree"/>
        <xsl:param name="element"/>
        <xsl:param name="direction" as="xs:string"/>
        <xsl:variable name="branch" select="map:get($tree, $direction)"/>
        <xsl:choose>
            <xsl:when test="empty($branch)">
                <xsl:sequence select="f:tree($element)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="f:insert-into-tree($branch, $element)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="f:print-map">
        <xsl:param name="map" as="map(*)?"/>
        <xsl:variable name="serProps" as="element()">
            <serialization-parameters xmlns="http://www.w3.org/2010/xslt-xquery-serialization">
                <method value="json"/>
                <indent value="true"/>
            </serialization-parameters>
        </xsl:variable>
        <xsl:value-of select="serialize($map, $serProps)"/>
    </xsl:function>
    
    <xsl:function name="f:tree" as="map(*)">
        <xsl:param name="value"/>
        <xsl:map>
            <xsl:map-entry key="'value'" select="$value"/>
            <xsl:map-entry key="'left'"/>
            <xsl:map-entry key="'right'"/>
        </xsl:map>
    </xsl:function>
</xsl:stylesheet>