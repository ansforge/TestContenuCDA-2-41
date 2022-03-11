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
                              title="Vérification de la conformité au modèle SDM-MR_2021.01"
                              schemaVersion="CI-SIS_SDM-MR_2021.01.sch">
         <xsl:attribute name="document">
            <xsl:value-of select="document-uri(/)"/>
         </xsl:attribute>
         <xsl:attribute name="dateHeure">
            <xsl:value-of select="format-dateTime(current-dateTime(), '[D]/[M]/[Y] à [H]:[m]:[s] (temps UTC[Z])')"/>
         </xsl:attribute>
         <xsl:text/>
         <svrl:active-pattern>
            <xsl:attribute name="id">Entete_SDMMR</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_Age_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_AppreciationDiagnosticEntree_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_CasSporadiqueFamilial_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_MalformationAntenatale_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_ModeConfirmationDiagnostic_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_ObjectifActivite_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_PatientAdressePar_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_StatutActuelDiagnostic_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_ContexteActivite_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_TechniquesDiagnostic_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_InvestigationsRealisees_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_ProfessionPersonnelActivite_SDMMR</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">variables</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité au modèle SDM-MR_2021.01</svrl:text>

   <!--PATTERN Entete_SDMMR-->


	<!--RULE -->
<xsl:template match="cda:ClinicalDocument" priority="1000" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="cda:ClinicalDocument"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:recordTarget/cda:patientRole/cda:patient/cda:birthTime"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_SDMMR] La date de naissance du patient est obligatoirement présente 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:documentationOf/cda:serviceEvent/cda:code[@code='P2-00130']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_SDMMR] L'attribut code de l'élément documentationOf/serviceEvent/Code est fixé à 'P2-00130'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:family[@qualifier='BR']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_SDMMR] Le nom de famille du patient (élément family) est obligatoire et son attribut qualifier doit être fixé à 'BR'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>

   <!--PATTERN JDV_Age_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[(cda:code/@code='PAT-013') or (cda:code/@code='PAT-015')]/cda:value"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[(cda:code/@code='PAT-013') or (cda:code/@code='PAT-015')]/cda:value"/>
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
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_Age)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
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
                  <xsl:value-of select="$jdv_Age"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

   <!--PATTERN JDV_AppreciationDiagnosticEntree_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='MED-071']/cda:value"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='MED-071']/cda:value"/>
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
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_AppreciationDiagnosticEntree)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
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
                  <xsl:value-of select="$jdv_AppreciationDiagnosticEntree"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>

   <!--PATTERN JDV_CasSporadiqueFamilial_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='MED-073']/cda:value"
                 priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='MED-073']/cda:value"/>
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
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_CasSporadiqueFamilial)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
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
                  <xsl:value-of select="$jdv_CasSporadiqueFamilial"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>

   <!--PATTERN JDV_MalformationAntenatale_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='MED-078']/cda:value"
                 priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='MED-078']/cda:value"/>
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
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>
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
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_MalformationAntenatale)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_MalformationAntenatale"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>

   <!--PATTERN JDV_ModeConfirmationDiagnostic_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='ORG-017']/cda:value"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='ORG-017']/cda:value"/>
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
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ModeConfirmationDiagnostic)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
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
                  <xsl:value-of select="$jdv_ModeConfirmationDiagnostic"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

   <!--PATTERN JDV_ObjectifActivite_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='ORG-034']/cda:value"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='ORG-034']/cda:value"/>
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
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ObjectifActivite)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
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
                  <xsl:value-of select="$jdv_ObjectifActivite"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>

   <!--PATTERN JDV_PatientAdressePar_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:participant[@typeCode='REFB']/cda:associatedEntity[@classCode='PROV']/cda:code"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:participant[@typeCode='REFB']/cda:associatedEntity[@classCode='PROV']/cda:code"/>
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
                  <xsl:value-of select="ClinicalDocument/participant/associatedEntity/code"/>
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
                  <xsl:value-of select="ClinicalDocument/participant/associatedEntity/code"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_PatientAdressePar)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/participant/associatedEntity/code"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_PatientAdressePar"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>

   <!--PATTERN JDV_StatutActuelDiagnostic_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='MED-072']/cda:value"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='MED-072']/cda:value"/>
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
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_StatutActuelDiagnostic)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
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
                  <xsl:value-of select="$jdv_StatutActuelDiagnostic"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>

   <!--PATTERN JDV_ContexteActivite_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:encounter/cda:entryRelationship/cda:observation[cda:code/@code='ORG-033']/cda:value"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:encounter/cda:entryRelationship/cda:observation[cda:code/@code='ORG-033']/cda:value"/>
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
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/encounter/entryRelationship/observation/value"/>
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
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/encounter/entryRelationship/observation/value"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ContexteActivite)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/encounter/entryRelationship/observation/value"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ContexteActivite"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>

   <!--PATTERN JDV_TechniquesDiagnostic_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='MED-068']/cda:value"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='MED-068']/cda:value"/>
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
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_TechniquesDiagnostic)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
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
                  <xsl:value-of select="$jdv_TechniquesDiagnostic"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>

   <!--PATTERN JDV_InvestigationsRealisees_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='ORG-017']/cda:value"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='ORG-017']/cda:value"/>
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
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_InvestigationsRealisees)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
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
                  <xsl:value-of select="$jdv_InvestigationsRealisees"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>

   <!--PATTERN JDV_ProfessionPersonnelActivite_SDMMR-->


	<!--RULE -->
<xsl:template match="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:encounter/cda:participant[@typeCode='PRF']/cda:participantRole/cda:code"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:encounter/cda:participant[@typeCode='PRF']/cda:participantRole/cda:code"/>
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
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/encounter/participant/participantRole/code"/>
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
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/encounter/participant/participantRole/code"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ProfessionPersonnelActivite)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="ClinicalDocument/component/structuredBody/component/section/entry/encounter/participant/participantRole/code"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$jdv_ProfessionPersonnelActivite"/>
                  <xsl:text/>.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>

   <!--PATTERN variables-->
<xsl:variable name="jdv_Age" select="'../jeuxDeValeurs/JDV_Age-CISIS.xml'"/>
   <xsl:variable name="jdv_AppreciationDiagnosticEntree"
                 select="'../jeuxDeValeurs/JDV_AppreciationDiagnosticCentre-CISIS.xml'"/>
   <xsl:variable name="jdv_CasSporadiqueFamilial"
                 select="'../jeuxDeValeurs/JDV_CasSporadiqueFamilial-CISIS.xml'"/>
   <xsl:variable name="jdv_MalformationAntenatale"
                 select="'../jeuxDeValeurs/JDV_MalformationAntenatale-CISIS.xml'"/>
   <xsl:variable name="jdv_ModeConfirmationDiagnostic"
                 select="'../jeuxDeValeurs/JDV_InvestigationsRealisees-CISIS'"/>
   <xsl:variable name="jdv_ObjectifActivite"
                 select="'../jeuxDeValeurs/JDV_ObjectifActivite-CISIS.xml'"/>
   <xsl:variable name="jdv_StatutActuelDiagnostic"
                 select="'../jeuxDeValeurs/JDV_StatutActuelDiagnostic-CISIS.xml'"/>
   <xsl:variable name="jdv_PatientAdressePar"
                 select="'../jeuxDeValeurs/JDV_PatientAdressePar-CISIS.xml'"/>
   <xsl:variable name="jdv_ContexteActivite"
                 select="'../jeuxDeValeurs/JDV_ContexteActivite-CISIS.xml'"/>
   <xsl:variable name="jdv_TechniquesDiagnostic"
                 select="'../jeuxDeValeurs/JDV_TechniquesDiagnostic-CISIS.xml'"/>
   <xsl:variable name="jdv_InvestigationsRealisees"
                 select="'../jeuxDeValeurs/JDV_InvestigationsRealisees-CISIS.xml'"/>
   <xsl:variable name="jdv_ProfessionPersonnelActivite"
                 select="'../jeuxDeValeurs/JDV_ProfessionPersonnelActivite-CISIS.xml'"/>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument" priority="1000" mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="cda:ClinicalDocument"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.1.30']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [CI-SIS_SDM-MR_2021.01] Le template du modèle SDM-MR (1.2.250.1.213.1.1.1.30) doit être présent.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [CI_SIS_SDM-MR_2021.01] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1" 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.35']) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [CI_SIS_SDM-MR_2021.01] La section Directives anticipées (1.3.6.1.4.1.19376.1.5.3.1.3.35) est obligatoire et unique
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.6']) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [CI_SIS_SDM-MR_2021.01] La section Problèmes actifs (1.3.6.1.4.1.19376.1.5.3.1.3.6) est obligatoire et unique
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
</xsl:stylesheet>