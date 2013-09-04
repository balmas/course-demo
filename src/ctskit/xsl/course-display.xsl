<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: start-edition.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:dctype="http://purl.org/dc/dcmitype/"
	xmlns:ptext="http://www.perseus.org/meta/ptext.rdfs#"
	xmlns:perseus="http://www.perseus.org/meta/perseus.rdfs#"
	xmlns:persq="http://www.perseus.org/meta/persq.rdfs#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:tufts="http://www.tufts.edu/"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:cts="http://chs.harvard.edu/xmlns/cts3">
 
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  <xsl:param name="xml-only"/>
  <xsl:param name="blockid"/>
  <xsl:param name="hide"/>
  <xsl:param name="blocktype"/>
	<!-- Framework for main body of document -->
	<xsl:template match="/">
		<!-- can some of the reply contents in xsl variables
			for convenient use in different parts of the output -->
		<xsl:variable name="urnString">
			<xsl:value-of select="//cts:request/cts:requestUrn"/>
		</xsl:variable>
		<xsl:variable name="psg">
			<xsl:value-of select="//cts:request/cts:psg"/>
		</xsl:variable>
		<xsl:variable name="workUrn">
			<xsl:value-of select="//cts:request/cts:workUrn"/>
		</xsl:variable>
	  <div id="{$blockid}">
	    <xsl:if test="$hide">
	      <xsl:attribute name="style">display:none;</xsl:attribute>
	    </xsl:if>
	    <xsl:choose>
	      <xsl:when test="$xml-only">
	        <textarea><xsl:copy-of select="//tei:TEI|//tei:TEI.2"/></textarea>
	      </xsl:when>
	      <xsl:otherwise>
  				<div class="cts-content">
  					
					<xsl:choose>
						<xsl:when test="/cts:CTSError">
							<xsl:apply-templates select="cts:CTSError"/>
						</xsl:when>
						<xsl:when test="//cts:reply">
						  <div class="passage_urn"><xsl:value-of select="$urnString"/></div>
							<div class="cts-biblio">
							<xsl:choose>
								<xsl:when test="//cts:request/cts:edition">
									<p class="cts-quotation"><xsl:value-of select="//cts:request/cts:groupname"/>, <em>
										<xsl:value-of select="//cts:request/cts:title"/>
									</em>: <xsl:value-of select="//cts:request/cts:psg"/>
									</p>
									<p class="cts-quotation">
										<xsl:value-of select="//cts:request/cts:label"/>
									</p>
								</xsl:when>
								<xsl:when test="//cts:request/cts:translation">
								    <p class="cts-quotation">
										<xsl:value-of select="//cts:request/cts:groupname"/>, <em>
											<xsl:value-of select="//cts:request/cts:title"/>
										</em>: <xsl:value-of select="//cts:request/cts:psg"/></p>
								    <p class="cts-quotation">
										<xsl:value-of select="//cts:request/cts:label"/>
									</p>
								</xsl:when>
								<xsl:when test="//cts:request/cts:title">
								    <p class="cts-quotation">
										<xsl:value-of select="//cts:request/cts:groupname"/>, <em>
											<xsl:value-of select="//cts:request/cts:title"/>: <xsl:value-of select="//cts:request/cts:psg"/>
										</em></p>
								    <p class="cts-quotation">
										<xsl:value-of select="//cts:request/cts:label"/>
									</p>
								</xsl:when>
								<xsl:when test="//cts:request/cts:groupname">
								    <p class="cts-quotation">
										<xsl:value-of select="//cts:request/cts:groupname"/>
									</p>
								    <p class="cts-quotation">
										<xsl:value-of select="//cts:request/cts:label"/>
									</p>
								</xsl:when>
							  <xsl:otherwise>
							    <p class="cts-quotation">TODO - Source Text Title, Author, Edition info will be here.</p>
							  </xsl:otherwise>
							</xsl:choose>
							<!--p class="urn"> ( = <xsl:value-of select="$urnString"/> ) </p-->
							</div>
							<xsl:apply-templates select="//cts:reply"/>
						</xsl:when>
						<xsl:otherwise>
							<div class="cts-biblio">
								<p class="cts-quotation">
									<xsl:apply-templates select="//tei:TEI.2|//tei:TEI"/>
								</p>
							</div>
						</xsl:otherwise>
					</xsl:choose>
					<!--<xsl:choose>
						<xsl:when test="//cts:inv">
							<xsl:variable name="inv">
								<xsl:value-of select="//cts:inv"/>
							</xsl:variable>
							<xsl:variable name="lnkVar">./CTS?inv=<xsl:value-of select="$inv"/>&amp;request=GetPassagePlus&amp;urn=<xsl:value-of select="//cts:requestUrn"
							/></xsl:variable>
							<p>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$lnkVar"/>
									</xsl:attribute>
									<xsl:element name="img">
										<xsl:attribute name="src">xml.png</xsl:attribute>
									</xsl:element>
								</xsl:element>
							</p>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="lnkVar">./CTS?request=GetPassagePlus&amp;urn=<xsl:value-of select="//cts:requestUrn"/></xsl:variable>
							<p>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$lnkVar"/>
									</xsl:attribute>
									<xsl:element name="img">
										<xsl:attribute name="src">xml.png</xsl:attribute>
									</xsl:element>
								</xsl:element>
							</p>
						</xsl:otherwise>
					</xsl:choose>-->
				</div>
	      </xsl:otherwise>
	    </xsl:choose>
	  </div>
	  
	</xsl:template>
	<!-- End Framework for main body document -->
	<!-- Match elements of the CTS reply -->
	<xsl:template match="cts:reply">
<!--		<xsl:if test="(@xml:lang = 'grc') or (@xml:lang = 'lat')">
			<div class="chs-alphaios-hint">Because this page has Greek or Latin text on it, it can take advantage of the morphological and lexical tools from the <a href="http://alpheios.net/" target="blank">Apheios Project</a>. If you would like to be able to learn about Greek and Latin words by double-clicking on them, you should use <a href="http://www.getfirefox.com" target="blank">Firefox</a>, and download the <a href="http://alpheios.net/">Alpheios Plugin</a>. Many thanks to the brilliant developers at Alpheios for working with us! For the moment, the Alpheios tools will not correctly identify words that are partly supplied or unclear on the original document.</div>
		</xsl:if>-->
			<!--<xsl:attribute name="lang">
				<xsl:choose>
				<xsl:when test="@xml:lang = 'lat'">la</xsl:when>
				<xsl:otherwise><xsl:value-of select="@xml:lang"/></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>-->
			<!--<xsl:if test="(//cts:reply/@xml:lang = 'grc') or (//cts:reply/@xml:lang = 'lat')">
				<xsl:attribute name="class">cts-content alpheios-enabled-text</xsl:attribute>
			</xsl:if>-->			
			<xsl:apply-templates/>
	  <!-- The space is necessary here so that we don't run the risk of
	outputting an empty DIV tag, which some browsers may interpret
	poorly, if there are no footnotes -->
	  <div class="footnotes en"><xsl:text> </xsl:text>
	    <xsl:call-template name="footnotes" />
	  </div>
	</xsl:template>
	<xsl:template match="cts:CTSError">
		<h1>CTS Error</h1>
		<p class="cts:error">
			<xsl:apply-templates select="cts:message"/>
		</p>
		<p>Error code: <xsl:apply-templates select="cts:code"/></p>
		<p>CTS library version: <xsl:apply-templates select="cts:libraryVersion"/>
		</p>
		<p>CTS library date: <xsl:apply-templates select="cts:libraryDate"/>
		</p>
	</xsl:template>
	<xsl:template match="cts:prevnext">
		<!-- TODO add the next/previous links -->
	</xsl:template>
	
	<!-- TEI TEMPLATES FROM P4 -->
	 <xsl:param name="linenumber" select="4" />
  <xsl:param name="document_id">Perseus%3Atext%3A1999.04.0062"</xsl:param>

  <xsl:param name="query">Perseus:text:1999.01.0001</xsl:param>

  <!-- 
    This parameter contains the authority name of an entity to highlight; it's
    used when the user has followed a link to the text page from within the
    named-entity browser.
  -->
  <xsl:param name="highlight_authname" select="''" />


  <!--
    Parameters for voting. "Form" and "which" specify the form that's being
    voted for, and "which" indicates which occurrence of the form this is
    in the given chunk (is this the first "et", or the second, or...?).
    "Lexquery" specifies the lexicon whose senses are being voted for (if this
    is a sense-vote); "voting_lang" indicates the language of the form that's
    being voted on.
  -->
  <xsl:param name="lexquery" select="''" />
  <xsl:param name="form" select="''" />
  <xsl:param name="which" select="0" />
  <xsl:param name="voting_lang" select="'en'" />

  <!--
    The document ID and subquery of the passage where the voted-on
    word lives.
  -->
  <xsl:param name="source_id" select="''" />
  <xsl:param name="subquery" select="''" />

  <!--
    The primary language of the document we're rendering. Used to
    render Greek fonts if we need to.
  -->
  <xsl:param name="lang" select="'en'" />


  <!--
    For lexicon entries, "sourcework" represents the document containing the
    word that we're looking up, in ABO format, "sourcesub" the subquery.
    This allows us to give special treatment to lexicon citations that point
    back to the work we came from, and perhaps even more special treatment
    to citations that point to the specific passage we came from.
  -->
  <xsl:param name="sourcework" select="''" />
  <xsl:param name="sourcesub" select="0" />

  <!--
    Should we display "[select]" links for this entry? By default, no; but we
    set this to 'true' if we're viewing a lexicon entry in a specific context
    (i.e., if we have values for "source_id" and "subquery").
  -->
  <xsl:param name="allow_voting" select="false" />

  <xsl:template match="rdf:Description"></xsl:template>

<xsl:template match="tei:text[parent::tei:p and not(ancestor::tei:quote[@rend='blockquote'])]">
<blockquote><xsl:apply-templates /></blockquote>
</xsl:template>

<xsl:template match="tei:closer|tei:CLOSER|tei:Closer">
<div align="right"><xsl:apply-templates /></div>
</xsl:template>

<xsl:template match="tei:lb|tei:LB">
  <xsl:choose>
    <xsl:when test="@ed='F1'">
      <!-- Don't put a line break in Shakespeare texts with this -->
    </xsl:when>
    <xsl:otherwise>
      <br/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:znote">
  <xsl:choose>
    <xsl:when test="not(@place)">
AAA<xsl:apply-templates />B
    </xsl:when>
    <xsl:otherwise><xsl:apply-templates /></xsl:otherwise>
  </xsl:choose>

</xsl:template>

  <xsl:key name="fnotes" match="tei:note[@place='foot']|tei:note[@place='unspecified']|tei:note[@place='text']|tei:note[not(@place)]" 
     use="'current'" />

  <xsl:template name="footnotes">
    <xsl:for-each select="key('fnotes', 'current')">
      <xsl:variable name="noteID">
	  <xsl:call-template name="footnoteID" />
      </xsl:variable>

      <!-- Make footnotes from our grammars look slightly nicer -->
      <xsl:if test="position() = 1 and @rend='smyth'">
	  <hr />
      </xsl:if>
      <p id="note{$noteID}">
      <xsl:choose>
	  <xsl:when test="@rend='smyth'">
	      <strong><xsl:value-of select="@n" /><xsl:text> D. </xsl:text></strong>
	  </xsl:when>
	  <xsl:otherwise>
	      <a href="#note-link{$noteID}"><xsl:value-of select="position()"/></a><xsl:text> </xsl:text>
	  </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
	<xsl:when test="@lang">
	  <xsl:call-template name="language-filter">
	    <xsl:with-param name="lang" select="@lang" />
	  </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	    <xsl:apply-templates />
	</xsl:otherwise>
      </xsl:choose>
      </p>
    </xsl:for-each>
  </xsl:template>

    <xsl:template match="tei:gloss">
	<span class="gloss"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="tei:emph[@rend='ital']">
	<em><xsl:apply-templates /></em>
    </xsl:template>

    <xsl:template match="tei:emph">
	<strong><xsl:apply-templates /></strong>
    </xsl:template>

<xsl:template match="tei:text[ancestor::tei:text]">
<p/>
<div class="embeddedtext">
<xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
</xsl:call-template>
</div>
<br/>
</xsl:template>

  <xsl:template match="tei:entry|tei:entryfree">
    <p>
    <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template name="correct-sense">
      <xsl:if test="descendant::tei:bibl[@n=concat($sourcework,':',$sourcesub)]">
	  <span style="font-weight: bold; color: red; font-size: large;">*</span> 
      </xsl:if>
  </xsl:template>

  <xsl:template match="tei:sense[@level]">
    <div class="lex_sense lex_sense{@level}">
	<xsl:call-template name="correct-sense" />
      <xsl:if test="not(@n='')">
        <b>
        <xsl:choose>
          <!-- hack to force LS senses matching (a|b|d|e|g|z) to be interpreted as beta code-->
          <xsl:when test="@n = '(a)' or @n='(b)' or @n='(d)' or @n='(e)' or @n='(g)' or @n='(z)'">
        	(<span class="greek"><xsl:value-of select="translate(@n,'()','')"/></span>).
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="@n"/>.</xsl:otherwise>
        </xsl:choose>  
	    <xsl:call-template name="sense_vote" /></b>
      </xsl:if>
      <xsl:apply-templates select="node()"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:sense[@n=0]">
    <div class="lex_sense">
      <xsl:call-template name="correct-sense" />
      <xsl:call-template name="sense_vote" />
        <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="tei:sense">
    <div class="lex_sense">
      <xsl:call-template name="correct-sense" />
        <xsl:if test="not(@n='')">
           <b><xsl:value-of select="@n"/>. 
	<xsl:call-template name="sense_vote" />
	    </b>
        </xsl:if>
        <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template name="sense_vote">
      <xsl:if test="$allow_voting = 'true'">
	  <xsl:element name="a">
	      <xsl:attribute name="style">
		  <xsl:text>font-size: small; color: blue; text-decoration: none;</xsl:text>
	      </xsl:attribute>
	      <xsl:attribute name="href">
		  <xsl:value-of select="concat('submitvote?type=sense&amp;lexquery=',$lexquery,'&amp;doc=',$source_id,'&amp;subquery=',$subquery,'&amp;form=',$form,'&amp;which=',$which,'&amp;sense_id=',@id,'&amp;lang=',$voting_lang)" />
	      </xsl:attribute>
	      [select]
	  </xsl:element>
      </xsl:if>
  </xsl:template>

  <xsl:template match="tei:orth|tei:form/tei:orth">
    <b><xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template></b><xsl:text> </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:gen">
    <xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="tei:usg">
    <b><xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template></b>
  </xsl:template>

  <xsl:template match="tei:head">
    <h4>
      <xsl:call-template name="language-filter">
        <xsl:with-param name="lang" select="@lang" />
      </xsl:call-template>
    </h4>
  </xsl:template>

  <xsl:template match="tei:head[@rend='braced' or @rend='brace']">
    <b>
      <xsl:call-template name="language-filter">
        <xsl:with-param name="lang" select="@lang" />
      </xsl:call-template>
    </b>
    <br/>
  </xsl:template>

  <xsl:template match="tei:headLabel">
    <h4>
      <xsl:call-template name="language-filter">
        <xsl:with-param name="lang" select="@lang" />
      </xsl:call-template>
    </h4>
  </xsl:template>

  <xsl:template match="tei:label">
    <b>
      <xsl:call-template name="language-filter">
        <xsl:with-param name="lang" select="@lang" />
      </xsl:call-template>
    </b>
  </xsl:template>

  <xsl:template match="tei:docauthor|tei:docAuthor">
    <h5>
    <xsl:apply-templates />
    </h5>
  </xsl:template>

  <xsl:template match="tei:surname">
    <!-- careful of empty surname tags, since some have been sighted! -->
    <span class="surname">
	<xsl:choose>
	    <xsl:when test="text()">
		<xsl:apply-templates />
	    </xsl:when>
	    <xsl:when test="@n">
		<xsl:value-of select="@n" />
	    </xsl:when>
	    <xsl:otherwise>
		<xsl:text> </xsl:text>
	    </xsl:otherwise>
	</xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="tei:forename">
    <span class="forename">
	<xsl:choose>
	    <xsl:when test="text()">
		<xsl:apply-templates />
	    </xsl:when>
	    <xsl:when test="@n">
		<xsl:value-of select="@n" />
	    </xsl:when>
	    <xsl:otherwise>
		<xsl:text> </xsl:text>
	    </xsl:otherwise>
	</xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="tei:head[@type=hidden]">
  </xsl:template>

  <xsl:template name="figalign">
    <xsl:variable name="figID">
      <xsl:number level="any" count="tei:figure[@n!='']" from="tei:body"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$figID mod 2 = 0">
        <xsl:text>left</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>right</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:name[@type='place']">
    <span style="background-color: aaaaee;">
    <xsl:choose>
      <xsl:when test="@reg!=''">
        <a target="gazetteer" href="http://maps.yahoo.com/maps_result?name=&amp;csz={substring-before(@reg, ', ')}%2C+{substring-after(@reg, ', ')}">
          <xsl:apply-templates />
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
    </span>
  </xsl:template>


  <!-- This is meant for HEAD tags with multiple tags inside them, like
    the Pindar odes
    -->
  <xsl:template match="tei:head/tei:title">
    <div class="multitaghead">
		<xsl:call-template name="language-filter">
		    <xsl:with-param name="lang" select="@lang" />
		</xsl:call-template>
    </div>    
  </xsl:template>

  <xsl:template match="tei:title">
    <u>
	<xsl:call-template name="language-filter">
	    <xsl:with-param name="lang" select="@lang" />
	</xsl:call-template>
    </u>
  </xsl:template>



  <xsl:template match="tei:name[@key!='']">
    <!--<a target="gazetteer" href="http://www.getty.edu/vow/TGNFullDisplay?find=&amp;place=&amp;nation=&amp;english=Y&amp;subjectid={substring-after(@key, 'tgn,')}">-->
      <xsl:apply-templates />
    <!--</a>-->
  </xsl:template>
  
  <xsl:template match="tei:etym">
    <xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="tei:ovar">
    <i><xsl:value-of select="."/></i> 
  </xsl:template>

  <xsl:template match="tei:hi[@rend='center']">
    <center><xsl:value-of select="."/></center>
  </xsl:template>
  
  <xsl:template match="tei:hi[@rend='super']">
    <sup><xsl:value-of select="."/></sup>
  </xsl:template>
  
  <xsl:template match="tei:hi[@rend='bold']">
    <b><xsl:value-of select="."/></b>
  </xsl:template>
	
	<xsl:template match="tei:hi[@rend='caps']">
		<span style="font-variant: small-caps;"><xsl:apply-templates /></span>
	</xsl:template>

  <xsl:template match="tei:hi[@rend='ital' or @rend='italics' or @rend='italic']">
    <xsl:if test="text() or child::*">
    	<i><xsl:apply-templates /></i> 
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:tr|tei:trans/tei:tr">
    <i><xsl:value-of select="."/></i> 
  </xsl:template>

  <xsl:template match="tei:argument">
    <xsl:apply-templates />
    <hr/>
  </xsl:template>

  <xsl:template match="tei:opener">
    <div align="right">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="tei:dateline">
    <xsl:apply-templates /><br/>
  </xsl:template>

  <xsl:template match="tei:salute">
    <xsl:apply-templates /><br/>
  </xsl:template>

  <xsl:template match="tei:p[not(@rend)]">
      <xsl:apply-templates /><p/>
  </xsl:template>

  <xsl:template match="tei:p[@rend='before']">
    <p/><xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="tei:gap">
    <xsl:choose>
      <xsl:when test="@desc">
        <br/><xsl:value-of select="@desc" />
      </xsl:when>
      <xsl:when test="@reason">
        <br/><span class="english"><xsl:value-of select="@reason" /></span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> ... </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:note[@place='inset']">
    <div style="float:right">
    <xsl:apply-templates />&#160;
    </div>
  </xsl:template>

  <xsl:template match="tei:note//tei:note">
    <xsl:apply-templates />&#160;
  </xsl:template>

  <xsl:template match="tei:note[@place='sum']">
    <h4><xsl:apply-templates /></h4>
  </xsl:template>

  <xsl:template name="margalign">
    <xsl:variable name="margID">
      <xsl:number level="any" count="tei:note[@place='marg']" from="tei:body"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$margID mod 2 = 0 or @resp='ed'">
        <xsl:text>left</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>right</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:note[@place='marg']">
    <xsl:variable name="align">
      <xsl:call-template name="margalign"/>
    </xsl:variable>
    <table width="100" align="{$align}"><tr><td bgcolor="#f0f0f0"><h5>
      <span class="sidetext">
      <xsl:apply-templates />
      </span>
    </h5></td></tr></table>
  </xsl:template>

  <xsl:template match="tei:note[@place='inline' and @resp!='' and @rend='credit']">
    <xsl:apply-templates />
    <xsl:text> -- </xsl:text>
    <xsl:value-of select="@resp"/>
  </xsl:template>

  <xsl:template match="tei:item[ancestor::tei:argument and position() != 1]">
	-- <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="tei:item[tei:bibl or tei:list]">
     <dd><xsl:apply-templates /></dd>
  </xsl:template>

  <xsl:template match="tei:item">
    <xsl:choose>
	<xsl:when test="parent::tei:list[@type='illustrations']">
	    <xsl:apply-templates />
	</xsl:when>
	<xsl:otherwise>
	   <li><xsl:apply-templates /></li>
	</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:note[@place='inline']">
      <xsl:choose>
	  <xsl:when test="@rend='ag' or @rend='smyth'">
	      <p style="font-size: small; margin: 10px 5%;">

		  <xsl:call-template name="permalink">
		      <xsl:with-param name="smythp" select="(preceding::tei:milestone[@unit='smythp'])[last()]/@n" />

		      <!-- Pass a nonempty parameter for the subsection iff
		      we're currently in a subsection (i.e., we haven't seen
		      any new sections since we last saw a subsection). -->

		      <xsl:with-param name="smythsub">
			  <xsl:if test="(preceding::tei:milestone[@unit='smythp' or @unit='smythsub'])[last()]/@unit='smythsub'">
			      <xsl:value-of select="(preceding::tei:milestone[@unit='smythsub'])[last()]/@n" />
			  </xsl:if>
		      </xsl:with-param>

		      <xsl:with-param name="current_note" select="@n" />
		  </xsl:call-template>

		  <xsl:text> </xsl:text>

		  <span style="font-variant: small-caps;">
		      <xsl:text>Note</xsl:text>
		      <xsl:if test="@n &gt; 1 or (following-sibling::tei:note[@place='inline' and (@rend='ag' or @rend='smyth')][1]/@n) &gt; 1">

			  <xsl:text> </xsl:text>
			  <xsl:value-of select="@n" />
		      </xsl:if>
		      <xsl:text>.--</xsl:text>
		  </span>
		  <xsl:apply-templates />
	      </p>
	  </xsl:when>
	  <xsl:otherwise>
	      <i><xsl:apply-templates /></i>
	  </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:pb">
  <xsl:choose>
    <xsl:when test="@id">
	  	<xsl:variable name="pagenum"><xsl:value-of select="substring-after(@id, 'p.')"/></xsl:variable>
		<xsl:if test="$pagenum != ''">
			<span lang="en">[p. <xsl:value-of select="$pagenum"/>]</span>
	  	</xsl:if>
	  </xsl:when>
	</xsl:choose>
  </xsl:template>

  <xsl:template name="footnoteID">
    <xsl:choose>
      <xsl:when test="@id">
        <xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:when test="@n">
        <xsl:value-of select="@n"/>
      </xsl:when>
      <xsl:when test="ancestor::tei:back">
        <xsl:number level="any"  count="tei:note[@place='foot']|tei:note[@place='unspecified']|tei:note[@place='text']|tei:note[not(@place)]" from="tei:back"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:number level="any" count="tei:note[@place='foot']|tei:note[@place='unspecified']|tei:note[@place='text']|tei:note[not(@place)]" from="tei:body"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:note[@place='foot']|tei:note[@place='unspecified']|tei:note[@place='text']|tei:note[not(@place)]">
    <xsl:variable name="identifier">
      <xsl:call-template name="footnoteID"/>
    </xsl:variable>
    <xsl:if test="not(@rend) or @rend != 'smyth'">
	<a id="note-link{$identifier}" href="#note{$identifier}"><sup><xsl:value-of select="count(preceding::tei:note[@place = 'foot' or @place = 'unspecified' or @place = 'text' or not(@place)]) + 1" /></sup></a>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:cit">
    <xsl:choose>
      <xsl:when test="tei:quote/tei:l or tei:quote/tei:sp or tei:quote/tei:p or tei:quote/tei/llg">
        <blockquote>
          <xsl:call-template name="block-quote" />
        </blockquote>
      </xsl:when>
      <xsl:otherwise>
	  <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="block-quote">
    <p><xsl:apply-templates select="tei:quote"/></p>
    <div align="right"><xsl:apply-templates select="tei:bibl"/></div>
  </xsl:template>

  <xsl:template match="tei:list">
	<xsl:choose>
	  <xsl:when test="parent::tei:argument">
		<xsl:apply-templates />
	  </xsl:when>
	  <xsl:when test="@type='ordered'">
	      <ol><xsl:apply-templates /></ol>
	  </xsl:when>
	  <xsl:when test="@type='gloss'">
	      <dl><xsl:apply-templates /></dl>
	  </xsl:when>
	  <xsl:when test="@type='illustrations'">
	      <p><table width="100%" style="text-align:center">
		   <xsl:for-each select="child::tei:item">
	            <tr>
		      <td width="33%">
			<xsl:apply-templates />
		      </td>
		    </tr>
		    </xsl:for-each>
		</table>
		</p>
	  </xsl:when>
	  <xsl:otherwise>
		<ul><xsl:apply-templates /></ul>
	  </xsl:otherwise>
	</xsl:choose>
  </xsl:template>

  <xsl:template match="tei:listbibl|tei:listBibl">
    <ul><xsl:apply-templates /></ul>
  </xsl:template>

  <xsl:template match="tei:bibl[parent::tei:cit]">
    <xsl:text> </xsl:text>
    <xsl:call-template name="bibl-link"/>
  </xsl:template>

  <xsl:template match="tei:bibl[parent::tei:listbibl]">
    <li>
      <xsl:call-template name="bibl-link"/>
    </li>
  </xsl:template>

  <xsl:template match="tei:bibl">
    <xsl:call-template name="bibl-link"/>
  </xsl:template>

  <xsl:template name="bibl-link">
    <xsl:choose>
        <xsl:when test="not(@n) and . = ''"></xsl:when>
	<xsl:when test="not(@valid)">
	    <i><xsl:call-template name="language-filter">
              <xsl:with-param name="lang" select="@lang" />
	      <xsl:with-param name="default" select="'en'" />
            </xsl:call-template></i>
	</xsl:when>
	<xsl:when test="@n=concat($sourcework,':',$sourcesub)">
	    <span style="font-size: x-large;"><a href="text?doc={@n}&amp;lang=original" target="_new"><xsl:call-template name="language-filter">
              <xsl:with-param name="lang" select="@lang" />
	      <xsl:with-param name="default" select="'en'" />
            </xsl:call-template></a></span>
	</xsl:when>
      <xsl:when test="@n and $sourcework != 'none' and starts-with(@n, $sourcework)">
	  <b><a href="text?doc={@n}&amp;lang=original" target="_new"><xsl:call-template name="language-filter">
            <xsl:with-param name="lang" select="@lang" />
	    <xsl:with-param name="default" select="'en'" />
          </xsl:call-template></a></b>
      </xsl:when>
      <xsl:when test="@n">
	  <a href="text?doc={@n}&amp;lang=original" target="_new">
	    <xsl:call-template name="language-filter">
            <xsl:with-param name="lang" select="@lang" />
	    <xsl:with-param name="default" select="'en'" />
          </xsl:call-template>
	  </a>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="language-filter">
          <xsl:with-param name="lang" select="@lang" />
	  <xsl:with-param name="default" select="'en'" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:xref[@n!='']">
    <a href="{@n}"><xsl:apply-templates /></a>
  </xsl:template>

  <xsl:template match="tei:ref[@target!='']">
    <a href="text?doc={$document_id}:id={@target}"><xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template></a>
  </xsl:template>

  <xsl:template match="//tei:ref[@lang!='']">
  	<xsl:call-template name="language-filter">
		<xsl:with-param name="lang" select="@lang"/>
	</xsl:call-template>	
  </xsl:template>
	
 <xsl:template match="tei:quote|tei:q">
   
   <xsl:choose>
     <xsl:when test="@rend[contains(.,'blockquote')]">
      <blockquote><xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template></blockquote>
      </xsl:when>
     <xsl:otherwise>

       <xsl:choose>
	 <xsl:when test="parent::tei:cit and ancestor::tei:quote">
		<xsl:apply-templates />
	 </xsl:when>
	 <xsl:otherwise>

	   <xsl:choose>
	     <xsl:when test="self::tei:quote">
	       <xsl:text>&#x201C;</xsl:text>
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:text>&#x2018;</xsl:text>
	     </xsl:otherwise>
	 </xsl:choose>


       <xsl:call-template name="language-filter">
         <xsl:with-param name="lang" select="@lang" />
       </xsl:call-template>
 
       <xsl:choose>
	 <xsl:when test="parent::tei:cit and ancestor::tei:quote">
	 </xsl:when>
	 <xsl:otherwise>
	   <xsl:choose>
	     <xsl:when test="self::tei:quote">
	       <xsl:text>&#x201D;</xsl:text>
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:text>&#x2019;</xsl:text>
	     </xsl:otherwise>
	   </xsl:choose>


	 </xsl:otherwise>
       </xsl:choose>
  	 </xsl:otherwise>
       </xsl:choose>
    

       </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:castlist|tei:castList">
    <xsl:apply-templates />
  </xsl:template>

<xsl:template match="tei:castGroup">
    <p>
	<xsl:apply-templates />
    </p>
</xsl:template>

  <xsl:template match="tei:castItem">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="tei:role">
    <xsl:choose>
      <xsl:when test="following-sibling::tei:roleDesc">
        <xsl:apply-templates />
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:when test="not(text()) and not(child::*)"/>
      <xsl:when test="parent::tei:castItem[@type='list']">
        <xsl:apply-templates />
	<xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates /><br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:roleDesc">
    <xsl:apply-templates /><br/>
  </xsl:template>

  <xsl:template match="tei:sp">
    <xsl:if test="position()!=1">
      <p/>
    </xsl:if>
    <xsl:if test="@n!='' and tei:speaker">
      <b><xsl:value-of select="@n"/></b><br/>
    </xsl:if>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="tei:speaker">
    <xsl:if test="parent::tei:sp">
      <p/>
    </xsl:if>
    <b><xsl:value-of select="."/></b><br/>
  </xsl:template>

  <xsl:template match="tei:stage">
    <i><xsl:apply-templates /></i>
    <xsl:choose>
	<xsl:when test="not(parent::tei:p)">
	    <br/>
	</xsl:when>
	<xsl:otherwise>
	    <xsl:text> </xsl:text>
	</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:l|tei:L">
    <xsl:variable name="linenumber">
      <xsl:number />
    </xsl:variable>

    <xsl:if test="@n!='tr' and @rend != 'tr' and @n mod 5 = 0">
      <span style="float: right" class="linenumber"><span class="english"><xsl:value-of select="@n"/></span></span>
    </xsl:if>

    <xsl:if test="ancestor::tei:lg[@type='pentameter' or @type='altindent'] and $linenumber mod 2 = 0">
      &#160;&#160;&#160;&#160;
    </xsl:if>

    <xsl:if test="@part='F'">
      &#160;&#160;&#160;&#160;--
    </xsl:if>

    <xsl:if test="@rend='indent'">
      &#160;&#160;&#160;&#160;
    </xsl:if>
    <xsl:apply-templates/><br/>
  </xsl:template>

  <!-- this is used by at least the Shakespeare texts -->
  <xsl:template match="tei:lb[@n!='' and @ed='G']">
<!--    <xsl:if test="number(@n)=NaN or @n mod 5 = 0">-->
      <span style="float: right" class="linenumber"><span class="english">(<xsl:value-of select="@n"/>)</span></span>
<!--    </xsl:if>-->
    <br/>
  </xsl:template>

  <xsl:template match="tei:lb[@n!='' and (@type='displayNum' or @rend='displayNum' or @rend='displayNumAndIndent')]">
      <br/>
      <xsl:if test="number(@n)=NaN or @n mod 5 = 0">
          <span style="float: right" class="linenumber"><span class="english"><xsl:value-of select="@n"/></span></span>
      </xsl:if>
      <!-- NB rend=indent when applied to lb means indent the NEXT line -->
      <xsl:if test="@rend='displayNumAndIndent'">
	      <span style="float: left" class="lbindent">&#160;&#160;&#160;&#160;</span>
      </xsl:if>
  </xsl:template>

  <xsl:template match="tei:lb[@rend='indent']"> 
    <!-- NB rend=indent when applied to lb means indent the NEXT line -->
    <br/>
	      <span style="float: left" class="lbindent">&#160;&#160;&#160;&#160;</span>
  </xsl:template>


  <xsl:template match="tei:lg|tei:lg1">
    <xsl:variable name="linecount" select="1" />
    <xsl:apply-templates/><p/>
  </xsl:template>

  <xsl:template match="tei:caesura">
    &#160;&#160;&#160;&#160;
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='chapter']">
    <b><xsl:value-of select="@n"/>.</b>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='smythp']">

      <xsl:call-template name="permalink">
	  <xsl:with-param name="smythp" select="@n" />
	  <xsl:with-param name="smythsub" select="''" />
	  <xsl:with-param name="current_note" select="''" />
      </xsl:call-template>

      <xsl:text> </xsl:text>
      <b><xsl:value-of select="@n"/>.</b>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='smythsub']">
      <xsl:variable name="current_smythsub" select="@n" />

      <xsl:call-template name="permalink">
	  <xsl:with-param name="smythp" select="(preceding::tei:milestone[@unit='smythp'])[last()]/@n" />
	  <xsl:with-param name="smythsub" select="@n" />
	  <xsl:with-param name="current_note" select="''" />
      </xsl:call-template>

      <xsl:text> </xsl:text>
      <b><i><xsl:value-of select="@n"/>.</i></b>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template name="permalink">
      <xsl:param name="smythp"/>
      <xsl:param name="smythsub"/>
      <xsl:param name="current_note"/>

      <xsl:variable name="link">
	  <xsl:text>chapter</xsl:text>
	  <xsl:value-of select="$smythp" />
	  <xsl:value-of select="$smythsub" />
	  <xsl:if test="$current_note != ''">
	      <xsl:text>.note</xsl:text>
	      <xsl:value-of select="$current_note"/>
	  </xsl:if>
      </xsl:variable>

      <a class="permalink" id="{$link}" href="#{$link}">[*]</a>
  </xsl:template>

  <!-- section numbers have to be wrapped in <span class="english"> tags to prevent
       the Greek transcoder from interpreting "184c" as xi. -->
  <xsl:template match="tei:milestone[@unit='section']">
    <xsl:if test="@n!=1">
      [<span class="english"><xsl:value-of select="@n"/></span>]
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='para']">
    <p/>
    <xsl:if test="@ref!=''">
      <span class="english"><xsl:value-of select="@ref"/></span>
    </xsl:if>
    <xsl:if test="parent::tei:l and position()!=1">
      <xsl:text>&#160;&#160;&#160;&#160;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='tale']">
    <h4><xsl:value-of select="@n"/></h4>
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='line' and @ed!='exclude']">
    [<xsl:value-of select="@n"/>]
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='verse']">
    <xsl:if test="@n!=1">
      [<xsl:value-of select="@n"/>]
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:div|tei:div1">
    <xsl:if test="@n!=1">
      [<span class="english"><xsl:value-of select="@n"/></span>]
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:choose>
	<xsl:when test="@lang">
	  <xsl:call-template name="language-filter">
	    <xsl:with-param name="lang" select="@lang" />
	  </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	    <xsl:apply-templates />
	</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:div2[@type='commline']">
    <p>
    <xsl:if test="@n!=1">
      [<xsl:value-of select="@n"/>]
    </xsl:if>
    <xsl:apply-templates />
    </p>
  </xsl:template>

  <xsl:template match="tei:div2|tei:div3|tei:div4">
	<hr/><xsl:apply-templates />
</xsl:template>

  <xsl:template match="tei:lemma">
    <b><u>
      <xsl:call-template name="language-filter">
        <xsl:with-param name="lang" select="@lang" />
      </xsl:call-template>
    </u></b>
  </xsl:template>

  <xsl:template match="tei:foreign">
    <xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="tei:orig">
     <xsl:value-of select="@reg" />
  </xsl:template>

  <xsl:template match="tei:pron">
    <xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="tei:itype">
    <xsl:call-template name="language-filter">
      <xsl:with-param name="lang" select="@lang" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="tei:table">
    <p><table border="1">
      <xsl:apply-templates/>
    </table></p><p/>
  </xsl:template>

  <xsl:template match="tei:name[@type='place']|tei:placeName|tei:placename|tei:PlaceName|tei:Placename">
  <xsl:call-template name="render-entity">
      <xsl:with-param name="class" select="'place'" />
  </xsl:call-template>
</xsl:template>

  <xsl:template match="tei:name[@type='ship']">
  <xsl:call-template name="render-entity">
      <xsl:with-param name="class" select="'ship'" />
  </xsl:call-template>
</xsl:template>

  <xsl:template match="tei:persname|tei:persName|tei:PersName|tei:Persname">
  <xsl:call-template name="render-entity">
      <xsl:with-param name="class" select="'person'" />
  </xsl:call-template>
</xsl:template>


<xsl:template name="render-entity">
    <xsl:param name="class" select="'entity'" />

    <xsl:variable name="thisAuthname" select="@authname" />

	<xsl:choose>
	<xsl:when test="@authname != ''">
    	<xsl:element name="span">
		<xsl:attribute name="class">
	    	<xsl:if test="@authname=$highlight_authname">
			<xsl:text>search_result </xsl:text>
	    	</xsl:if>
	    	<xsl:value-of select="$class" />
		</xsl:attribute>
		<xsl:if test="@authname=$highlight_authname">
	   		<xsl:attribute name="id">
			<xsl:text>match</xsl:text><xsl:value-of select="count(preceding::*[@authname=$highlight_authname]) + 1" />
	    	</xsl:attribute>
		</xsl:if>
        	<a target="_blank" onclick="openPopupWindow(this); return false" href="entityvote?doc={$query}&amp;auth={@authname}&amp;n={count(preceding::*[@authname=$thisAuthname]) + 1}&amp;type={$class}"><xsl:apply-templates /></a>
    	</xsl:element>
    </xsl:when>
    <xsl:otherwise>
    	<xsl:apply-templates />
    </xsl:otherwise>
    </xsl:choose>
</xsl:template>

  <xsl:template match="tei:rs|tei:RS|tei:Rs">
  <span class="ref"><xsl:apply-templates /></span>
</xsl:template>

  <xsl:template match="tei:orgname|tei:orgName">
  <xsl:apply-templates/>
  <!-- <xsl:call-template name="render-entity">
      <xsl:with-param name="class" select="'org'" />
  </xsl:call-template> -->
</xsl:template>

  <xsl:template match="tei:row">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="tei:cell">
    <td>
        <xsl:if test="@cols">
	  <xsl:attribute name="colspan"><xsl:value-of select="@cols" /></xsl:attribute>
	</xsl:if>
        <xsl:if test="@rows">
	  <xsl:attribute name="rowspan"><xsl:value-of select="@rows" /></xsl:attribute>
	</xsl:if>
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  
  <xsl:template match="tei:said">
    <!-- this is a hack - it should look up the display name from the element with the referenced id -->
    <!-- it also should group multiple said blocks so as not to repeat the speaker name -->
    <xsl:variable name="previous">
      <xsl:choose>
        <xsl:when test="preceding-sibling::tei:said">
          <xsl:value-of select="(preceding-sibling::tei:said)[1]/@who"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="(parent::*/preceding-sibling::*)[1]/tei:said[last()]/@who"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$previous != @who">
      <div class="speaker">(spoken by <xsl:value-of select="substring-after(@who,'#')"/>)</div>
        <xsl:apply-templates></xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <p>
    
    </p>
  </xsl:template>

	<xsl:template name="language-filter">
		<xsl:param name="lang" />
		<xsl:param name="default" select="''" />
		
		<xsl:choose>
			<xsl:when test="$lang='la'">
				<span class="la"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$lang='lat'">
				<span class="la"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$lang='latin'">
				<span class="la"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$lang='gk'">
				<span class="greek"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$lang='greek'">
				<span class="greek"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$lang='el'">
				<span class="greek"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$lang='it'">
				<span class="it"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$lang='ar'">
				<span class="ar"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$lang='en'">
				<span class="en"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:when test="$default != ''">
				<span class="{$default}"><xsl:apply-templates /></span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates /> 
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- ignore the tei header for now -->
	<xsl:template match="tei:teiHeader"></xsl:template>
	
	<!-- Default: replicate unrecognized markup -->
	<xsl:template match="@*|node()" priority="-1">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
