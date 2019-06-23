<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:f="f" version="3.0">
    <xsl:output method="text"/>
    <xsl:variable name="single-unit" select="/*/*[1]"/>
    <xsl:variable name="dash-char" select="'-'"/>
    <xsl:template match="/">
        <xsl:if test="for $b in //book return $b[not(element()/local-name() = (//book except $b)/element()/local-name())]">
            <xsl:message terminate="yes">All elements directly below the root element should have the same child elements.</xsl:message>
        </xsl:if>
        <xsl:call-template name="table"/>
    </xsl:template>
    
    <xsl:template name="table">
        <xsl:variable name="dash-line">
            <xsl:variable name="dash"><xsl:apply-templates select="$single-unit" mode="dashes"/></xsl:variable>
            <xsl:value-of select="$dash"/>
        </xsl:variable>
        
        <xsl:value-of select="$dash-line"/>
        <xsl:call-template name="headers"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="$dash-line"/>
        <xsl:apply-templates select="/*/*" mode="data"/>
        <xsl:value-of select="$dash-line"/>
    </xsl:template>

    <xsl:template match="*" mode="data">
        <xsl:text>|</xsl:text>
        <xsl:for-each select="*">
            <xsl:variable name="len">
                <xsl:apply-templates select="." mode="max-length-of-cousin"/>
            </xsl:variable>
            <xsl:value-of
                select="concat(., f:print-character-times(' ', xs:integer($len - string-length(.))))"/>
            <xsl:text>|</xsl:text>
        </xsl:for-each>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template name="headers">
        <xsl:text>|</xsl:text>
        <xsl:apply-templates select="$single-unit/*" mode="headers"/>
    </xsl:template>

    <xsl:template match="*" mode="headers">
        <xsl:variable name="head" select="local-name() => upper-case()"/>
        <xsl:variable name="length">
            <xsl:apply-templates select="." mode="max-length-of-cousin"/>
        </xsl:variable>
        <xsl:value-of select="$head"/>
        <xsl:value-of
            select="f:print-character-times(' ', xs:integer($length - string-length($head)))"/>
        <xsl:text>|</xsl:text>
    </xsl:template>

    <xsl:template match="*" mode="row">
        <xsl:value-of select="*" separator=" | "/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="*" mode="dashes">
        <xsl:apply-templates select="*" mode="create-dash"/>
        <xsl:text expand-text="true">{$dash-char}&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="*" mode="create-dash">
        <xsl:variable name="len">
            <xsl:apply-templates select="." mode="max-length-of-cousin"/>
        </xsl:variable>
        <xsl:value-of select="f:dash(xs:integer($len + 1))"/> <!--1 extra to account for pipe in header row-->
    </xsl:template>

    <xsl:template match="*" mode="max-length-of-cousin">
        <xsl:variable name="cousins"
            select="self::* | ../(following-sibling::*|preceding-sibling::*)/*[name() = current()/name()]"/>
        <xsl:value-of
            select="
                max(for $c in $cousins
                return
                    string-length($c))"
        />
    </xsl:template>

    <xsl:function name="f:dash">
        <xsl:param name="len" as="xs:integer"/>
        <xsl:value-of select="f:print-character-times($dash-char, $len)"/>
    </xsl:function>

    <xsl:function name="f:print-character-times">
        <xsl:param name="char" as="xs:string"/>
        <xsl:param name="times"/>
        <xsl:value-of
            select="
                string-join(for $i in 1 to $times
                return
                    $char)"
        />
    </xsl:function>
</xsl:stylesheet>
