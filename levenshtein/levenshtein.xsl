<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="f" version="3.0">
    <xsl:template match="/">
        <xsl:value-of select="f:levenshtein-distance('crap', 'raps')"/>
    </xsl:template>
    <xsl:function name="f:levenshtein-distance" as="xs:integer">
        <xsl:param name="first" as="xs:string?"/>
        <xsl:param name="second" as="xs:string?"/>
        <xsl:choose>
            <xsl:when test="not(string-length($first))">
                <xsl:sequence select="string-length($second)"/>
            </xsl:when>
            <xsl:when test="not(string-length($second))">
                <xsl:sequence select="string-length($first)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence
                    select="min((
                    f:levenshtein-distance(f:without-last($first), $second) + 1, 
                    f:levenshtein-distance($first, f:without-last($second)) + 1,
                    f:levenshtein-distance(f:without-last($first), f:without-last($second)) + xs:integer(f:char-at($first, string-length($first)) != f:char-at($second, string-length($second)))))"
                />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="f:without-last" as="xs:string?">
        <xsl:param name="str" as="xs:string"/>
        <xsl:sequence select="substring($str, 1, string-length($str) - 1)"/>
    </xsl:function>

    <xsl:function name="f:char-at">
        <xsl:param name="str" as="xs:string"/>
        <xsl:param name="pos" as="xs:integer"/>
        <xsl:sequence select="substring($str, $pos, 1)"/>
    </xsl:function>

</xsl:stylesheet>
