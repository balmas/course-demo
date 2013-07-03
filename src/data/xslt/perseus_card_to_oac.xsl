<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:foaf="http://xmlns.com/foaf/0.1/" 
    xmlns:oac="http://www.openannotation.org/ns/" 
    xmlns:cnt="http://www.w3.org/2008/content#"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes"/>
    
    <xsl:param name="e_sourceUri"/>
    <xsl:param name="e_targetUri"/>
    <xsl:param name="e_citeTag"/>
    <xsl:param name="e_citeHier"/>
    
    
    <xsl:template match="/">
        <rdf:RDF>
            <xsl:apply-templates/>
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="milestone[@unit='card']">
        <xsl:variable name="milestone" select="."/>
        <xsl:variable name="nextCite" select="following-sibling::*[local-name(.) = $e_citeTag][1]/@n"/>
        <xsl:variable name="citeParts">
            <xsl:for-each select="tokenize($e_citeHier,',')">
                <xsl:variable name="unit" select="."/>
                <part><xsl:value-of select="$milestone/ancestor::*[@type = $unit]/@n"/></part>
            </xsl:for-each>
        </xsl:variable>
        <Annotation 
            xmlns="http://www.openannotation.org/ns/">
            <hasTarget xmlns="http://www.openannotation.org/ns/" 
                rdf:resource="{concat($e_sourceUri,':',string-join(($citeParts/part,$milestone/@n),'.'))}"/>
            <hasBody xmlns="http://www.openannotation.org/ns/" 
                rdf:resource="{concat($e_targetUri,':',string-join(($citeParts/part,$nextCite),'.'))}"/>
            <creator xmlns="http://purl.org/dc/terms/">
                <Agent xmlns="http://xmlns.com/foaf/0.1/" rdf:about="http://data.perseus.org/agents/system"/>
            </creator>
            <created xmlns="http://purl.org/dc/terms/"><xsl:value-of select="current-dateTime()"></xsl:value-of></created>
        </Annotation>
    </xsl:template>
    
    <xsl:template match="@*"/>
    
    
    <xsl:template match="node()">
        <xsl:apply-templates select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:template>
</xsl:stylesheet>