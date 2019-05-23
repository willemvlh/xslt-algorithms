<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0"
    xmlns:f="f">
    <xsl:include href="./is-prime.xsl"/>
    <xsl:template match="/">
        <xsl:assert test="f:isPrime(13)"/>
        <xsl:assert test="f:isPrime(2)"/>
        <xsl:assert test="not(f:isPrime(1))"/>
        <xsl:assert test="not(f:isPrime(32))"/>
        <xsl:assert test="not(f:isPrime(93885))"/>
        <xsl:assert test="f:isPrime(967)"/>
        <xsl:assert test="f:isPrime(9973)"/>
        <xsl:assert test="f:isPrime(95191)"/>
    </xsl:template>
</xsl:stylesheet>