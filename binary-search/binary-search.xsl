<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:f="f" version="3.0">
    <xsl:function name="f:get-index">
        <xsl:param name="needle"/>
        <xsl:param name="haystack"/>
        <xsl:value-of select="f:binary-search($needle, $haystack, 0)"/>
    </xsl:function>
    
    <xsl:function name="f:binary-search">
        <xsl:param name="needle"/>
        <xsl:param name="stack"/>
        <xsl:param name="count" as="xs:integer"/>
        <!-- get the middle -->
        <xsl:variable name="middle-index" select="max((1, xs:integer(floor(count($stack) div 2))))" as="xs:integer"/>
        <xsl:variable name="middle" select="$stack[$middle-index]"/>
        <xsl:variable name="smallest" select="$stack[1]"/>
        <xsl:variable name="largest" select="$stack[last()]"/>
        <xsl:choose>
            <xsl:when test="$smallest > $largest or $needle &lt; $smallest or $needle > $largest" >
                <xsl:sequence select="-1"/>
            </xsl:when>
            <xsl:when test="$needle = $middle">
                <xsl:sequence select="$count + $middle-index"/>
            </xsl:when>
            <xsl:when test="$needle &lt; $middle">
                <xsl:sequence select="f:binary-search($needle, $stack[position() &lt; $middle-index], $count)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="f:binary-search($needle, $stack[position() > $middle-index], $count + $middle-index)"></xsl:sequence>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>
