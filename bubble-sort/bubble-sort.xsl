<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="f">
    
    <xsl:function name="f:bubble-sort">
        <xsl:param name="seq"/>
        <xsl:variable name="passed" select="f:pass($seq)"/>
        <xsl:sequence select="$passed[last()]"/>
        <xsl:if test="count($seq) > 1">
            <xsl:sequence select="f:bubble-sort($passed[position() != last()])"/>
        </xsl:if>
    </xsl:function>

    <xsl:function name="f:pass">
        <xsl:param name="seq"/>
        <xsl:message select="$seq"/>
        <xsl:choose>
            <xsl:when test="count($seq) > 1">
                <xsl:variable name="sortedPair" select="f:compare($seq[1], $seq[2])"/>
                <xsl:sequence select="insert-before(f:pass(($sortedPair[1], $seq[position() > 2])), 1, $sortedPair[2])"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$seq[1]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="f:compare">
        <xsl:param name="a"/>
        <xsl:param name="b"/>
        <xsl:sequence select=" if ($a &lt; $b) then ($a, $b) else ($b, $a)"/>
    </xsl:function>
</xsl:stylesheet>
