<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns:f="f" version="3.0">

    <xsl:function name="f:isPrime" as="xs:boolean">
        <xsl:param name="number" as="xs:integer"/>
        <xsl:variable name="isPrime" as="xs:boolean?">
            <xsl:choose>
                <xsl:when test="$number &lt; 2">
                    <xsl:sequence select="false()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:iterate select="2 to xs:integer(math:sqrt($number))">
                        <xsl:if test="$number mod current() = 0">
                            <xsl:sequence select="false()"/>
                            <xsl:break/>
                        </xsl:if>
                    </xsl:iterate>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="not($isPrime = false())"/>
    </xsl:function>
</xsl:stylesheet>
