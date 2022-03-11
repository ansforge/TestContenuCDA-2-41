<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:hl7="urn:hl7-org:v3"
                xmlns:cda="urn:hl7-org:v3"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
                xmlns:pharm="urn:ihe:pharm"
                xmlns:sdtc="urn:hl7-org:sdtc"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:svs="urn:ihe:iti:svs:2008"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


<!--PROLOG-->
<xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>

   <!--XSD TYPES FOR XSLT2-->


<!--KEYS AND FUNCTIONS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path-2"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters--><xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
<xsl:template match="/">
      <xsl:processing-instruction xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="xml-stylesheet">type="text/xsl" href="rapportSchematronToHtml4.xsl"</xsl:processing-instruction>
      <xsl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl"/>
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="Verification sémantique"
                              schemaVersion="">
         <xsl:attribute name="document">
            <xsl:value-of select="document-uri(/)"/>
         </xsl:attribute>
         <xsl:attribute name="dateHeure">
            <xsl:value-of select="format-dateTime(current-dateTime(), '[D]/[M]/[Y] à [H]:[m]:[s] (temps UTC[Z])')"/>
         </xsl:attribute>
         <xsl:text/>
         <svrl:active-pattern>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Verification sémantique</svrl:text>

   <!--PATTERN Verification sémantique-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Verification sémantique</svrl:text>
   <xsl:variable name="path_terminologie" select="'../terminologie/'"/>

	  <!--RULE -->
<xsl:template match="//hl7:code" priority="1014" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//hl7:code"/>
      <xsl:variable name="theCode" select="@code"/>
      <xsl:variable name="theNameCode" select="@displayName"/>
      <xsl:variable name="theCodeSystem" select="@codeSystem"/>
      <xsl:variable name="theCodeSystemName" select="@codeSystemName"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not (doc-available(concat($path_terminologie, $theCodeSystem,'.rdf')) and not(exists(doc(concat($path_terminologie, $theCodeSystem,'.rdf') )//skos:notation[text()= string($theCode)])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  CodeSystem : "<xsl:text/>
                  <xsl:value-of select="$theCodeSystem"/>
                  <xsl:text/>" 
			  CodeSystemName : "<xsl:text/>
                  <xsl:value-of select="$theCodeSystemName"/>
                  <xsl:text/>" 
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theCode"/>
                  <xsl:text/>"
			  DisplayName : <xsl:text/>
                  <xsl:value-of select="$theNameCode"/>
                  <xsl:text/>
			  Ce code n'est pas retrouvé dans la terminologie
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:value[@xsi:type='CD' or  @xsi:type='CE']" priority="1013"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:value[@xsi:type='CD' or  @xsi:type='CE']"/>
      <xsl:variable name="theCode" select="@code"/>
      <xsl:variable name="theNameCode" select="@displayName"/>
      <xsl:variable name="theCodeSystem" select="@codeSystem"/>
      <xsl:variable name="theCodeSystemName" select="@codeSystemName"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not (doc-available(concat($path_terminologie, $theCodeSystem,'.rdf')) and not(exists(doc(concat($path_terminologie, $theCodeSystem,'.rdf') )//skos:notation[text()= string($theCode)])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  CodeSystem : "<xsl:text/>
                  <xsl:value-of select="$theCodeSystem"/>
                  <xsl:text/>" 
			  CodeSystemName : "<xsl:text/>
                  <xsl:value-of select="$theCodeSystemName"/>
                  <xsl:text/>" 
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theCode"/>
                  <xsl:text/>"
			  DisplayName : <xsl:text/>
                  <xsl:value-of select="$theNameCode"/>
                  <xsl:text/>
			  Ce code n'est pas retrouvé dans la terminologie
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//svs:Concept" priority="1012" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//svs:Concept"/>
      <xsl:variable name="theCode" select="@code"/>
      <xsl:variable name="theNameCode" select="@displayName"/>
      <xsl:variable name="theCodeSystem" select="@codeSystem"/>
      <xsl:variable name="theCodeSystemName" select="@codeSystemName"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not (doc-available(concat($path_terminologie, $theCodeSystem,'.rdf')) and not(exists(doc(concat($path_terminologie, $theCodeSystem,'.rdf') )//skos:notation[text()= string($theCode)])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  CodeSystem : "<xsl:text/>
                  <xsl:value-of select="$theCodeSystem"/>
                  <xsl:text/>" 
			  CodeSystemName : "<xsl:text/>
                  <xsl:value-of select="$theCodeSystemName"/>
                  <xsl:text/>" 
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theCode"/>
                  <xsl:text/>"
			  DisplayName : <xsl:text/>
                  <xsl:value-of select="$theNameCode"/>
                  <xsl:text/>
			  Ce code n'est pas retrouvé dans la terminologie
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:value[@xsi:type='PQ']" priority="1011" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//hl7:value[@xsi:type='PQ']"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:value[@xsi:type='c:PQ']" priority="1010" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:value[@xsi:type='c:PQ']"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:value[@xsi:type='IVL_PQ']/hl7:low" priority="1009" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:value[@xsi:type='IVL_PQ']/hl7:low"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:value[@xsi:type='c:IVL_PQ']/hl7:low" priority="1008" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:value[@xsi:type='c:IVL_PQ']/hl7:low"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:value[@xsi:type='IVL_PQ']/hl7:high" priority="1007" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:value[@xsi:type='IVL_PQ']/hl7:high"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:value[@xsi:type='c:IVL_PQ']/hl7:high" priority="1006" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:value[@xsi:type='c:IVL_PQ']/hl7:high"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:substanceAdministration//hl7:doseQuantity/hl7:low" priority="1005"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:substanceAdministration//hl7:doseQuantity/hl7:low"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:substanceAdministration//hl7:doseQuantity/hl7:high"
                 priority="1004"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:substanceAdministration//hl7:doseQuantity/hl7:high"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:substanceAdministration//hl7:rateQuantity/hl7:low" priority="1003"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:substanceAdministration//hl7:rateQuantity/hl7:low"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:substanceAdministration//hl7:rateQuantity/hl7:high"
                 priority="1002"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:substanceAdministration//hl7:rateQuantity/hl7:high"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:substanceAdministration//hl7:maxDoseQuanity/hl7:low"
                 priority="1001"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:substanceAdministration//hl7:maxDoseQuanity/hl7:low"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//hl7:substanceAdministration//hl7:maxDoseQuanity/hl7:high"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//hl7:substanceAdministration//hl7:maxDoseQuanity/hl7:high"/>
      <xsl:variable name="theUnit" select="@unit"/>
      <xsl:variable name="theUnitTransform" select="replace(@unit, '\{.[a-z]*.\}', '')"/>

		    <!--ASSERT error-->
<xsl:choose>
         <xsl:when test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
			  Code  : "<xsl:text/>
                  <xsl:value-of select="$theUnit"/>
                  <xsl:text/>" (Avant transformation : "<xsl:text/>
                  <xsl:value-of select="$theUnitTransform"/>
                  <xsl:text/>")
			  Ce code n'est pas dans UCUM
			 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>
</xsl:stylesheet>