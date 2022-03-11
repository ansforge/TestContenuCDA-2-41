<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:cda="urn:hl7-org:v3"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:jdv="http://esante.gouv.fr"
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
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="Rapport de conformité du document aux spécifications du volet ANEST-CR-CPA"
                              schemaVersion="CI-SIS_ANEST-CR-CPA_2021.01">
         <xsl:attribute name="phase">CI-SIS_ANEST-CR-CPA_2021.01</xsl:attribute>
         <xsl:attribute name="document">
            <xsl:value-of select="document-uri(/)"/>
         </xsl:attribute>
         <xsl:attribute name="dateHeure">
            <xsl:value-of select="format-dateTime(current-dateTime(), '[D]/[M]/[Y] à [H]:[m]:[s] (temps UTC[Z])')"/>
         </xsl:attribute>
         <xsl:text/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_AideAuDeplacement-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_FacteursDeRisqueSociaux-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_FacteursDeRisqueProfessionnels-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_GIR-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_NiveauDependance-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_ObservationIntoleranceType-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_ScoreDuke-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_ScoreMallampati-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_Sedentarite-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_Severite-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_SupportNutritionnel-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_SignesVitaux-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_ExamenPhysiqueDetaille-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_AntecedentsChirurgicauxNonCodee-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_AntecedentsFamiliauxNonCodee-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_ProblemesActifs-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_AntecedentsMedicaux-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_HabitusModeDeVie-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_FonctionsPhysiques-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_AllergiesEtIntolerances-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_Traitements-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_AntecedentsTransfusionnelsNonCodee-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_AntecedentsHemorragiquesNonCodee-CISIS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDVvariables</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Rapport de conformité du document aux spécifications du volet ANEST-CR-CPA</svrl:text>

   <!--PATTERN JDV_AideAuDeplacement-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6' and cda:code/cda:qualifier/cda:name/@code='MED-598']/cda:value"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6' and cda:code/cda:qualifier/cda:name/@code='MED-598']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_AideAuDeplacement)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_AideAuDeplacement"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

   <!--PATTERN JDV_FacteursDeRisqueSociaux-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/cda:qualifier/cda:name/@code='GEN-232']/cda:value"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/cda:qualifier/cda:name/@code='GEN-232']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_FacteursDeRisqueSociaux)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_FacteursDeRisqueSociaux"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

   <!--PATTERN JDV_FacteursDeRisqueProfessionnels-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/@code='92944-8']/cda:value"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/@code='92944-8']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_FacteursDeRisqueProfessionnels)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_FacteursDeRisqueProfessionnels"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

   <!--PATTERN JDV_GIR-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6' and cda:code/@code='MED-346']/cda:value"
                 priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6' and cda:code/@code='MED-346']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_GIR)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_GIR"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

   <!--PATTERN JDV_NiveauDependance-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/@code='42831-8']/cda:value"
                 priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/@code='42831-8']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_NiveauDependance)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_NiveauDependance"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

   <!--PATTERN JDV_ObservationIntoleranceType-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.6']/cda:code"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.6']/cda:code"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/code"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/code"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_ObservationIntoleranceType)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/code"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_ObservationIntoleranceType"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>

   <!--PATTERN JDV_ScoreDuke-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and cda:code/cda:qualifier/cda:name/@code='MED-633']/cda:value"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and cda:code/cda:qualifier/cda:name/@code='MED-633']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_ScoreDuke)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_ScoreDuke"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

   <!--PATTERN JDV_ScoreMallampati-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and cda:code/@code='MED-638']/cda:value"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and cda:code/@code='MED-638']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_ScoreMallampati)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_ScoreMallampati"/>
                  <xsl:text/>.
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

   <!--PATTERN JDV_Sedentarite-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/@code='GEN-208']/cda:value"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/@code='GEN-208']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_Sedentarite)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_Sedentarite"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

   <!--PATTERN JDV_Severite-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1' and cda:code/@code='SEV']/cda:value"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1' and cda:code/@code='SEV']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_Severite)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_Severite"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

   <!--PATTERN JDV_SupportNutritionnel-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and cda:code/cda:qualifier/cda:name/@code='MED-599']/cda:value"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and cda:code/cda:qualifier/cda:name/@code='MED-599']/cda:value"/>
      <xsl:variable name="att_code" select="@code"/>
      <xsl:variable name="att_codeSystem" select="@codeSystem"/>
      <xsl:variable name="att_displayName" select="@displayName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@nullFlavor) or 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" ne doit pas comporter d'attribut nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             (@code and @codeSystem) or             (0 and              (@nullFlavor='UNK' or              @nullFlavor='NA' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [dansJeuDeValeurs] L'élément "<xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANEST-CR-CPA_SupportNutritionnel)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ANEST-CR-CPA_SupportNutritionnel"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

   <!--PATTERN S_SignesVitaux-CISISCI-SIS ANEST-CR-CPA Section Signes vitaux -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Signes vitaux </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2&#34;]"
                 priority="1001"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()=&#34;Signes vitaux (Données biométriques)&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_SignesVitaux-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir le title 'Signes vitaux (Données biométriques)'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.1&#34;]"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34; and cda:code/@code=&#34;8302-2&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='8302-2'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34; and cda:code/@code=&#34;29463-7&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='29463-7'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34; and cda:code/@code=&#34;39156-5&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='39156-5'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34; and cda:code/@code=&#34;8480-6&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='8480-6'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34; and cda:code/@code=&#34;8462-4&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='8462-4'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34; and cda:code/@code=&#34;8867-4&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='8867-4'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34; and cda:code/@code=&#34;2708-6&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='2708-6'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

   <!--PATTERN S_ExamenPhysiqueDetaille-CISISCI-SIS ANEST-CR-CPA Examen physique détaillé-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Examen physique détaillé</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.15&#34;]"
                 priority="1002"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.15&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.30&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ExamenPhysiqueDetaille-CISIS.sch] Erreur de Conformité au volet ANEST-CR-CPA: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section'Système respiratoire'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.33&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ExamenPhysiqueDetaille-CISIS.sch] Erreur de Conformité au volet ANEST-CR-CPA: La section 'FR-Examen-physique-detaille-code' doit obligatoirement contenir [1..1] sous-section 'Vaisseaux'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.33&#34;]"
                 priority="1001"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.33&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34; and cda:code/@code=&#34;MED-593&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ExamenPhysiqueDetaille-CISIS.sch] Erreur de Conformité au volet ANEST-CR-CPA: La sous-section Vaisseaux(1.3.6.1.4.1.19376.1.5.3.1.1.9.33) doit obligatoirement contenir
            [1..1] entrée FR-Simple-Observation(1.2.250.1.213.1.1.3.48) avec un élément code dont l'attribut @code='MED-593'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.30&#34;]"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.30&#34;]"/>
      <xsl:variable name="scoreMallampati"
                    select=".//cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code='MED-638'"/>
      <xsl:variable name="ouvertureBouche"
                    select=".//cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code='MED-639'"/>
      <xsl:variable name="distanceThyromentonnière"
                    select=".//cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code='MED-640'"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]) or             (.//cda:observation[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;] and             ($scoreMallampati or $ouvertureBouche or $distanceThyromentonnière))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ExamenPhysiqueDetaille-CISIS.sch] Erreur de Conformité au volet ANEST-CR-CPA: La sous-section Système respiratoire(1.3.6.1.4.1.19376.1.5.3.1.1.9.30) peut contenir
            [0..3] entrée(s) FR-Simple-Observation(1.2.250.1.213.1.1.3.48) avec un élément code dont l'attribut @code='MED-638' ou @code='MED-639' ou  @code='MED-640'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

   <!--PATTERN S_AntecedentsChirurgicauxNonCodee-CISISCI-SIS ANEST-CR-CPA Section Antecedents chirurgicaux non codée -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Antecedents chirurgicaux non codée </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.11&#34;]"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.11&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()='Antécédents chirurgicaux'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AntecedentsChirurgicauxNonCodee-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Antecedents-chirurgicaux-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.11)
            doit obligatoirement contenir le title 'Antécédents chirurgicaux'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

   <!--PATTERN S_AntecedentsFamiliauxNonCodee-CISISCI-SIS ANEST-CR-CPA Section Antecedents familiaux non codée -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Antecedents familiaux non codée </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.14&#34;]"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.14&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()='Antécédents familiaux'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AntecedentsFamiliauxNonCodee-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Antecedents-familiaux-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.14)
            doit obligatoirement contenir le title 'Antécédents familiaux'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

   <!--PATTERN S_ProblemesActifs-CISISCI-SIS ANEST-CR-CPA Section Problèmes actifs -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Problèmes actifs </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.6&#34;]" priority="1002"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.6&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()=&#34;Liste des problèmes actifs (Pathologies chroniques)&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe,
            une section FR-Problemes-actifs (1.3.6.1.4.1.19376.1.5.3.1.3.6) doit obligatoirement contenir le title 'Liste des problèmes actifs (Pathologies chroniques)'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:code/@code=&#34;11450-4&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe,
            une section FR-Problemes-actifs (1.3.6.1.4.1.19376.1.5.3.1.3.6) doit obligatoirement contenir un élément code dont l'attribut @code='11450-4'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entry[cda:act/cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Problemes-actifs doit obligatoirement contenir [0..1] entrée FR-Liste-des-problemes(1.3.6.1.4.1.19376.1.5.3.1.4.5.2).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.6&#34;]/cda:entry/cda:act[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"
                 priority="1001"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.6&#34;]/cda:entry/cda:act[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entryRelationship[cda:observation/cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]) &gt;= 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Liste-des-problemes(1.3.6.1.4.1.19376.1.5.3.1.4.5.2) doit obligatoirement contenir [0..*] entryRelationship FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]" priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:entryRelationship[cda:act/cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.2&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Probleme doit obligatoirement contenir [0..1] entryRelationship FR-Commentaire-ER '1.3.6.1.4.1.19376.1.5.3.1.4.2'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>

   <!--PATTERN S_AntecedentsMedicaux-CISISCI-SIS ANEST-CR-CPA Section Antécédents médicaux -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Antécédents médicaux </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.8&#34;]" priority="1001"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.8&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()=&#34;Antécédents médicaux&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AntecedentsMedicaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe,
            une section FR-Antecedents-medicaux (1.3.6.1.4.1.19376.1.5.3.1.3.6) doit obligatoirement contenir le title 'Antécédents médicaux'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entry[cda:act/cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AntecedentsMedicaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Antecedents-medicaux doit obligatoirement contenir [0..1] entrée FR-Liste-des-problemes(1.3.6.1.4.1.19376.1.5.3.1.4.5.2).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.8&#34;]/cda:entry/cda:act[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.8&#34;]/cda:entry/cda:act[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entryRelationship[cda:observation/cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]) &gt;= 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AntecedentsMedicaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Liste-des-problemes(1.3.6.1.4.1.19376.1.5.3.1.4.5.2) doit obligatoirement contenir [0..*] entryRelationship FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:entryRelationship[cda:observation/cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]/cda:observation/count(cda:entryRelationship[cda:act/cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.2&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AntecedentsMedicaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Probleme doit obligatoirement contenir [0..1] entryRelationship FR-Commentaire-ER '1.3.6.1.4.1.19376.1.5.3.1.4.2'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

   <!--PATTERN S_HabitusModeDeVie-CISISCI-SIS ANEST-CR-CPA Section Habitus mode de vie -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Habitus mode de vie </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.16.1&#34;]"
                 priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.16.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()=&#34;Facteurs de risques, Habitus, Mode de vie&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Habitus-mode-de-vie (1.3.6.1.4.1.19376.1.5.3.1.3.16.1) doit obligatoirement contenir le title 'Facteurs de risques, Habitus, Mode de vie'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entry/cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;])&gt;= 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Habitus-mode-de-vie (1.3.6.1.4.1.19376.1.5.3.1.3.16.1) doit obligatoirement contenir [0..11] entrées FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;11345-6&#34;]/cda:qualifier/cda:name[@code=&#34;GEN-232&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-232'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;92944-8&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='92944-8'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;11345-6&#34;]/cda:qualifier/cda:name[@code=&#34;GEN-207&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-207'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;11345-6&#34;]/cda:qualifier/cda:name[@code=&#34;ORG-075&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='ORG-075'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;73985-4&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='73985-4'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;11345-6&#34;]/cda:qualifier/cda:name[@code=&#34;GEN-208&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-208'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;74011-8&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='74011-8'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;74013-4&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='74013-4'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;42831-8&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='42831-8'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;11345-6&#34;]/cda:qualifier/cda:name[@code=&#34;GEN-050&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-050'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]/cda:code[@code=&#34;11345-6&#34;]/cda:qualifier/cda:name[@code=&#34;GEN-231&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-231'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>

   <!--PATTERN S_FonctionsPhysiques-CISISCI-SIS ANEST-CR-CPA Section Fonctions physiques-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Fonctions physiques</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5&#34;]"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()=&#34;Problèmes physiques fonctionnels et structurels (Autonomie)&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Fonctions-physiques (1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5) doit obligatoirement contenir le title 'Problèmes physiques fonctionnels et structurels (Autonomie)'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entry/cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;])&gt;= 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Fonctions-physiques(1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5) doit obligatoirement contenir [0..9] entrées FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;95034-5&#34;])&lt;= 1 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='95034-5'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;95023-8&#34;]/cda:qualifier/cda:name[@code=&#34;MED-596&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='95023-8' et en dessous élément qualifier/name dont l'attribut @code='MED-596'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;95023-8&#34;]/cda:qualifier/cda:name[@code=&#34;MED-597&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='95023-8' et en dessous élément qualifier/name dont l'attribut @code='MED-597'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;95023-8&#34;]/cda:qualifier/cda:name[@code=&#34;MED-598&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='95023-8' et en dessous élément qualifier/name dont l'attribut @code='MED-598'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;10210-3&#34;]/cda:qualifier/cda:name[@code=&#34;MED-346&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='10210-3'et en dessous élément qualifier/name dont l'attribut @code='MED-346'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;10210-3&#34;]/cda:qualifier/cda:name[@code=&#34;MED-633&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='10210-3' et en dessous élément qualifier/name dont l'attribut @code='MED-633'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;75305-3&#34;]/cda:qualifier/cda:name[@code=&#34;MED-599&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='75305-3' et en dessous élément qualifier/name dont l'attribut @code='MED-599'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;75305-3&#34;]/cda:qualifier/cda:name[@code=&#34;MED-650&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='75305-3' et en dessous élément qualifier/name dont l'attribut @code='MED-650'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6&#34;]/cda:code[@code=&#34;75305-3&#34;]/cda:qualifier/cda:name[@code=&#34;MED-651&#34;])&lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='75305-3' et en dessous élément qualifier/name dont l'attribut @code='MED-651'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

   <!--PATTERN S_AllergiesEtIntolerances-CISISCI-SIS ANEST-CR-CPA Section Allergies et intolérances-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Allergies et intolérances</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.13&#34;]"
                 priority="1003"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.13&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()=&#34;Allergies, effets indésirables, alertes&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AllergiesEtIntolerances-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Allergies-et-intolerances (1.3.6.1.4.1.19376.1.5.3.1.3.13) doit obligatoirement
            contenir le title 'Allergies, effets indésirables, alertes'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entry[cda:act/cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.3&#34;]) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Allergies-et-intolerances (1.3.6.1.4.1.19376.1.5.3.1.3.13)
            doit obligatoirement contenir [1..*] entrée FR-Liste-des-allergies-et-intolerances(1.3.6.1.4.1.19376.1.5.3.1.4.5.3).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.3&#34;]"
                 priority="1002"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.3&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entryRelationShip/cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;])&gt;= 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une entrée FR-Liste-des-allergies-et-intolerances(1.3.6.1.4.1.19376.1.5.3.1.4.5.3) peut contenir [0..*] entrées Allergie ou intolérance "1.3.6.1.4.1.19376.1.5.3.1.4.6".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]" priority="1001"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:participant) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) peut contenir [0..1] Agent responsable de l’allergie.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]) &gt;= 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) peut contenir [0..*] entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1&#34;]) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) peut contenir [0..1] entrée FR-Severite(1.3.6.1.4.1.19376.1.5.3.1.4.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.2&#34;]) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) peut contenir [0..1] entrée FR-Commentaire-ER(1.3.6.1.4.1.19376.1.5.3.1.4.2).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]/cda:participant"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]/cda:participant"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:code) = 1 or .//cda:code/@nullFlavor=&#34;UNK&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) doit obligatoirement contenir [1..1] code de l'agent responsable de l’allergie ou bien si l’agent responsable n’est pas trouvé dans les terminologies spécifiées, le code est mis à nullFlavor="UNK".
    </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

   <!--PATTERN S_Traitements-CISISCI-SIS ANEST-CR-CPA Section Traitements administrés -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Traitements administrés </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.19&#34;]"
                 priority="1001"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.19&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(../cda:section) or ( ../cda:section and count(./cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.19&#34;)=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Traitements-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) doit obligatoirement contenir un seul templateId '1.3.6.1.4.1.19376.1.5.3.1.3.19'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()=&#34;Traitements&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Traitements-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) doit obligatoirement contenir le title 'Traitements'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]" priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:code[@code=&#34;DRUG&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Traitements-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) contient[0..*] entrées de type FR-Traitement (1.3.6.1.4.1.19376.1.5.3.1.4.7)  avec un élément code dont l'attribut @code='DRUG'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>

   <!--PATTERN S_AntecedentsTransfusionnelsNonCodee-CISISCI-SIS ANEST-CR-CPA Section Antecedents transfusionnels non codée -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Antecedents transfusionnels non codée </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.12&#34;]"
                 priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.12&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()='Antécédents transfusionnels'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AntecedentsTransfusionnelsNonCodee-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Histoire-transfusionnelle-non-code (1.3.6.1.4.1.19376.1.5.3.1.1.9.12)
            doit obligatoirement contenir le title 'Antécédents transfusionnels'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>

   <!--PATTERN S_AntecedentsHemorragiquesNonCodee-CISISCI-SIS ANEST-CR-CPA Section Antecedents hémorragiques non codée -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS ANEST-CR-CPA Section Antecedents hémorragiques non codée </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.2&#34;]" priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:title/text()='Antécédents hémorragiques'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_AntecedentsHemorragiquesNonCodee-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Antecedents-medicaux-non-code (1.2.250.1.213.1.1.2.2)
            doit obligatoirement contenir le title 'Antécédents hémorragiques'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>

   <!--PATTERN JDVvariables-->
<xsl:variable name="jdv_ANEST-CR-CPA_AideAuDeplacement"
                 select="'../jeuxDeValeurs/JDV_AideAuDeplacement-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_FacteursDeRisqueSociaux"
                 select="'../jeuxDeValeurs/JDV_FacteursDeRisqueSociaux-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_FacteursDeRisqueProfessionnels"
                 select="'../jeuxDeValeurs/JDV_FacteursDeRisqueProfessionnels-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_GIR" select="'../jeuxDeValeurs/JDV_GIR-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_NiveauDependance"
                 select="'../jeuxDeValeurs/JDV_NiveauDependance-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_ObservationIntoleranceType"
                 select="'../jeuxDeValeurs/JDV_ObservationIntoleranceType-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_ScoreDuke"
                 select="'../jeuxDeValeurs/JDV_ScoreDuke-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_ScoreMallampati"
                 select="'../jeuxDeValeurs/JDV_ScoreMallampati-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_Sedentarite"
                 select="'../jeuxDeValeurs/JDV_Sedentarite-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_Severite"
                 select="'../jeuxDeValeurs/JDV_HL7_SeverityObservation-CISIS.xml'"/>
   <xsl:variable name="jdv_ANEST-CR-CPA_SupportNutritionnel"
                 select="'../jeuxDeValeurs/JDV_SupportNutritionnel-CISIS.xml'"/>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument" priority="1001" mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="cda:ClinicalDocument"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.1.41']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [CI-SIS_ANEST-CR-CPA] Le templateId "1.2.250.1.213.1.1.1.41" (Conformité au modèle ANEST-CR-CPA du CI-SIS) doit être présent.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:code[@code='34749-2' and @codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [CI-SIS_ANEST-CR-CPA] L'élément "code" de ANEST-CR-CPA doit avoir les attributs @code ="34749-2" et @codeSystem = "2.16.840.1.113883.6.1". 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(./cda:documentationOf/cda:serviceEvent/cda:code[@code='CS' and @codeSystem='1.2.250.1.215.200.3.3']) or (./cda:documentationOf/cda:serviceEvent/cda:code[@code='APC' and @codeSystem='1.2.250.1.215.200.3.3']) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [CI-SIS_ANEST-CR-CPA] L'élément "code" de l'acte principal doit avoir les attributs @code ="CS" ou "APC" et @codeSystem = "1.2.250.1.215.200.3.3". 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument/cda:component/cda:structuredBody" priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:ClinicalDocument/cda:component/cda:structuredBody"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2'])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [CI-SIS_ANEST-CR-CPA] Erreur de conformité au modèle ANEST-CR-CPA : La section "FR-Signes-vitaux" (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2)  doit être présente.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>
</xsl:stylesheet>