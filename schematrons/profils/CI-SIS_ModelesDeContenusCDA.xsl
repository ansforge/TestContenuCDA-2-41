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
                xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
                xmlns:pharm="urn:ihe:pharm"
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
                              title="Rapport de conformité du document aux spécifications françaises (corps – sections, entrées, jeux de valeurs IHE)"
                              schemaVersion="CI-SIS_ModelesDeContenusCDA.sch">
         <xsl:attribute name="phase">CI-SIS_ModelesDeContenusCDA</xsl:attribute>
         <xsl:attribute name="document">
            <xsl:value-of select="document-uri(/)"/>
         </xsl:attribute>
         <xsl:attribute name="dateHeure">
            <xsl:value-of select="format-dateTime(current-dateTime(), '[D]/[M]/[Y] à [H]:[m]:[s] (temps UTC[Z])')"/>
         </xsl:attribute>
         <xsl:text/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_allergiesAndIntoleranceConcern_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_allergiesAndIntolerances_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_autorisationSubstitution_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_birthEventOrganizer_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_bloodTypeObservation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_concernEntry_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_encounter_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_familyHistoryObservation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_immunizations_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_instructionsPatient_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_instructionsDispensateur_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_itemPlanTraitement_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_medications_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_patientTransfer_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_periodeRenouvellement_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_pregnancyHistoryOrganizer_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_pregnancyObservation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_problemConcernEntry_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_problemEntry_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_problemStatusObservation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_procedureEntry_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_produitDeSantePrescrit_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_quantiteProduit_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_referenceItemPlanTraitement_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_severity_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_simpleObservation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_socialHistoryObservation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_supplyEntry_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_surveyObservation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_traitementPrescrit_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_traitementPrescritSubordonnee_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_transport_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_vitalSignsObservation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_vitalSignsOrganizer_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_disposition_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_statutDuDocument_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_evenementIndesirablePendantHospitalisation_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M43"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_evenementIndesirableSuiteAdministrationDerivesSang_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M44"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_identificationMicroOrganismesMultiresistants_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_accidentsTransfusionnels_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M46"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_payers_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M47"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_instructionAuPatient_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Rapport de conformité du document aux spécifications françaises (corps – sections, entrées, jeux de valeurs IHE)</svrl:text>

   <!--PATTERN E_allergiesAndIntoleranceConcern_frCI-SIS Allergies and Intolerance Concern-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Allergies and Intolerance Concern</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.3']"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.3']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:act[@classCode='ACT' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: Les attributs classCode et moodCode prennent respectivement les valeurs 'ACT' et 'EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: Un élément "Allergies and Intolerance Concern" comporte un seul identifiant "id"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@nullFlavor='NA']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: L’élément code prend la valeur nullFlavor='NA' car l'identification du problème est faite à partir des éléments entryRelationship.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: Un élément "Allergies and Intolerance Concern" comporte un seul code
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = &#34;completed&#34; or             @code = &#34;active&#34; or             @code = &#34;aborted&#34; or             @code = &#34;suspended&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: L'élément "statusCode" sera présent.
            Il prendra la valeur "completed" pour les problèmes résolus, ou "active" pour les problèmes 
            toujours en cours dinvestigation, "aborted" pour les problèmes ayant été stoppées avant la fin 
            et "suspended" pour ceux qui ont été mis en suspens.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--REPORT -->
<xsl:if test="cda:effectiveTime/cda:width or cda:effectiveTime/cda:center">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:effectiveTime/cda:width or cda:effectiveTime/cda:center">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text> 
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: Bien que CDA permette de nombreuses modalités pour exprimer un intervalle de 
            temps (low/high, low/width, high/width, ou center/width), allergiesAndIntoleranceConcern sera contraint à l'utilisation
            exclusive de la forme low/high.</svrl:text>
         </svrl:successful-report>
      </xsl:if>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime/cda:low[@value or @nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS : La composante "low" de l'élément "effectiveTime" doit être exprimée dans 
            un élément "Allergies And Intolerance Concern".
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

   <!--PATTERN E_allergiesAndIntolerances_frCI-SIS Allergies and Intolerances-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Allergies and Intolerances</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]" priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_AllergiesAndIntolerances_fr] : Erreur de conformité CI-SIS : Un élément "Allergies and Intolerance" comporte obligatoirement un identifiant "id".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='2.16.840.1.113883.10.20.1.18'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_AllergiesAndIntolerances_fr] : Erreur de conformité CI-SIS : L'élément de templatId de conformité CCD '2.16.840.1.113883.10.20.1.18' doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem=&#34;2.16.840.1.113883.5.4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_AllergiesAndIntolerances_fr] Erreur de Conformité CI-SIS:
            L'élément 'codeSystem' doit obligatoirement être issu de l'ObservationIntoleranceType (2.16.840.1.113883.5.4).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--REPORT -->
<xsl:if test="cda:effectiveTime/cda:width or cda:effectiveTime/cda:center">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:effectiveTime/cda:width or cda:effectiveTime/cda:center">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text> 
            [E_allergiesAndIntolerances_fr] Erreur de conformité CI-SIS: Bien que CDA permette de nombreuses modalités pour exprimer un intervalle de 
            temps (low/high, low/width, high/width, ou center/width), allergiesAndIntolerances sera contraint à l'utilisation
            exclusive de la forme low/high.</svrl:text>
         </svrl:successful-report>
      </xsl:if>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime/cda:low[@value or @nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_allergiesAndIntolerances_fr] Erreur de conformité CI-SIS : La composante "low" de l'élément "effectiveTime" doit être exprimée dans 
            un élément "Allergies And Intolerances".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = &#34;completed&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntolerances_fr] Erreur de conformité CI-SIS: L'élément "statusCode" sera présent et prendra la valeur "completed"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value/cda:originalText"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntolerances_fr] Erreur de conformité CI-SIS: L'élément "value" doit contenir un élément originalText</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:participant) or (cda:participant/cda:participantRole/cda:playingEntity/cda:code/cda:originalText/cda:reference)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntolerances_fr] Erreur de Conformité CI-SIS: Si l'élément participant est présent, le code de la playingEntity dans
            le paticipantRole devra être présent avec un originalText et une référence qui renvoit vers la partie narrative
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship/*/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1'])&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntolerances_fr] Erreur de Conformité CI-SIS: une seule entryRelationship avec un templateId (1.3.6.1.4.1.19376.1.5.3.1.4.1) au maximum est autorisée, elle décrit la sévérité de l'allergie/intolérance
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship/*/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1'])&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntolerances_fr] Erreur de Conformité CI-SIS: une seule entryRelationship avec un templateId (1.3.6.1.4.1.19376.1.5.3.1.4.1.1) au maximum est autorisée, elle décrit le statut du problème
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

   <!--PATTERN E_autorisationSubstitution_frCI-SIS Entrée "FR-Autorisation-substitution"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Autorisation-substitution"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']" priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.3.87']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_autorisationSubstitution_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Autorisation-substitution" doit avoir un 'templateId' avec l'attribut @root="1.2.250.1.213.1.1.3.87"
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:code[@code='N'][@codeSystem='2.16.840.1.113883.5.1070'])=1) or                            (count(cda:code[@code='G'][@codeSystem='2.16.840.1.113883.5.1070'])=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_autorisationSubstitution_fr.sch] Erreur de conformité CI-SIS : 
                Dans l'entrée "FR-Autorisation-substitution", la valeur de l'attribut du code[@code] doit être obligatoirement 'N' ou 'G' et doit être issu du jeu de valeur JDV_HL7_ActSubstanceAdminSubstitutionCode-CISIS (2.16.840.1.113883.5.1070)
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

   <!--PATTERN E_birthEventOrganizer_fr-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2&#34;]"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_fr] Erreur de conformité CI-SIS : Dans l'élément "Birth Event Organizer", un seul élément "id" doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem='1.2.250.1.213.2.12']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_fr] Erreur de conformité CI-SIS : Dans l'élément "Birth Event Organizer", le code doit être codé en SNOMED 3.5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_birthEventOrganizer_fr] Erreur de conformité CI-SIS : L'élément statusCode d'un "Birth Event Organizer" sera donc toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:subject)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_fr] : Un organizer "Birth Event Organizer" ne doit contenir qu'un seul élément "subject" pour décrire le nouveau né
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:subject/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.15.2'])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_fr] : Le templateId du sujet doit être '1.3.6.1.4.1.19376.1.5.3.1.4.15.2' et ne peut être présent qu'une seule fois
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject/cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_fr] : L'élément relatedSubject du sujet doit obligatoirement contenir un code
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject/cda:subject)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_fr] : L'élément relatedSubject du sujet doit obligatoirement contenir un élément 'subject' qui groupera les caractéristiques du nouveau né
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject/cda:subject/cda:administrativeGenderCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_fr] : Le sexe du nouveau né doit obligatoirement être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject/cda:subject/cda:birthTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_fr] : La date de naissance du nouveau né doit obligatoirement être présente
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

   <!--PATTERN E_bloodTypeObservation_frIHE PCC v3.0 vital signs Organizer-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 vital signs Organizer</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.6']"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.6']"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>
      <xsl:variable name="count_value" select="count(cda:value)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un seul élément id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@displayName='ABO+RH' and @codeSystemName='LOINC']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un élément code avec les attributs @displayName ='ABO+RH' et @codeSystemName='LOINC'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un élément text, lui même contenant un élément référence
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un élément statusCode fixé à la valeur @code='completed'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_value=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un seul élément value (cardinalité [1..1])
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

   <!--PATTERN E_concernEntry_frCI-SIS Concern Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Concern Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.1&#34;]"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:author) or (cda:author/cda:assignedAuthor/cda:id and cda:author/cda:assignedAuthor/cda:addr and cda:author/cda:assignedAuthor/cda:telecom and cda:author/cda:assignedAuthor/cda:assignedPerson/cda:name and cda:author/cda:assignedAuthor/cda:representedOrganization/cda:name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_fr] Erreur de conformité CI-SIS : si l'élément author est présent, il doit contenir l'élément assignedAuthor qui devra contenir les éléments: id, addr, telecom, assignedPerson (name) et representedOrganization (name)
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

   <!--PATTERN E_encounter_frIHE PCC v3.0 Encounter - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Encounter - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.14']"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.14']"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_encounter_fr.sch] Erreur de conformité CI-SIS : L'élément 'encounter' doit contenir un élément id (cardinalité [1..1])
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

   <!--PATTERN E_familyHistoryObservation_frCI-SIS Family History Observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Family History Observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.3&#34;]"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.3&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_fr] Erreur de conformité CI-SIS : Dans l'élément "Family History Observation", 
            les attributs de l'élément CDA 'observation' sont classCode='OBS' et moodCode='EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_fr] : Erreur de conformité CI-SIS : L'élément id est obligatoirement présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_fr] : Erreur de conformité CI-SIS : L'élément code doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_familyHistoryObservation_fr] : Erreur de conformité CI-SIS : Le composant "statutCode" d'une "Family History Observation"
            est toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_fr] : Erreur de conformité CI-SIS : L'élément effectiveTime doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:interpretationCode)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_fr] : L'élément interpretationCode ne doit pas être présent plus d'une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:methodCode)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_fr] : L'élément methodCode ne doit pas être présent plus d'une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:targetSiteCode)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_fr] : L'élément targetSiteCode ne doit pas être présent plus d'une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:author)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_fr] : L'élément author ne doit pas être présent plus d'une fois.
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

   <!--PATTERN E_immunizations_frCI-SIS Entrée Vaccination-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée Vaccination</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.12']"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.12']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de Conformité CI-SIS : 
            Une entrée 'Immunization' ne peut avoir qu'un seul identifiant (id).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de Conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément statusCode.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:text/cda:reference[@value])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de Conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément 'text' avec une 'reference'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de Conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément 'effectiveTime'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:originalText/cda:reference)=1 or cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/@nullFlavor"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément 'consumable' pour décrire le produit (manufacturedProduct) avec une entrée de type Product Entry.
            Cette entrée 'Product Entry' doit comporter un élément 'code' et une description narrative via une référence à l'élément narratif de la section (originalText/reference).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship) or              cda:entryRelationship[@typeCode='CAUS']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.28'] or              cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.2'] or             cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.46'] or              cda:entryRelationship[@typeCode='REFR']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de conformité CI-SIS : 
            Dans une entrée 'Immunization', les éléments 'entryRelationship' ne sont pas obligatoires.
            S'ils sont présents, ils doivent respecter les exigences suivantes :
            - Réaction observée ('entryRelationship' avec typeCode='CAUS') : doit comporter une entrée de type 'observation' avec un OID="2.16.840.1.113883.10.20.1.28".
            - Commentaire ('entryRelationship' avec typeCode='SUBJ') : doit comporter une entrée de type 'act' avec un OID="1.3.6.1.4.1.19376.1.5.3.1.4.2".
            - Rang de la vaccination ('entryRelationship' avec typeCode='SUBJ') : doit comporter une entrée de type 'observation' avec un OID="2.16.840.1.113883.10.20.1.46".
            - Lien avec la prescription ('entryRelationship' avec typeCode 'REFR') : doit comporter une entrée de type 'supply' avec un OID="1.3.6.1.4.1.19376.1.5.3.1.4.7.3".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship[@typeCode='REFR']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3'])&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de conformité CI-SIS : 
            Dans une entrée 'Immunization', il ne peut y avoir qu'un seul élément 'entryRelationship' (typeCode 'REFR') décrivant le lien avec la prescription (entrée de type 'supply' avec un OID="1.3.6.1.4.1.19376.1.5.3.1.4.7.3").
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='2.16.840.1.113883.10.20.1.46'])&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de conformité CI-SIS :
            Dans une entrée 'Immunization', il ne peut y avoir qu'un seul élément 'entryRelationship' (typeCode 'SUBJ') décrivant le rang de la vaccination (entrée de type 'observation' avec un OID="2.16.840.1.113883.10.20.1.46").
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.2'])&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de conformité CI-SIS : L'élément entryRelationship représentant le commentaire ne peut être présent qu'une fois
            Dans une entrée 'Immunization', il ne peut y avoir qu'un seul élément 'entryRelationship' (typeCode 'SUBJ') portant un commentaire (entrée de type 'act' avec un OID="1.3.6.1.4.1.19376.1.5.3.1.4.2").            
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.46']) or (cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.46']             and cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.46']/cda:code/@code='30973-2')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_fr] Erreur de conformité CI-SIS :
            Dans une entrée 'Immunization', l'entryRelationship (typeCode 'SUBJ') décrivant le rang de la vaccination (entrée de type 'observation' avec un OID="2.16.840.1.113883.10.20.1.46") doit obligatoirement avoir le code @code='30973-2'.
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

   <!--PATTERN E_instructionsPatient_frCI-SIS entrée "FR-Instructions-au-patient"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS entrée "FR-Instructions-au-patient"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']" priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']"/>
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>

   <!--PATTERN E_instructionsDispensateur_frCI-SIS Entrée "FR-Instructions-au-dispensateur"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Instructions-au-dispensateur"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']"/>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>

   <!--PATTERN E_itemPlanTraitement_frCI-SIS Entrée "FR-Item-plan-traitement"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Item-plan-traitement"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.7']" priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.7']"/>
      <xsl:variable name="count_templateId"
                    select="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[@typeCode='REFR']/cda:substanceAdministration[@classCode='SBADM'][@moodCode='INT']/cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.3.96']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_itemPlanTraitement_fr.sch] Erreur de conformité CI-SIS : 
                Le quatrième templateId doit avoir un @root="" (Conformité aux spécifications CI-SIS)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId=5"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_itemPlanTraitement_fr.sch] Erreur de conformité CI-SIS : 
                Il doit y avoir 5 occurences de l'élément 'templateId' dans cette entrée(cardinalité [5..5]) :
                - La première pour la déclaration de conformité de l'entrée aux spécifications IHE Pharm suppl. MTP @root="1.3.6.1.4.1.19376.1.9.1.3.2"
                - La deuxième pour la déclaration de conformité de l'entrée aux spécifications CCD @root="2.16.840.1.113883.10.20.1.24"
                - La troisème pour la déclaration de conformité de l'entrée aux spécifications IHE PCC @root="1.3.6.1.4.1.19376.1.5.3.1.4.7"
                - La quatrième pour la déclaration de conformité de l'entrée aux spécifications CI-SIS @root="1.2.250.1.213.1.1.3.96"
                - La cinquième pour la déclaration du mode d'administration du traitement prescrit (à choisir parmi la liste des modes d'administration)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>

   <!--PATTERN E_medications_frCI-SIS Medications-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Medications</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]" priority="1008"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : L'entrée de type "substanceAdministration" doit contenir au minimum trois éléments "templateId".            
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:doseQuantity/cda:low)=1 and count(cda:doseQuantity/cda:high)=1) or cda:doseQuantity/@nullFlavor or not(cda:doseQuantity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "doseQuantity" (dose à administrer) n'est pas obligatoire mais s'il est présent, ces éléments "low" et "high" sont obligatoires et ne doivent être présents qu'une seule fois (cardinalité [1..1]).
            L'élément "doseQuantity" peut aussi prendre la valeur nullFlavor.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:rateQuantity) or cda:rateQuantity/@nullFlavor or (count(cda:rateQuantity/cda:low)=1 and count(cda:rateQuantity/cda:high)=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "rateQuantity" (rythme d'administration) n'est pas obligatoire mais s'il est présent, ces éléments "low" et "high" sont obligatoires et ne doivent être présents qu'une seule fois (cardinalité [1..1]).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:maxDoseQuantity)&lt;2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "maxDoseQuantity" (dose maximale) ne peut être présent plus d'une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:consumable/cda:manufacturedProduct/cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "consumable" doit obligatoirement être présent dans une entrée de type "substanceAdministration".
            Il comportera un élément "manufacturedProduct" de type "Produit de santé" (1.3.6.1.4.1.19376.1.5.3.1.4.7.2).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:consumable/cda:manufacturedProduct/cda:templateId)&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "manufacturedProduct" contient au minimum deux éléments "templateId" : "1.3.6.1.4.1.19376.1.5.3.1.4.7.2" et "2.16.840.1.113883.10.20.1.53".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:originalText/cda:reference)=1 or cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/@nullFlavor"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : L'entréede type "Produit de santé" (1.3.6.1.4.1.19376.1.5.3.1.4.7.2) doit contenir un médicament administré (manufacturedMaterial) avec sa codification CIS-Spécialité
            et une description narrative via une référence à l'élément narratif de la section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship)                     or cda:entryRelationship[@typeCode='RSON']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1']             or cda:entryRelationship[@typeCode='REFR']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']             or cda:entryRelationship[@typeCode='COMP']/cda:substanceAdministration             or cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']             or cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']             or cda:entryRelationship[@typeCode='COMP']/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']             or cda:entryRelationship[@typeCode='REFR']/cda:substanceAdministration/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']             or cda:entryRelationship[@typeCode='COMP']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.8']             or cda:entryRelationship[@typeCode='COMP']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']             or cda:entryRelationship[@typeCode='COMP']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.15']             "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : Seuls les éléments "entryRelationship" optionnels suivants sont autorisés :
            - Motif du traitement : avec un typeCode='RSON' et une entrée Référence interne (1.3.6.1.4.1.19376.1.5.3.1.4.4.1)           
            - Référence de la prescription : avec un typeCode 'REFR' et une entrée Prescription (1.3.6.1.4.1.19376.1.5.3.1.4.7.3)
            - SubstanceAdministration subordonné : avec un typeCode='COMP' et une entrée de type substanceAdministration subordonnée            
            - Instructions au patient : avec un typeCode='SUBJ'  et une entrée Instructions au patient (1.3.6.1.4.1.19376.1.5.3.1.4.3)  
            - Instructions au dispensateur : avec un typeCode='SUBJ'  et une entrée Instructions au dispensateur (1.3.6.1.4.1.19376.1.5.3.1.4.3.1)            
            - Simple Observation : avec un typeCode='COMP' et une entrée Simple Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)            
            - Référence à un traitement d'un plan de traitement : avec un typeCode='REFR' et une entrée Référence à un traitement d'un plan de traitement (1.3.6.1.4.1.19376.1.9.1.3.10) 
            - Quantité à dispenser : avec un typeCode='COMP' et une entrée Quantité à dispenser (1.3.6.1.4.1.19376.1.9.1.3.8)
            - Autorisation de substitution : avec un typeCode='COMP' et une entrée Autorisation de substitution (1.3.6.1.4.1.19376.1.9.1.3.9.1)
            - Période de renouvellement : avec un typeCode='COMP' et une entrée Période de renouvellement (1.3.6.1.4.1.19376.1.9.1.3.15)
             
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;RSON&#34;]/cda:act"
                 priority="1007"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;RSON&#34;]/cda:act"/>

		    <!--REPORT -->
<xsl:if test="cda:templateId[@root != '1.3.6.1.4.1.19376.1.5.3.1.4.4.1'             and @root !='1.2.250.1.213.1.1.3.36' and @root !='2.16.840.1.113883.10.22.4.31']">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:templateId[@root != '1.3.6.1.4.1.19376.1.5.3.1.4.4.1' and @root !='1.2.250.1.213.1.1.3.36' and @root !='2.16.840.1.113883.10.22.4.31']">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="RSON" et qui est de type act, seule une entrée "Référence interne (1.3.6.1.4.1.19376.1.5.3.1.4.4.1)" est admise
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;REFR&#34;]/cda:supply"
                 priority="1006"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;REFR&#34;]/cda:supply"/>

		    <!--REPORT -->
<xsl:if test="cda:templateId[@root !='2.16.840.1.113883.10.20.1.34'             and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.7.3'             and @root !='1.2.250.1.213.1.1.3.44']">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:templateId[@root !='2.16.840.1.113883.10.20.1.34' and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.7.3' and @root !='1.2.250.1.213.1.1.3.44']">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="REFR" et qui est de type supply, seule une entrée "Prescription (1.3.6.1.4.1.19376.1.5.3.1.4.7.3)" est admise
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;SUBJ&#34;]/cda:act"
                 priority="1005"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;SUBJ&#34;]/cda:act"/>

		    <!--REPORT -->
<xsl:if test="cda:templateId[@root !='2.16.840.1.113883.10.20.1.49'             and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.3'             and @root !='1.2.250.1.213.1.1.3.33'             and @root !='2.16.840.1.113883.10.20.1.43'             and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.3.1'             and @root !='1.2.250.1.213.1.1.3.34'             ]">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:templateId[@root !='2.16.840.1.113883.10.20.1.49' and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.3' and @root !='1.2.250.1.213.1.1.3.33' and @root !='2.16.840.1.113883.10.20.1.43' and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.3.1' and @root !='1.2.250.1.213.1.1.3.34' ]">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="SUBJ" et qui est de type act,
            seules des entrées "Instructions au patient (1.3.6.1.4.1.19376.1.5.3.1.4.3)" et "Instructions au dispensateur (1.3.6.1.4.1.19376.1.5.3.1.4.3.1)" sont admises
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;COMP&#34;]/cda:observation"
                 priority="1004"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;COMP&#34;]/cda:observation"/>

		    <!--REPORT -->
<xsl:if test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.5.3.1.4.13'             and @root !='1.2.250.1.213.1.1.3.48'             and not(starts-with(@root, '1.2.250.1.213.1.1.3.48.'))]">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.5.3.1.4.13' and @root !='1.2.250.1.213.1.1.3.48' and not(starts-with(@root, '1.2.250.1.213.1.1.3.48.'))]">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="COMP" et qui est de type observation, seule une entrée "Simple Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)" est admise
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;REFR&#34;]/cda:substanceAdministration"
                 priority="1003"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;REFR&#34;]/cda:substanceAdministration"/>

		    <!--REPORT -->
<xsl:if test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.10'             and @root !='1.2.250.1.213.1.1.3.85']">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.10' and @root !='1.2.250.1.213.1.1.3.85']">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="REFR" et qui est de type substanceAdministration, seule une entrée "Référence à un traitement d'un plan de traitement (1.3.6.1.4.1.19376.1.9.1.3.10)" est admise
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;COMP&#34;]/cda:supply"
                 priority="1002"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;COMP&#34;]/cda:supply"/>

		    <!--REPORT -->
<xsl:if test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.8'             and @root !='1.2.250.1.213.1.1.3.86' and @root !='1.3.6.1.4.1.19376.1.9.1.3.15'             and @root !='1.2.250.1.213.1.1.3.88']">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.8' and @root !='1.2.250.1.213.1.1.3.86' and @root !='1.3.6.1.4.1.19376.1.9.1.3.15' and @root !='1.2.250.1.213.1.1.3.88']">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="COMP" et qui est de type supply,
            seules des entrées "Quantité à dispenser (1.3.6.1.4.1.19376.1.9.1.3.8)" et "Période de renouvellement (1.3.6.1.4.1.19376.1.9.1.3.15)" sont admises
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;COMP&#34;]/cda:act"
                 priority="1001"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]/cda:entryRelationship[@typeCode=&#34;COMP&#34;]/cda:act"/>

		    <!--REPORT -->
<xsl:if test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.9.1'             and @root !='1.2.250.1.213.1.1.3.87']">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.9.1' and @root !='1.2.250.1.213.1.1.3.87']">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="COMP" et qui est de type act, seule une entrée "Autorisation de substitution (1.3.6.1.4.1.19376.1.9.1.3.9.1)" est admise
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34; and not(cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.83&#34;)]/cda:routeCode"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34; and not(cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.83&#34;)]/cda:routeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@codeSystem='2.16.840.1.113883.5.112' or @codeSystem='0.4.0.127.0.16.1.1.2.1' or (@nullFlavor and not(@codeSystem))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_fr] Erreur de conformité CI-SIS : Un élément "routeCode" doit provenir du jeu de valeurs JDV_HL7_RouteOfAdministration-CISIS (2.16.840.1.113883.5.112) ou de la terminologie EDQM (0.4.0.127.0.16.1.1.2.1).
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

   <!--PATTERN E_patientTransfer_frIHE PCC v3.0 Patient Transfer - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Patient Transfer - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&#34;]"
                 priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = '80413-8']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_patientTransfer_fr] Erreur de conformité PCC : Le code utilisé pour un transfert est '80413-8'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = &#34;completed&#34; or @code=&#34;normal&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_patientTransfer_fr] Erreur de conformité PCC : Le statut du transfert est obligatoire. l'attribut @code prend la valeur
            @code='completed' si le transfert à eu lieu (moodCode='EVN') ou @code='normal' lorsque le
            tranfert est projeté (moodCode='INT')
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:statusCode[@code = 'completed']) or              (cda:statusCode[@code = 'completed'] and (cda:effectiveTime/cda:low and cda:effectiveTime/cda:high))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_patientTransfer_fr] Erreur de conformité PCC : effectiveTime est obligatoire lorsque le transfert a eu lieu. 
            Le sous-élément 'low' indique l'heure de départ et le sous-élément 'high' indique celle d'arrivée.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(self::cda:act[@negationInd='false']) or (self::cda:act[@negationInd='false' and @moodCode='EVN'] and cda:statusCode[@code = 'completed'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_patientTransfer_fr] Erreur de conformité PCC : l'attribut @code prend la valeur @code='completed' si le transfert à eu lieu (moodCode='EVN'). </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>

   <!--PATTERN E_periodeRenouvellement_frCI-SIS Entrée "FR-Periode-de-renouvellement"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Periode-de-renouvellement"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.15']" priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.15']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.3.88']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_periodeRenouvellement_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Periode-de-renouvellement" doit avoir deux occurrences de 'templateId' :
                - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.15"
                - Un deuxième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.88"
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>

   <!--PATTERN E_pregnancyHistoryOrganizer_frCI-SIS Pregnancy History Organizer-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Pregnancy History Organizer</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1&#34;]"
                 priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code[@codeSystem='1.2.250.1.213.2.12'])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_fr] : Erreur de conformité CI-SIS : Il doit y avoir un seul élément code et il doit être codé en SNOMED 3.5 (1.2.250.1.213.2.12)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>

   <!--PATTERN E_pregnancyObservation_frCI-SIS Pregnancy Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Pregnancy Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5&#34;]"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_pregnancyObservation_fr]: Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" comporte obligatoirement un élément "id" (cardinalité [1..1])</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_pregnancyObservation_fr]: Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" doit comporter un élément "code" (cardinalité [1..1])</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:text/cda:reference)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_pregnancyObservation_fr]: Erreur de conformité CI-SIS : Un élément "Pregnancy Observation"  doit comporter un élément "text" avec une référence (cardinalité [1..1])</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
         [E_pregnancyObservation_fr] Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" contient un "statutCode" qui sera toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
         [E_pregnancyObservation_fr] Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" contient un seul "effectiveTime"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_pregnancyObservation_fr] Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" ne doit comporter qu'un seul élément "value"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>

   <!--PATTERN E_problemConcernEntry_frCI-SIS Problem Concern Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Problem Concern Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@nullFlavor=&#34;NA&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemConcernEntry_fr] Ereur CI-SIS: L’élément code prend la valeur nullFlavor='NA' car l'identification du problème est faite à partir des éléments entryRelationship.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>

   <!--PATTERN E_problemEntry_frCI-SIS Problem Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Problem Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']" priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']"/>
      <xsl:variable name="count_code" select="count(self::cda:observation/cda:code)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_code=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemEntry_fr] Erreur de conformité CI-SIS : Dans l'élément "Problem Entry", il ne doit y avoir qu'un seul élément code
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code and @codeSystem]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemEntry_fr] Erreur de conformité CI-SIS : L'élément "code", contient les attributs code et codeSystem
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_fr] Erreur de conformité CI-SIS : L'élément "value" ne doit être présent qu'une fois </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>

   <!--PATTERN E_problemStatusObservation_frCI-SIS FR-Statut-du-probleme (Problem Status Observation - 1.3.6.1.4.1.19376.1.5.3.1.4.1.1)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS FR-Statut-du-probleme (Problem Status Observation - 1.3.6.1.4.1.19376.1.5.3.1.4.1.1)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1.1&#34;]"
                 priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value[@xsi:type=&#34;CE&#34; and (@codeSystem=&#34;1.2.250.1.213.2.12&#34; or @codeSystem=&#34;1.2.250.1.213.1.1.4.2.286&#34;)] and                  cda:value[@code = &#34;CDA_002&#34; or                 @code = &#34;G-A201&#34; or                 @code = &#34;G-A202&#34; or                 @code = &#34;G-A230&#34; or                 @code = &#34;G-A270&#34; or                 @code = &#34;G-A378&#34; or                 @code = &#34;G-A397&#34; or                 @code = &#34;G-A500&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_problemStatusObservation_fr] Erreur de Conformité CI-SIS : Pour tout élément de type 'Problem Status', l'élément 'value' signale le statut clinique.
                Il est toujours représenté utilisant le datatype 'CE' (xsi:type='CE'). 
                Il sera codé à partir d'un jeu de valeurs provenant de la nomenclature SNOMED 3.5.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>

   <!--PATTERN E_procedureEntry_frCI-SIS Procedure Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Procedure Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.19&#34;]"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.19&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:approachSiteCode)&gt;=0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_fr] Erreur de conformité CI-SIS : Un seul élément approachSiteCode au maximum peut être présent
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:targetSiteCode)&gt;=0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_fr] Erreur de conformité CI-SIS : Un seul élément targetSiteCode au maximum peut être présent
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>

   <!--PATTERN E_produitDeSantePrescrit_frCI-SIS Entrée "FR-Produit-de-sante-prescrit"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Produit-de-sante-prescrit"</svrl:text>

	  <!--RULE -->
<xsl:template match="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable/cda:manufacturedProduct/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2']"
                 priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable/cda:manufacturedProduct/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId[@root='1.2.250.1.213.1.1.3.84']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_ProduitDeSantePrescrit_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Produit-de-sante-prescrit" doit avoir un troisième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.84".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>

   <!--PATTERN E_quantiteProduit_frCI-SIS Entrée "FR-Quantite-de-produit"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Quantite-de-produit"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.8']" priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.8']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.3.86']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_quantiteProduit_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Quantite-de-produit" doit avoir deux occurrences de 'templateId' :
                - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.8"
                - Un deuxième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.86"
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>

   <!--PATTERN E_referenceItemPlanTraitement_frCI-SIS Entrée "FR-Reference-item-plan-traitement"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Reference-item-plan-traitement"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.10']" priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.10']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.3.85']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_referenceItemPlanTraitement_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Reference-item-plan-traitement" doit avoir deux occurrences de 'templateId' :
                - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.10"
                - Un deuxième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.85"
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>

   <!--PATTERN E_severity_frCI-SIS Severity-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Severity</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1&#34;]" priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code=&#34;SEV&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [ER_severity_fr] Erreur de Conformité CI-SIS: L'élément 'code' de l'entrée 'severity' indique la 
            sévérité de l'allergie provoquée.
            L'attribut code de l'élément 'code' est fixé à 'SEV'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>

   <!--PATTERN E_simpleObservation_frIHE PCC v3.0 Simple Observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Simple Observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"/>
      <xsl:variable name="count_value" select="count(cda:value)"/>
      <xsl:variable name="count_interpretationCode" select="count(cda:interpretationCode)"/>
      <xsl:variable name="count_methodCode" select="count(cda:methodCode)"/>
      <xsl:variable name="count_targetSiteCode" select="count(cda:targetSiteCode)"/>
      <xsl:variable name="count_author" select="count(cda:author)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_interpretationCode &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément interpretationCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_methodCode &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément methodCode ne peut être présent qu'une seule foix au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_targetSiteCode &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément targetSiteCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_author &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément author ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>

   <!--PATTERN E_socialHistoryObservation_frCI-SIS Social History Observation: 1.3.6.1.4.1.19376.1.5.3.1.4.13.4-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Social History Observation: 1.3.6.1.4.1.19376.1.5.3.1.4.13.4</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@moodCode=&#34;EVN&#34; and @classCode=&#34;OBS&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : Les attributs de l’élément "observation" sont fixés aux valeurs :
          classCode=’OBS’ et moodCode=’EVN’
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:id) or $count_id=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'indentifiant ne peut être présent qu'une seule fois au maximum
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'élément code est obligatoirement présent une seule fois
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'élément statusCode est obligatoirement présent une seule fois
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'élément effectiveTime est obligatoirement présent une seule fois
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'élément value est obligatoirement présent au moins une fois
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>

   <!--PATTERN E_supplyEntry_frCI-SIS Supply entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Supply entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']"/>
      <xsl:variable name="count_author" select="count(cda:author)"/>
      <xsl:variable name="count_performer" select="count(cda:performer)"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>
      <xsl:variable name="count_quantity" select="count(cda:quantity)"/>
      <xsl:variable name="count_effectiveTime" select="count(cda:effectiveTime)"/>
      <xsl:variable name="count_entryRelationShip"
                    select="count(cda:entryRelationship[@typeCode='SUBJ']/cda:act)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply doit contenir un élément id (cardinalité [1..1])
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_effectiveTime &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un effectiveTime au maximum (cardinalité [0..1])
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_quantity&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un élément 'quantity' au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_author&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un élément 'author' au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_performer&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un élément 'performer' au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_entryRelationShip&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un élément 'entryRelationShip' au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship) or (cda:entryRelationship and cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: Si l'élément supply conttient un entryRelationship, il doit avoir la forme suivante : entryRelationship[@typeCode='SUBJ']/act/templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1'])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>

   <!--PATTERN E_surveyObservation_frIHE PCC v3.0 Survey observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Survey observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6']"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6']"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_surveyObservation_fr] Erreur de conformité CI-SIS : L'élément Survey Observation doit contenir un seul id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_surveyObservation_fr] Erreur de conformité CI-SIS : L'élément Survey Observation doit avoir un statusCode dont la valeur est fixée à @code='completed'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>

   <!--PATTERN E_traitementPrescrit_frCI-SIS Entrée "FR-Traitement-prescrit"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Traitement-prescrit"</svrl:text>

	  <!--RULE -->
<xsl:template match="//cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.171']]/cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.171']]/cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]"/>
      <xsl:variable name="count_templateId"
                    select="count(//cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.171']]/cda:entry/cda:substanceAdministration/cda:templateId)"/>
      <xsl:variable name="count_ER_EnRapportALD"
                    select="count(cda:entryRelationship/cda:observation[cda:templateId[@root='1.2.250.1.213.1.1.3.48.13']])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.3.83']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit" doit avoir un templateId dont l'attribut @root="1.2.250.1.213.1.1.3.83" (Conformité de l'entrée aux spécifications CI-SIS)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;4"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : Il doit y avoir au minimum 5 occurences de l'élément 'templateId' dans cette entrée :
                - La première pour la déclaration de conformité de l'entrée aux spécifications IHE Pharm PRE @root="1.3.6.1.4.1.19376.1.9.1.3.2"
                - La deuxième pour la déclaration de conformité de l'entrée aux spécifications CCD @root="2.16.840.1.113883.10.20.1.24"
                - La troisème pour la déclaration de conformité de l'entrée aux spécifications IHE PCC @root="1.3.6.1.4.1.19376.1.5.3.1.4.7"
                - La quatrième pour la déclaration de conformité de l'entrée aux spécifications CI-SIS @root="1.2.250.1.213.1.1.3.83"
                - La cinquième pour la déclaration du mode d'administration du traitement prescrit (à choisir parmi la liste des modes d'administration)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_ER_EnRapportALD=1) or ($count_ER_EnRapportALD=0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [4] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : 
                - L'entryRelationship optionnelle "FR-En-rapport-avec-ALD" ne peut être présente qu'une fois (cardinalité [0..1]). 
                - Si présente, elle doit contenir un 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48.13" (Conformité de l'entrée au format CI-SIS) 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>

   <!--PATTERN E_traitementPrescritSubordonnee_frCI-SIS Entrée "FR-Traitement-prescrit-subordonnee"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée "FR-Traitement-prescrit-subordonnee"</svrl:text>

	  <!--RULE -->
<xsl:template match="//cda:entry/cda:substanceAdministration/cda:entryRelationship[@typeCode='COMP']/cda:substanceAdministration[@classCode='SBADM'][@moodCode='INT'][cda:templateId[@root='1.2.250.1.213.1.1.3.83.1']]"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:entry/cda:substanceAdministration/cda:entryRelationship[@typeCode='COMP']/cda:substanceAdministration[@classCode='SBADM'][@moodCode='INT'][cda:templateId[@root='1.2.250.1.213.1.1.3.83.1']]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_traitementPrescritSubordonnee_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit-subordonnee" doit posséder un élément 'id' (Conformité aux spécifications CI-SIS)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_traitementPrescritSubordonnee_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit-subordonnee" doit posséder un élément 'text' (Conformité aux spécifications CI-SIS)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_traitementPrescritSubordonnee_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit-subordonnee" doit posséder un élément 'statusCode' (Conformité aux spécifications CI-SIS)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:consumable"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_traitementPrescritSubordonnee_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit-subordonnee" doit posséder un élément 'consumable' (Conformité aux spécifications CI-SIS)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>

   <!--PATTERN E_transport_frIHE PCC v3.0 transport-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 transport</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1&#34;]"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1&#34;]"/>
      <xsl:variable name="count_Id" select="count(cda:id)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_Id = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_transport_fr.sch] Erreur de conformité CI-SIS : L'élément transport ne doit avoir qu'un seul id (cardinalité [1..1])
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime/cda:low[@value] and cda:effectiveTime/cda:high[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_transport_fr.sch] Erreur de conformité CI-SIS : L'élément transport doit avoir un élément effectiveTime/low avec un attribut @value et un élément effectiveTime/high avec un attribut @value
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>

   <!--PATTERN E_vitalSignsObservation_frModèles de contenu CDA  Vital Signs Observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Modèles de contenu CDA  Vital Signs Observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34;]"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34;]"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>
      <xsl:variable name="count_interpretationCode" select="count(cda:interpretationCode)"/>
      <xsl:variable name="count_methodCode" select="count(cda:methodCode)"/>
      <xsl:variable name="count_targetSiteCode" select="count(cda:targetSiteCode)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément 'id' ne peut être présent qu'une seule fois (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément 'text' doit être présent et contenir un élément 'reference'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément 'statusCode' est obligatoir et l'attribut @code est fixé à 'Completed'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_interpretationCode &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément interpretationCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_methodCode &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément methodCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_targetSiteCode &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément targetSiteCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>

   <!--PATTERN E_vitalSignsOrganizer_frModèle de Contenu CDA vital signs Organizer-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Modèle de Contenu CDA vital signs Organizer</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.1']"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.1']"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsOrganizer_fr] : Erreur de conformité CI-SIS : L'élément id ne peut être présent qu'une seule (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[(@code='F-03400' and @codeSystem='1.2.250.1.213.2.12') or (@code='85353-1' and @codeSystem='2.16.840.1.113883.6.1')]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_vitalSignsOrganizer_fr] : Erreur de conformité CI-SIS : L'élément code doit avoir les attributs suivants : 
           •	code='F-03400' et codeSystem=1.2.250.1.213.2.12 (SNOMED 3.5) ou
           •	code='85353-1' et codeSystem=2.16.840.1.113883.6.1 (LOINC)
           
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>

   <!--PATTERN E_disposition_frCI-SIS Entrée FR-Disposition-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée FR-Disposition</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.2.250.1.213.1.1.3.97']" priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.2.250.1.213.1.1.3.97']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_disposition_fr] Erreur de Conformité CI-SIS : 
            Une entrée 'FR_Disposition' ne peut avoir qu'un seul identifiant (id).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_disposition_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR_Disposition' doit comporter un (et un seul) élément statusCode.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:text/cda:reference[@value])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_disposition_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR_Disposition' doit comporter un (et un seul) élément 'text' avec une 'reference'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_disposition_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR_Disposition' doit comporter un (et un seul) élément 'code'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code/@code='11302-7'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_disposition_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR_Disposition' doit comporter le code 11302-7.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>

   <!--PATTERN E_statutDuDocument_frCI-SIS Statut du document-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Statut du document</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.16&#34;]" priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.16&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_statutDuDocument_fr] : Erreur de conformité CI-SIS : Un élément "Allergies and Intolerance" comporte obligatoirement un identifiant "id".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.2.250.1.213.1.1.3.48.16'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_statutDuDocument_fr] : Erreur de conformité CI-SIS : L'élément de templatId '1.2.250.1.213.1.1.3.48.16' doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.2.250.1.213.1.1.3.48'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_statutDuDocument_fr] : Erreur de conformité CI-SIS : L'élément de templatId '1.2.250.1.213.1.1.3.48' doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_statutDuDocument_fr] : Erreur de conformité CI-SIS : L'élément de templatId '1.3.6.1.4.1.19376.1.5.3.1.4.13' doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code/@code=&#34;GEN-065&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_statutDuDocument_fr] Erreur de Conformité CI-SIS:
            L'élément 'code' doit être obligatoirement 'GEN-065'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_statutDuDocument_fr] Erreur de conformité CI-SIS : L'élément "effectiveTime" doit être présent.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = &#34;completed&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_statutDuDocument_fr] Erreur de conformité CI-SIS: L'élément "statusCode" sera présent et prendra la valeur "completed"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_statutDuDocument_fr] Erreur de conformité CI-SIS: L'élément "value" doit être présent.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>

   <!--PATTERN E_evenementIndesirablePendantHospitalisation_frCI-SIS evenement indesirable pendant hospitalisation -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS evenement indesirable pendant hospitalisation </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.3&#34;]" priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.3&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirablePendantHospitalisation_fr] Erreur de conformité CI-SIS : Dans l'entrée FR-Evenement-indesirable-pendant-hospitalisation (1.2.250.1.213.1.1.3.48.3), 
            les attributs de l'élément CDA 'observation' sont classCode='OBS' et moodCode='EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirablePendantHospitalisation_fr] : Erreur de conformité CI-SIS : L'élément id est obligatoirement présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1 and cda:code/@code=&#34;MED-143&#34; and cda:code/@codeSystem=&#34;1.2.250.1.213.1.1.4.322&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirablePendantHospitalisation_fr] : Erreur de conformité CI-SIS : L'élément code doit être présent une fois et doit avoir l'attribut @code='MED-143' et
            le codeSystem='1.2.250.1.213.1.1.4.322'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_evenementIndesirablePendantHospitalisation_fr] : Erreur de conformité CI-SIS : Le composant "statutCode"
            est toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirablePendantHospitalisation_fr] : Erreur de conformité CI-SIS : L'élément effectiveTime doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirablePendantHospitalisation_fr] : Erreur de conformité CI-SIS : L'élément value doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>

   <!--PATTERN E_evenementIndesirableSuiteAdministrationDerivesSang_frCI-SIS evenement indesirable suite administration derives sang -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS evenement indesirable suite administration derives sang </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.4&#34;]" priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.4&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirableSuiteAdministrationDerivesSang_fr] Erreur de conformité CI-SIS : Dans l'entrée FR-Evenement-indesirable-suite-administration-derives-sang (1.2.250.1.213.1.1.3.48.4), 
            les attributs de l'élément CDA 'observation' sont classCode='OBS' et moodCode='EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirableSuiteAdministrationDerivesSang_fr] : Erreur de conformité CI-SIS : L'élément id est obligatoirement présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1 and cda:code/@code=&#34;MED-148&#34; and cda:code/@codeSystem=&#34;1.2.250.1.213.1.1.4.322&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirableSuiteAdministrationDerivesSang_fr] : Erreur de conformité CI-SIS : L'élément code doit être présent une fois et doit avoir l'attribut @code='MED-148' et
            le codeSystem='1.2.250.1.213.1.1.4.322'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_evenementIndesirableSuiteAdministrationDerivesSang_fr] : Erreur de conformité CI-SIS : Le composant "statutCode" 
            est toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirableSuiteAdministrationDerivesSang_fr] : Erreur de conformité CI-SIS : L'élément effectiveTime doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_evenementIndesirableSuiteAdministrationDerivesSang_fr] : Erreur de conformité CI-SIS : L'élément value doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>

   <!--PATTERN E_identificationMicroOrganismesMultiresistants_frCI-SIS identification microOrganismes multiresistants-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS identification microOrganismes multiresistants</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.5&#34;]" priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_identificationMicroOrganismesMultiresistants_fr] Erreur de conformité CI-SIS : Dans l'entrée FR-Identification-micro-organismes-multiresistants (1.2.250.1.213.1.1.3.48.5), 
            les attributs de l'élément CDA 'observation' sont classCode='OBS' et moodCode='EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_identificationMicroOrganismesMultiresistants_fr] : Erreur de conformité CI-SIS : L'élément id est obligatoirement présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1 and cda:code/@code=&#34;MED-144&#34; and cda:code/@codeSystem=&#34;1.2.250.1.213.1.1.4.322&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_identificationMicroOrganismesMultiresistants_fr] : Erreur de conformité CI-SIS : L'élément code doit être présent une fois et doit avoir l'attribut @code='MED-144' et
            le codeSystem='1.2.250.1.213.1.1.4.322'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_identificationMicroOrganismesMultiresistants_fr] : Erreur de conformité CI-SIS : Le composant "statutCode" 
            est toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_identificationMicroOrganismesMultiresistants_fr] : Erreur de conformité CI-SIS : L'élément effectiveTime doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_identificationMicroOrganismesMultiresistants_fr] : Erreur de conformité CI-SIS : L'élément value doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:author)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_identificationMicroOrganismesMultiresistants_fr] : Erreur de conformité CI-SIS : L'élément author doit être présent maximum une fois [0..1].
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>

   <!--PATTERN E_accidentsTransfusionnels_frCI-SIS accidents transfusionnels -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS accidents transfusionnels </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.1&#34;]" priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.48.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_accidentsTransfusionnels_fr] Erreur de conformité CI-SIS : Dans l'entrée	FR-Accidents-transfusionnels (1.2.250.1.213.1.1.3.48.1), 
            les attributs de l'élément CDA 'observation' sont classCode='OBS' et moodCode='EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_accidentsTransfusionnels_fr] : Erreur de conformité CI-SIS : L'élément id est obligatoirement présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1 and cda:code/@code=&#34;MED-146&#34; and cda:code/@codeSystem=&#34;1.2.250.1.213.1.1.4.322&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_accidentsTransfusionnels_fr] : Erreur de conformité CI-SIS : L'élément code doit être présent une fois et doit avoir l'attribut @code='MED-146' et
            le codeSystem='1.2.250.1.213.1.1.4.322'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_accidentsTransfusionnels_fr] : Erreur de conformité CI-SIS : Le composant "statutCode" 
            est toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_accidentsTransfusionnels_fr] : Erreur de conformité CI-SIS : L'élément effectiveTime doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_accidentsTransfusionnels_fr] : Erreur de conformité CI-SIS : L'élément value doit être présent une fois.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:author)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_accidentsTransfusionnels_fr] : Erreur de conformité CI-SIS : L'élément author doit être présent maximum une fois [0..1].
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>

   <!--PATTERN E_payers_frCI-SIS Entrée FR-Couverture-sociale-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Entrée FR-Couverture-sociale</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.17']"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.17']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_payers_fr] Erreur de Conformité CI-SIS : 
            Une entrée 'FR-Couverture-sociale' ne peut avoir qu'un seul identifiant (id).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_payers_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR-Couverture-sociale' doit comporter un (et un seul) élément statusCode.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_payers_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR-Couverture-sociale' doit comporter un (et un seul) élément 'code'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code/@code='48768-6'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_payers_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR-Couverture-sociale' doit comporter le code 48768-6.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.18'])&gt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_payers_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR-Couverture-sociale' doit comporter minimum une entryRelationship FR-Organisme-assurance-maladie [1..*].
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>

   <!--PATTERN E_instructionAuPatient_ANSFR-Instruction-au-patient-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">FR-Instruction-au-patient</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.2.250.1.213.1.1.3.48.35']" priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.2.250.1.213.1.1.3.48.35']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_instructionAuPatient.sch] Erreur de conformité CI-SIS : Le templateId parent FR-SimpleObservation "1.3.6.1.4.1.19376.1.5.3.1.4.13" est obligatoire
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code/@code='PINSTRUCT' and cda:code/@codeSystem='1.3.6.1.4.1.19376.1.5.3.2'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_instructionAuPatient.sch] Erreur de conformité CI-SIS : Les attributs de l'élément code prennent les valeurs suivantes :
            
            code=’PINSTRUCT’
            codeSystem=’1.3.6.1.4.1.19376.1.5.3.2’
            codeSystemName=’IHEActCode’
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
</xsl:stylesheet>