<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="f" version="3.0">
    <xsl:function name="f:merge-sort">
        <xsl:param name="seq"/>
        <xsl:choose>
            <xsl:when test="count($seq) &lt;= 1">
                <xsl:sequence select="$seq"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="mid" select="count($seq) div 2"/>
                <xsl:variable name="left" select="$seq[position() &lt;= $mid]"/>
                <xsl:variable name="right" select="$seq[position() > $mid]"/>
                <xsl:sequence select="f:merge(f:merge-sort($left), f:merge-sort($right))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="f:merge">
        <xsl:param name="left"/>
        <xsl:param name="right"/>
        <xsl:if test="not(empty($left) and empty($right))">
            <xsl:choose>
                <xsl:when test="$left[1] &lt;= $right[1] or empty($right)">
                    <xsl:sequence select="($left[1], f:merge(remove($left, 1), $right))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="($right[1], f:merge($left, remove($right, 1)))"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:function>
</xsl:stylesheet>
