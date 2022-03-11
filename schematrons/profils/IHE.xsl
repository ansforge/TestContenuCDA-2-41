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
                              title="Rapport de conformité du document aux spécifications IHE (corps)"
                              schemaVersion="IHE.sch">
         <xsl:attribute name="phase">ihe</xsl:attribute>
         <xsl:attribute name="document">
            <xsl:value-of select="document-uri(/)"/>
         </xsl:attribute>
         <xsl:attribute name="dateHeure">
            <xsl:value-of select="format-dateTime(current-dateTime(), '[D]/[M]/[Y] à [H]:[m]:[s] (temps UTC[Z])')"/>
         </xsl:attribute>
         <xsl:text/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_abdomen</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_activeProblem</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_additionalSpecifiedObservation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_admissionMedicationHistory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_advanceDirectives</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_allergiesAndOtherAdverseReactions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_assessmentAndPlan</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_cancerDiagnosis</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_carePlan</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_childFunctionalStatusAssessment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_childFunctionalStatusEatingSleeping</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_clinicalInformation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedAdvanceDirectives</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_CodedAntenatalTestingAndSurveillance</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedCarePlan</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedDetailedPhysicalExamination</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedEventOutcome</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedFamilyMedicalHistory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedFunctionalStatus</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedHospitalCourse</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_CodedHospitalStudiesSummary</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedListOfSurgeries</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedReasonForReferral</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedResults</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedSocialHistory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_codedVitalSigns</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_currentAlcoholSubstanceAbuse</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_detailedPhysicalExamination</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_diagnosticConclusion</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_dischargeDiagnosis</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_dischargeDiet</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_documentSummary</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_ears</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_eatingAndSleepingAssessment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_EDDiagnosis</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_encounterHistories</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_endocrine</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M43"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_eyes</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M44"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_familyMedicalHistory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_functionnalStatus</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M46"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_generalAppearance</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M47"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_genitalia</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_healthMaintenanceCarePlan</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M49"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_heart</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M50"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_historyOfPastIllness</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M51"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_historyOfTobaccoUse</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M52"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_hospitalAdmissionDiagnosisSection</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M53"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_hospitalCourse</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M54"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_HospitalDischargeMedication</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M55"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_hospitalStudiesSummary</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M56"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_immunizationRecommendations</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M57"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_immunizations</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M58"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_integumentary</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M59"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_intraoperativeObservation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M60"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_intravenousFluidsAdministered</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M61"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_laboratoryReportItem</xsl:attribute>
            <svrl:text>Vérification de la conformité d'une section de 2ème niveau FR-Examen-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.2)</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M62"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_laboratorySpecialty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M63"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_listOfSurgeries</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M64"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_lymphaticPhysicalExam</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M65"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_macroscopicObservation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M66"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_medicalDevices</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M67"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_medicationAdministered</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M68"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_medications</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M69"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_microscopicObservation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M70"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_musculo</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M71"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_neurologic</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M72"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_newbornDelivryInformation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M73"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_occupationalDataForHealth</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M74"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_patientEducationAndConsents</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M75"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_payers</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M76"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_physicalExamination</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M77"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_physicalFunction</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M78"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_pregnancyHistory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M79"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_prenatalEvents</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M80"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_prescriptions_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M81"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_prescriptions_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M82"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_procedureCarePlan</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M83"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_proceduresIntervention</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M84"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_procedureSteps</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M85"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_progressNote</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M86"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_prothesesEtObjetsPerso</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M87"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_psychomotorDevelopment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M88"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_reasonForReferral</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M89"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_rectum</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M90"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_respiratoryPhysicalExam</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M91"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_results</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M92"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_socialHistory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M93"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_teethPhysicalExam</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M94"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_thoraxAndLungs</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M95"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_transfusionHistory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M96"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_transportMode</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M97"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_vitalSigns</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M98"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_historyOfPresentIllness</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M99"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_examenPhysiqueOculaire</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M100"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_mesureDeLaRefraction</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M101"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_analyseDesDispositifsOculaires</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M102"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_bilanOphtalmologique</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M103"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_allergiesAndIntoleranceConcern_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M104"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_allergiesAndIntolerances_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M105"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_autorisationSubstitution_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M106"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_birthEventOrganizer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M107"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_bloodTypeObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M108"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_codedAntenatalTestingAndSurveillanceOrg_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M109"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_comments_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M110"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_concernEntry_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M111"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_encounter_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M112"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_familyHistoryObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M113"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_familyHistoryOrganizer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M114"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_healthStatusObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M115"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_immunizations_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M116"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_instructionsDispensateur_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M117"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_instructionsPatient_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M118"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_itemPlanTraitement_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M119"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_laboratoryBatteryOrganizer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M120"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_laboratoryReportDataProcessing_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M121"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_medications_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M122"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_observationRequest_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M123"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_patientTransfer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M124"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_periodeRenouvellement_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M125"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_pregnancyHistoryOrganizer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M126"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_pregnancyObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M127"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_problemConcernEntry_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M128"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_problemEntry_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M129"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_problemOrganizer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M130"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_problemStatusObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M131"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_procedureEntry_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M132"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_product_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M133"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_produitDeSantePrescrit_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M134"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_quantiteProduit_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M135"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_referenceInterne_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M136"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_referenceItemPlanTraitement_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M137"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_severity_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M138"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_simpleObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M139"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_socialHistoryObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M140"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_specimenProcedureStep_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M141"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_specimenCollection_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M142"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_supplyEntry_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M143"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_surveyObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M144"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_transport_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M145"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_traitementPrescrit_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M146"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_traitementPrescritSubordonne_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M147"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_vitalSignsObservation_int.sch</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M148"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_vitalSignsOrganizer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M149"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_updateInformationOrganizer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M150"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_mesuresDispositifsOculaires_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M151"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_mesuresDispositifsOculairesObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M152"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_mesuresDeRefractionOrganizer_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M153"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_mesureDeRefractionObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M154"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_mesuresAcuiteVisuelle_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M155"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_mesuresAcuiteVisuelleObservation_int</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M156"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Rapport de conformité du document aux spécifications IHE (corps)</svrl:text>

   <!--PATTERN S_abdomenIHE PCC v3.0 Abdomen Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Abdomen Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.31&#34;]"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.31&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_abdomen.sch] Erreur de conformité volet PCC: Cet élément
            ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10191-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_abdomen.sch] Erreur de conformité volet PCC: Le code de la section Abdomen doit être 10191-5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_abdomen.sch] Erreur de conformité volet PCC: L'élément 'codeSystem' doit être codé à partir de la nomenclature
            LOINC (2.16.840.1.113883.6.1).
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

   <!--PATTERN S_activeProblemIHE PCC v3.0 Active Problems Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Active Problems Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6']" priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ActiveProblem.sch] Erreur de Conformité PCC: 'Active Problems' doit contenir au moins deux templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
         [S_ActiveProblem.sch] Erreur de Conformité PCC: 'Active Problems' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.11']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ActiveProblem.sch] Erreur de Conformité PCC: Le templateId parent de la section 'Active Problems' (2.16.840.1.113883.10.20.1.11) doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = '11450-4'] or ($count_templateId &gt;=2 and not(cda:code[@code = '11450-4']))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ActiveProblem.sch] Erreur de Conformité PCC: Le code de la section 'Active Problems' doit être '11450-4'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = '2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ActiveProblem.sch] Erreur de Conformité PCC: L'élément 'codeSystem' de la section 
            'Active Problems' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.4.5.2']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ActiveProblem.sch] Erreur de Conformité PCC: Une section "Active Problems" doit contenir des entrées de type "Problem Concern Entry"
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

   <!--PATTERN S_additionalSpecifiedObservationIHE Palm_Suppl_APSR V2.0 Additional Specified Observation Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Palm_Suppl_APSR V2.0 Additional Specified Observation Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.10.3.1']" priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.10.3.1']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_additionalSpecifiedObservation.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_additionalSpecifiedObservation.sch] Erreur de Conformité APSR : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
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
            [S_additionalSpecifiedObservation.sch] Erreur de conformité APSR : La section "Additional Specified Observation" doit contenir un élément text"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_additionalSpecifiedObservation.sch] Erreur de conformité APSR : La section "Additional Specified Observation" doit contenir un élément title"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

   <!--PATTERN S_admissionMedicationHistory-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.20&#34;]"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.20&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_admissionMedicationHistory.sch] Erreur de conformité PCC :  Ce composant ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;42346-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_admissionMedicationHistory.sch] Erreur de conformité PCC :  Le code de la section doit être 42346-7 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_admissionMedicationHistory.sch] Erreur de conformité PCC :  Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_admissionMedicationHistory.sch] Erreur de conformité PCC :  La section doit contenir des entrées 
            du type Medications Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.7).
            
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

   <!--PATTERN S_advanceDirectivesIHE PCC v3.0 Advance Directives Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Advance Directives Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.34&#34;]"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.34&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_advanceDirectives.sch] Erreur de conformité PCC : le templateId de 'Advance Directives' 
            ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;42348-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_advanceDirectives.sch] Erreur de conformité PCC : Le code de la section 'Advance Directives' doit être 42348-3 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_advanceDirectives.sch] Erreur de conformité PCC : L'attribut 'codeSystem' de la section 'Advance Directives' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
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

   <!--PATTERN S_allergiesAndOtherAdverseReactionsIHE PCC v3.0 Allergy and Other Adverse Reactions Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Allergy and Other Adverse Reactions Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.13&#34;]"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.13&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_allergiesAndOtherAdverseReaction.sch] Erreur de conformité PCC : Allergies and Other Adverse Reactions doit contenir au minimum deux templateIds (cardinalité [2..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_allergiesAndOtherAdverseReaction.sch] : Allergies and Other Adverse Reactions ne peut être utilisé que dans une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_allergiesAndOtherAdverseReaction.sch] : Le templateId parent CCD 3.8 de la section 'Allergies and Other Adverse Reactions' (2.16.840.1.113883.10.20.1.2) doit être présent</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;48765-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_allergiesAndOtherAdverseReaction.sch] : Le code de la section Allergies and Other Adverse Reactions doit être 48765-2
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_allergiesAndOtherAdverseReaction.sch] : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_allergiesAndOtherAdverseReaction.sch] : Allergies and Other Adverse Reactions doit contenir des éléments Allergy Concern Entry.
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

   <!--PATTERN S_assessmentAndPlanIHE PCC v3.0 Assessment and Plan Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Assessment and Plan Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.5&#34;]"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_assessmentAndPlan.sch] Erreur de Conformité volet PCC : 'Assessment and Plan' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;51847-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_assessmentAndPlan.sch] Erreur de Conformité volet PCC : Le code de la section 'Assessment and Plan' doit être 51847-2 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_assessmentAndPlan.sch] Erreur de Conformité volet PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
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

   <!--PATTERN S_cancerDiagnosisIHE PCC Cancer Diagnosis Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Cancer Diagnosis Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='2.16.840.1.113883.10.20.1.11'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir le template parent '2.16.840.1.113883.10.20.1.11'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir le templateId parent '1.3.6.1.4.1.19376.1.5.3.1.3.6'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.2.250.1.213.1.1.2.27'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir le templateId '1.2.250.1.213.1.1.2.27'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité : Ce template FR-Diagnostic-du-cancer ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code ='72135-7']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité : Le code de la section FR-Diagnostic-du-cancer doit être '72135-7'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité : L'élément 'codeSystem' de la section 
            FR-Diagnostic-du-cancer doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
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
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir un élément "text"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:entry/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir au moins une entrée FR-Liste-des-problemes (1.3.6.1.4.1.19376.1.5.3.1.4.5.2)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.7.3.1.4.14.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir au moins une entrée FR-Diagnostic-du-cancer (1.3.6.1.4.1.19376.1.7.3.1.4.14.1)
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

   <!--PATTERN S_carePlanIHE PCC v3.0 Care Plan Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Care Plan Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.31&#34;]"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.31&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_carePlan.sch] Erreur de conformité PCC : 'Care Plan' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_carePlan.sch] Erreur de conformité PCC : L'OID du template parent de la section 'Care Plan' (2.16.840.1.113883.10.20.1.10) est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_carePlan.sch] Erreur de conformité PCC : L'élément care plan doit avoir au moins deux templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18776-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_carePlan.sch] Erreur de conformité PCC : Le code de la section 'Care Plan' doit être '18776-5' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_carePlan.sch] Erreur de conformité PCC :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
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

   <!--PATTERN S_childFunctionalStatusAssessmentIHE PCC v3.0 Child Functional Status Assessment-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Child Functional Status Assessment</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.3&#34;]"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.3&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [childFunctionalStatusAssessment] 'Child Functional Status Assessment' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;47420-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [childFunctionalStatusAssessment] Le code de la section 'Child Functional Status Assessment' doit être '47420-5'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [childFunctionalStatusAssessment] L'élément 'codeSystem' de la section 'Child Functional Status Assessment' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:component) or cda:component/cda:section/cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.5&#34;] or cda:component/cda:section/cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [childFunctionalStatusAssessment1] La section 'Child Functional Status Assessment' ne contient pas de sous-section'Eating and sleeping Assessment' ou de sous-section 'Psychomotor Development'.        
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

   <!--PATTERN S_childFunctionalStatusEatingSleepingIHE PCC v3.0 Eating and sleeping Assessment-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Eating and sleeping Assessment</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.5&#34;]"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : 'Eating and sleeping Assessment' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;47420-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : Le code de la section 'Eating and sleeping Assessment' doit être '47420-5'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 'Eating and sleeping Assessment' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
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
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : L'élément child fonctional status eating sleeping doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:entry/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : L'élément child fonctional status eating sleeping doit contenir une entrée simpleObservation
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

   <!--PATTERN S_clinicalInformationIHE Palm_Suppl_APSR V2.0 Clinical Information Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Palm_Suppl_APSR V2.0 Clinical Information Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.1']" priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.1']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_clinicalInformation.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;22636-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_clinicalInformation.sch] Erreur de Conformité APSR : Le code de la section "Clinical Information" doit être 22636-5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_clinicalInformation.sch] Erreur de Conformité APSR : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
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
            [S_clinicalInformation.sch] Erreur de conformité APSR : La section "Clinical Information" doit contenir un élément text"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_clinicalInformation.sch] Erreur de conformité APSR : La section "Clinical Information" doit contenir un élément title"
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

   <!--PATTERN S_codedAdvanceDirectivesIHE PCC v3.0 Coded Advance Directives Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Advance Directives Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.35&#34;]"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.35&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : coded Advance Directives section doit contenir au minimum deux templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : le templateId de 'Coded Advance Directives' 
            ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.34&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : le templateId parent n'est pas présent.de 'Coded Advance Directives' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;42348-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : Le code de la section 'Coded Advance Directives' doit être 42348-3 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : L'attribut 'codeSystem' de la section 'Coded Advance Directives' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : la section 'Coded Advance Directives' doit avoir une 'Advance Directive Observation Entry'
            http://wiki.ihe.net/index.php?title=1.3.6.1.4.1.19376.1.5.3.1.3.35
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

   <!--PATTERN S_CodedAntenatalTestingAndSurveillanceIHE PCC v3.0 Coded Antenatal Testing and Surveillance Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Antenatal Testing and Surveillance Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.2.5.1&#34;]"
                 priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.2.5.1&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : Coded Antenatal Testing and Surveillance Section doit contenir au minimum deux templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : 'Coded Antenatal Testing and Surveillance' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;57078-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : Le code de la section 'Prenatal Events' doit être '57078-8'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Coded Antenatal Testing and Surveillance Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.2.5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : L'OID du template parent de la section 'Coded physical Exam' est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : Une section 'Antenatal Testing and Surveillance' doit contenir un élément 'Antenatal Testing and Surveillance Battery'.
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

   <!--PATTERN S_codedCarePlanIHE PCC v3.0 Coded Care Plan Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Care Plan Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.36&#34;]"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.36&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedCarePlan.sch] Erreur de conformité PCC : La section "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit contenir au minimum deux templateIds
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedCarePlan.sch] Erreur de conformité PCC :  La section "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) ne peut être utilisée que comme section.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedCarePlan.sch] Erreur de conformité PCC : Le templateId parent '2.16.840.1.113883.10.20.1.10' de la section "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit être présent</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18776-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedCarePlan.sch] Erreur de conformité PCC : Le code de la section "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit être '18776-5'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedCarePlan.sch] Erreur de conformité PCC :  L'élément 'codeSystem' de la section 
            "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit être "2.16.840.1.113883.6.1" (LOINC)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

   <!--PATTERN S_codedDetailedPhysicalExaminationIHE PCC v3.0 Physical Exam Section - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Physical Exam Section - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1&#34;]"
                 priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedDetailedPhysicalExamination.sch] Erreur de conformité PCC : Coded Detailed Physical Examination doit contenir au minimum les trois templateId suivants: 1.3.6.1.4.1.19376.1.5.3.1.3.24, 1.3.6.1.4.1.19376.1.5.3.1.1.9.15 et 1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            Erreur de Conformité PCC: 'Coded physical Exam' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.15&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            Erreur de Conformité PCC: L'OID du template parent de la section 'Coded physical Exam' est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;29545-1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            Erreur de Conformité PCC: Le code de la section 'Coded physical Exam' doit être '29545-1'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            Erreur de Conformité PCC: L'élément 'codeSystem' de la section 'Coded physical exam' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
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

   <!--PATTERN S_codedEventOutcomeIHE PCC v3.0 Coded Event Outcome Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Event Outcome Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.7&#34;]"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.7&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [S_codedEventOutcome.sch] Erreur de conformité PCC : coded Event Outcome doit contenir au minimum deux tempalteIds
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [S_codedEventOutcome.sch] Erreur de conformité PCC : coded Event Outcome doit contenir le templateId parent 1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9             
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_codedEventOutcome.sch] Erreur de conformité PCC : 'Event Outcome' ne peut être utilisé que comme section
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;42545-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_codedEventOutcome.sch] Erreur de conformité PCC : Le code de la section 'Event Outcome' doit être '42545-4'              
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_codedEventOutcome.sch] Erreur de conformité PCC :  L'élément 'codeSystem' de la section 
                'Event Outcome' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_codedEventOutcome.sch] Erreur de conformité PCC :  Une section "Event Outcome"
                doit contenir des entrée de type "Simple observations"
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

   <!--PATTERN S_codedFamilyMedicalHistoryIHE PCC v3.0 Coded Family Medical History Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Family Medical History Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.15&#34;]"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.15&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedFamilyMedicalHistory.sch] Erreur de conformité PCC : L'élément coded Family Medical history doit contenir au minimum deux templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFamilyMedicalHistory.sch] Erreur de conformité PCC : le templateId de 'Coded Family Medical History' 
            ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10157-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFamilyMedicalHistory] : Le code de la section 'Coded Family Medical History' doit être 10157-6
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFamilyMedicalHistory] : L'attribut 'codeSystem' de la section 'Coded Family Medical History' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.14&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFamilyMedicalHistory] : Le template parent 1.3.6.1.4.1.19376.1.5.3.1.3.14 (Coded Family Medical History) n'est pas présent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.15&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedFamilyMedicalHistory] : La section Coded Family Medical History 
            doit contenir au moins une entrée Family History Organizer.
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

   <!--PATTERN S_codedFunctionalStatusIHE PCC Coded Functional Status Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Coded Functional Status Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.2.1&#34;]"
                 priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.2.1&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : L'élément coded Functional Status Assessment doit contenir au moins trois templateIds
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : Ce template ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : Le templateiD parent "2.16.840.1.113883.10.20.1.5" est obligatoire. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.17&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : Le templateiD parent "1.3.6.1.4.1.19376.1.5.3.1.3.17" est obligatoire. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;47420-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : Le code de la section 'Progress Note' doit être 47420-5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : La section doit avoir un élément "title".
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
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : La section doit avoir un élément "text".
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

   <!--PATTERN S_codedHospitalCourseIHE Coded hospital Course Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Coded hospital Course Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.3.23.1&#34;]"
                 priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.3.23.1&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalCourse.sch] Erreur de conformité IHE : 'coded hospital Course' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedHospitalCourse.sch] Erreur de conformité IHE : L'élément hospital Course doit avoir au moins deux templateIds
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalCourse.sch] Erreur de conformité PCC : L'OID du template parent de la section 'coded Hospital Course' (1.3.6.1.4.1.19376.1.5.3.1.3.5) est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;8648-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalCourse.sch] Erreur de conformité IHE : Le code de la section 'hospital Course' doit être '8648-8' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalCourse.sch] Erreur de conformité IHE :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
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

   <!--PATTERN S_CodedHospitalStudiesSummaryIHE PCC v3.0 Coded Hospital Studies Summary Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Hospital Studies Summary Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.30&#34;]"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.30&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : 'Coded Hospital Studies Summary' doit contenir au moins deux templateIds
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : 'Coded Hospital Studies Summary' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root = '1.3.6.1.4.1.19376.1.5.3.1.3.29'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : Cette section doit avoir un templateId parent (1.3.6.1.4.1.19376.1.5.3.1.3.29)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11493-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : Le code de la section 'Coded Hospital Studies Summary Section' doit être '11493-4'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Coded Hospital Studies Summary Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root = '1.3.6.1.4.1.19376.1.5.3.1.4.19'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : L'entrée Procedure (1.3.6.1.4.1.19376.1.5.3.1.4.19) est obligatoire dans cette section
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

   <!--PATTERN S_codedListOfSurgeriesIHE PCC v3.0Coded List of Surgeries Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0Coded List of Surgeries Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.12&#34;]"
                 priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.12&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Coded List of Surgeries doit contenir au moins 3 templateIds
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Coded List of Surgeries ne peut être utilisé que dans une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.11']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Le templateId parent de la section 'Coded List of Surgeries' (1.3.6.1.4.1.19376.1.5.3.1.3.11) doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.12']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Le templateId parent de la section 'Coded List of Surgeries' (2.16.840.1.113883.10.20.1.12) doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : La section doit avoir un identifiant unique.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;47519-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC :  Le code de la section Coded List of Surgeries doit être 47519-4 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC :  L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.19&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Coded List of Surgeries doit contenir des éléments Procedure Entry.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>

   <!--PATTERN S_codedReasonForReferral-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.2&#34;]" priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.2&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedReasonForReferral_int.sch] Erreur de conformité : La section FR-Raison-de-la-recommandation doit contenir au moins deux templateId.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : Ce composant ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;42349-1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : Le code de la section FR-Raison-de-la-recommandation doit être 42349-1. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : Le code de la section FR-Raison-de-la-recommandation doit être issu de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : La section FR-Raison-de-la-recommandation doit contenir au moins une entrée 
            FR-Probleme (1.3.6.1.4.1.19376.1.5.3.1.4.5).            
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : La section FR-Raison-de-la-recommandation doit contenir au moins une entrée
            FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13).            
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

   <!--PATTERN S_codedResultsIHE PCC Coded Results Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Coded Results Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.28&#34;]"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.28&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedResults] Erreur de Conformité PCC : FR-Resultats-examens ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.27']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedResults] Erreur de conformité PCC : Le templateId parent (1.3.6.1.4.1.19376.1.5.3.1.3.27) doit être présent pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedResults] Erreur de Conformité PCC : Au minimum deux templateIds doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = '30954-2']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedResults] Erreur de Conformité PCC : Le code de la section FR-Resultats-examens doit être '30954-2'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedResults] Erreur de Conformité PCC : L'élément 'codeSystem' de la section 
            FR-Resultats-examens doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.19&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_CodedResults] Erreur de Conformité PCC : La section FR-Resultats-examens doit contenir au moins une entrée FR-Acte (Procedure Entry - 1.3.6.1.4.1.19376.1.5.3.1.4.19).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

   <!--PATTERN S_codedSocialHistoryIHE PCC v3.0 Coded Social History Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Social History Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.16.1&#34;]"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.16.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedSocialHistory] Erreur de Conformité PCC : Le templateId de 'Coded Social History' ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.16&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedSocialHistory] Erreur de Conformité PCC : L'OID du template parent de la section 'Coded Social History' est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedSocialHistory] Erreur de Conformité PCC : Au moins 3 templateIds doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;29762-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedSocialHistory] Erreur de Conformité PCC : Le code de la section 'Coded Social History' doit être 29762-2
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedSocialHistory] Erreur de Conformité PCC : L'attribut 'codeSystem' de la section 'Coded Social History' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_codedSocialHistory] Erreur de Conformité PCC : La section "Coded Social History"  doit contenir des éléments d'entrée "Social History Observation".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

   <!--PATTERN S_codedVitalSignsIHE PCC v3.0 Coded Vital Signs Section - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Vital Signs Section - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2&#34;]"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedVitalSigns] Erreur de Conformité PCC : Ce template ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedVitalSigns] Erreur de Conformité PCC : Trois templateIds au moins doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;8716-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedVitalSigns] Erreur de Conformité PCC : Le code de la section Coded Vital signs doit être 8716-3
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedVitalSigns] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.25&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_codedVitalSigns] Erreur de Conformité PCC : L'identifiant du template parent pour la section est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_codedVitalSigns] Erreur de Conformité PCC : Une section 'Coded Vital Signs' doit contenir un élément 'Vital Signs Organizer'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

   <!--PATTERN S_currentAlcoholSubstanceAbuseIHE PCC v3.0 Current Alcohol / Substance Abuse Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Current Alcohol / Substance Abuse Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.10&#34;]"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.10&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_currentAlcoholSubstanceAbuse] La section "Current Alcohol/Substance Abuse" ne peut être utilisée que dans une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18663-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_currentAlcoholSubstanceAbuse] Le code de la section history Of Tobacco Use doit être 18663-5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_currentAlcoholSubstanceAbuse] L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>

   <!--PATTERN S_detailedPhysicalExaminationSection detailed Physical Examination-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section detailed Physical Examination</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.15&#34;]"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.15&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_detailedPhysicalExamination] Erreur de Conformité : Le templateId de 'detailed Physical Examination' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_detailedPhysicalExamination] Erreur de Conformité PCC : Deux templateIds au moins doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.24'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_detailedPhysicalExamination] Erreur de Conformité PCC : Le template parent 1.3.6.1.4.1.19376.1.5.3.1.3.24 doit être présent pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;29545-1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_detailedPhysicalExamination] Erreur de Conformité  : Le code de la section detailed Physical Examination doit être '29545-1' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_detailedPhysicalExamination] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>

   <!--PATTERN S_diagnosticConclusionIHE Palm_Suppl_APSR V2.0 Diagnostic Conclusion Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Palm_Suppl_APSR V2.0 Diagnostic Conclusion Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.5']" priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.5']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_diagnosticConclusion.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;22637-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_diagnosticConclusion.sch] Erreur de Conformité APSR : Le code de la section "Diagnostic Conclusion" doit être 22637-3
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_diagnosticConclusion.sch] Erreur de Conformité APSR : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
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
            [S_diagnosticConclusion.sch] Erreur de conformité APSR : La section "Diagnostic Conclusion" doit contenir un élément text"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_diagnosticConclusion.sch] Erreur de conformité APSR : La section "Diagnostic Conclusion" doit contenir un élément title"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.8.1.3.6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_diagnosticConclusion.sch] Erreur de Conformité APSR : Une section "Diagnostic Conclusion" doit contenir au moins une entrée "Problem Organizer".           
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>

   <!--PATTERN S_dischargeDiagnosis-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.7&#34;]" priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Ce composant ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11535-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Le code de la section doit être 11535-2
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_dischargeDiagnosis] Erreur de Conformité PCC: La section doit contenir des entrées 
            du type Problem Concern Entry   (1.3.6.1.4.1.19376.1.5.3.1.4.5.2).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>

   <!--PATTERN S_dischargeDietIHE PCC v3.0 discharge Diet Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 discharge Diet Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.33&#34;]"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.33&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiet.sch] Erreur de conformité PCC : 'discharge Diet' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;42344-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiet.sch] Erreur de conformité PCC : Le code de la section 'discharge Diet' doit être '42344-2' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiet.sch] Erreur de conformité PCC :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>

   <!--PATTERN S_documentSummarySection Commentaire sur le document-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section Commentaire sur le document</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.4.1.2.16&#34;]"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.4.1.2.16&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentSummary.sch] Erreur de Conformité PCC : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.12.201&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentSummary.sch] Erreur de conformité PCC : L'OID parent (2.16.840.1.113883.10.12.201) doit être présent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentSummary.sch] Erreur de Conformité PCC : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;55112-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentSummary.sch] Erreur de Conformité PCC : Le code de cette section doit être '55112-7'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentSummary.sch] Erreur de Conformité PCC : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

   <!--PATTERN S_earsIHE PCC v3.0 Ears Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Ears Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.21&#34;]"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.21&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ears] Erreur de Conformité PCC: Ce template ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10195-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ears] Erreur de Conformité PCC: Le code de la section 'Ears' doit être 10195-6
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ears] Erreur de Conformité PCC: L'élément 'codeSystem' de la section 'Ears' 
            doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>

   <!--PATTERN S_eatingAndSleepingAssessmentIHE PCC v3.0 EatingAndSleepingAssessment Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 EatingAndSleepingAssessment Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.5&#34;]"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_EatingAndSleepingAssessment] Erreur de Conformité PCC: Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;47420-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_EatingAndSleepingAssessment] Erreur de Conformité PCC: Le code de la section Eating And Sleeping Assessment doit être 47420-5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_EatingAndSleepingAssessment] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_EatingAndSleepingAssessment] Erreur de Conformité PCC: la section 'Eating And Sleeping Assessment' doit avoir une 'Simple Observation Entry'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>

   <!--PATTERN S_EDDiagnosis-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.9&#34;]"
                 priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.9&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_EDDiagnosis] Erreur de conformité PCC: Ce composant ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11301-9&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_EDDiagnosis] Erreur de conformité PCC: Le code de la section doit être 11301-9 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_EDDiagnosis] Erreur de conformité PCC: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_EDDiagnosis] Erreur de conformité PCC: La section doit contenir des entrées 
            du type Conditions Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.5).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>

   <!--PATTERN S_encounterHistoriesIHE PCC v3.0 Encounter Histories Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Encounter Histories Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.3&#34;]"
                 priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.3&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_encounterHistories] Erreur de Conformité PCC: 'Encounter Histories' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_encounterHistories] Erreur de Conformité PCC: Les templateId des parents doivent être présents.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_encounterHistories] Erreur de Conformité PCC : Au minimum deux templateIds doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46240-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_encounterHistories] Erreur de Conformité PCC: Le code de la section 'Encounter Histories' doit être '46240-8'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = '2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_encounterHistories] Erreur de Conformité PCC: L'élément 'codeSystem' de la section 
            'Encounter Histories' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.14&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_encounterHistories] Erreur de Conformité PCC: Une section "Encounter Histories" doit contenir des entrée de type "Encounters".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>

   <!--PATTERN S_endocrineIHE PCC v3.0 Endocrine system-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Endocrine system</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.25&#34;]"
                 priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.25&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_endocrine] Erreur de Conformité PCC: Système Endocrinien et Métabolique ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;29307-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_endocrine] Erreur de Conformité PCC: Le code de la section Système Endocrinien et Métabolique doit être 29307-6
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_endocrine] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M43"/>
   </xsl:template>

   <!--PATTERN S_eyesIHE PCC v3.0 Eyes-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Eyes</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.19&#34;]"
                 priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.19&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_eyes] Erreur de Conformité PCC: Ce templateId 'Eyes' ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code =&#34;10197-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_eyes] Erreur de Conformité PCC: Le code de la section 'Eyes' doit être 10197-2
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_eyes] Erreur de Conformité PCC: L'élément 'codeSystem' de la section 'Eyes' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>

   <!--PATTERN S_familyMedicalHistoryIHE PCC v3.0 Family Medical History Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Family Medical History Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.14&#34;]"
                 priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.14&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_FamilyMedicalHistory.sch] Erreur de conformité PCC : le templateId de 'Family Medical History' 
            ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10157-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [FamilyMedicalHistory] : Le code de la section 'Family Medical History' doit être 10157-6
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [FamilyMedicalHistory] : L'attribut 'codeSystem' de la section ' Family Medical History' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>

   <!--PATTERN S_functionnalStatusIHE PCC v3.0 Functionnal Status Section - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Functionnal Status Section - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.17&#34;]"
                 priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.17&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_FunctionnalStatus] Erreur de Conformité PCC : Ce template ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_FunctionnalStatus] Erreur de Conformité PCC : Deux templateIds au moins doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;47420-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_FunctionnalStatus] Erreur de Conformité PCC : Le code de la section Functionnal Status doit être 47420-5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_FunctionnalStatus] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_FunctionnalStatus] Erreur de Conformité PCC : L'identifiant du template de conformité CCD est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>

   <!--PATTERN S_generalAppearanceIHE PCC v3.0 General appearance Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 General appearance Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.16&#34;]"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.16&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_generalAppearance] Erreur de Conformité PCC: Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10210-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_generalAppearance] Erreur de Conformité PCC: Le code de la section Système cutané doit être 10210-3
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_generalAppearance] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

   <!--PATTERN S_genitaliaIHE PCC v3.0 Genitalia-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Genitalia</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.36&#34;]"
                 priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.36&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_genitalia] Erreur de Conformité PCC: Cet élément ne peut être utilisé que comme section.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code =&#34;11400-9&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_genitalia] Erreur de Conformité PCC: Le code de la section doit être 11400-9
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_genitalia] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
                (2.16.840.1.113883.6.1). 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>

   <!--PATTERN S_healthMaintenanceCarePlanIHE PCC v3.0 healt Maintenance Care Plan Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 healt Maintenance Care Plan Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.50&#34;]"
                 priority="1000"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.50&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : 'health Maintenance Care Plan' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : L'OID du template parent de la section 'health Maintenance Care Plan' (2.16.840.1.113883.10.20.1.10) est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.31&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : L'OID du template parent de la section 'health Maintenance Care Plan' (1.3.6.1.4.1.19376.1.5.3.1.3.31) est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : La section health Maintenance Care Plan doit avoir au moins trois templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18776-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : Le code de la section 'health Maintenance Care Plan' doit être '18776-5' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>

   <!--PATTERN S_heartIHE PCC v3.0 Heart Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Heart Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.29&#34;]"
                 priority="1000"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.29&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [Heart.sch] Erreur de Conformité PCC: L'entité 'Système Cardiaque' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10200-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [Heart.sch] Erreur de Conformité PCC: Le code de la section 'Système Cardiaque' doit être 10200-4
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [Heart.sch] Erreur de Conformité PCC: L'attribut 'codeSystem' de la section 'Système Cardiaque'doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>

   <!--PATTERN S_historyOfPastIllnessIHE PCC v3.0 History of Past Illness Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 History of Past Illness Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.8&#34;]" priority="1000"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.8&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_historyOfPastIllness] History of Past Illness ne peut être utilisé que dans une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11348-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_historyOfPastIllness] Le code de la section History of Past Illness doit être 11348-0 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_historyOfPastIllness] L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_historyOfPastIllness] History of Past Illness doit contenir des éléments Problem Concern Entry.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>

   <!--PATTERN S_historyOfTobaccoUseIHE PCC v3.0 History of Tobacco Use Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 History of Tobacco Use Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.8&#34;]"
                 priority="1000"
                 mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.8&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_historyOfTobaccoUse] Erreur de conformité PCC :  history Of Tobacco Use ne peut être utilisé que dans une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11366-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_historyOfTobaccoUse] Erreur de conformité PCC :  Le code de la section history Of Tobacco Use doit être 11366-2 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_historyOfTobaccoUse] Erreur de conformité PCC :  L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M52"/>
   </xsl:template>

   <!--PATTERN S_hospitalAdmissionDiagnosisSectionIHE PCC v3.0 Hospital Admission Diagnosis Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Hospital Admission Diagnosis Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.3&#34;]" priority="1000"
                 mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.3&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [HospitalAdmissionDiagnosisSection.sch] : Erreur de conformité PCC : 'Hospital Admission Diagnosis' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46241-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [HospitalAdmissionDiagnosisSection.sch] : Erreur de conformité PCC : Le code de la section 'Hospital Admission Diagnosis' doit être '46241-6'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [HospitalAdmissionDiagnosisSection.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Hospital Admission Diagnosis' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:entry/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [HospitalAdmissionDiagnosisSection.sch] : Erreur de conformité PCC : La section doit contenir une entrée de type 'Problem Concern' qui contient un templateId dont la valeur de l'attribut @root est fixée à '1.3.6.1.4.1.19376.1.5.3.1.4.5.2'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>

   <!--PATTERN S_hospitalCourseIHE hospital Course Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE hospital Course Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.5&#34;]" priority="1000"
                 mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_hospitalCourse.sch] Erreur de conformité PCC : 'hospital Course' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;8648-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_hospitalCourse.sch] Erreur de conformité PCC : Le code de la section 'hospital Course' doit être '8648-8' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_hospitalCourse.sch] Erreur de conformité PCC :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M54"/>
   </xsl:template>

   <!--PATTERN S_HospitalDischargeMedicationIHE PCC v3.0 Hospital Discharge Medication Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Hospital Discharge Medication Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.22&#34;]"
                 priority="1000"
                 mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.22&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_HospitalDischargeMedication.sch] : Erreur de conformité PCC : 'Hospital Discharge Medication Section' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10183-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_HospitalDischargeMedication.sch] : Erreur de conformité PCC : Le code de la section 'Hospital Discharge Medication Section' doit être '10183-2'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_HospitalDischargeMedication.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Hospital Discharge Medication Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_HospitalDischargeMedication.sch] : Erreur de Conformité PCC : La section Medications doit contenir des entrées de type Medications Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M55"/>
   </xsl:template>

   <!--PATTERN S_hospitalStudiesSummaryIHE PCC Hospital Studies Summary Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Hospital Studies Summary Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.29&#34;]"
                 priority="1000"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.29&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_hospitalStudiesSummary.sch] : Erreur de conformité PCC : 'hospital Studies Summary' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11493-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_hospitalStudiesSummary.sch] : Erreur de conformité PCC : Le code de la section 'hospital Studies Summary Section' doit être '11493-4'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_hospitalStudiesSummary.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Hospital Studies Summary Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M56"/>
   </xsl:template>

   <!--PATTERN S_immunizationRecommendationsIHE PCC v3.0 Immunizations Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Immunizations Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.18.3.1&#34;]"
                 priority="1000"
                 mode="M57">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.18.3.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizationRecommendations] Erreur de Conformité PCC : immunization Recommendations ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18776-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizationRecommendations] Erreur de Conformité PCC : Le code de la section doit être 18776-5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizationRecommendations] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.12.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizationRecommendations] Erreur de Conformité PCC : Une section immunization Recommendations doit contenir au moins une entrée Immunization recommendation.           
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M57"/>
   </xsl:template>

   <!--PATTERN S_immunizationsIHE PCC v3.0 Immunizations Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Immunizations Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.23&#34;]"
                 priority="1000"
                 mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.23&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizations] Erreur de Conformité PCC : Immunizations ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizations] Erreur de Conformité PCC : L'OID de l'élément parent n'est pas présent.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_immunizations] Erreur de Conformité PCC : Au minimum deux templateIds doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11369-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizations] Erreur de Conformité PCC : Le code de la section doit être 11369-6 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizations] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.12&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_immunizations] Erreur de Conformité PCC : Une section Immunizations doit contenir au moins une entrée Immunization.           
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M58"/>
   </xsl:template>

   <!--PATTERN S_integumentaryIHE PCC v3.0 Integumentary System-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Integumentary System</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.17&#34;]"
                 priority="1000"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.17&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_integumentary] Erreur de Conformité PCC: Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;29302-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_integumentary] Erreur de Conformité PCC: Le code de la section 'Système cutané' doit être 29302-7
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_integumentary] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>

   <!--PATTERN S_intraoperativeObservationIHE Palm_Suppl_APSR V2.0 Intraoperative Observation Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Palm_Suppl_APSR V2.0 Intraoperative Observation Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.2']" priority="1000"
                 mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.2']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_intraoperativeObservation.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
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
            [S_intraoperativeObservation.sch] Erreur de conformité APSR : La section "Intraoperative Observation" doit contenir un élément text"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_intraoperativeObservation.sch] Erreur de conformité APSR : La section "Intraoperative Observation" doit contenir un élément title"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>

   <!--PATTERN S_intravenousFluidsAdministeredIHE PCC v3.0 Intravenous Fluids Administered Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Intravenous Fluids Administered Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.6&#34;]"
                 priority="1000"
                 mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.6&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_intravenousFluidsAdministered] Erreur de Conformité PCC : Le templateId de 'intravenous Fluids Administered' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;57072-1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_intravenousFluidsAdministered] Erreur de Conformité PCC : Le code de la section intravenous Fluids Administered doit être '57072-1' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_intravenousFluidsAdministered] Erreur de Conformité PCC : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.3.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_intravenousFluidsAdministered] Erreur de Conformité PCC : La section Medications doit contenir des entrées de type Intravenous Fluids (1.3.6.1.4.1.19376.1.5.3.1.1.13.3.2).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M61"/>
   </xsl:template>

   <!--PATTERN S_laboratoryReportItem-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.3.2.2&#34;]" priority="1000"
                 mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.3.2.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_laboratoryReportItem] Erreur de Conformité : Le templateId "1.3.6.1.4.1.19376.1.3.3.2.2" ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = '2.16.840.1.113883.6.1'] or not(cda:code/@code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laboratoryReportItem] Erreur de conformité :
            Le code d'une section de  niveau 2, s'il existe, doit appartenir à la terminologie LOINC. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text and count(cda:entry) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laboratoryReportItem] Erreur de conformité : 
            Une section de 2ème niveau FR-Examen-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.2) doit comporter exactement 1 élément text et 1 élément entry. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M62"/>
   </xsl:template>

   <!--PATTERN S_laboratorySpecialtyVérification de la conformité de la section FR-CR-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.1)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de la section FR-CR-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.1)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.3.3.2.1&#34;]" priority="1000"
                 mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.3.3.2.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:text and count(cda:entry) = 1 and not(cda:component)) or             (not(cda:text) and not(cda:entry) and count(cda:component) &gt; 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laboratorySpecialty] Erreur de conformité : 
            Une section FR-CR-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.1) doit comporter soit un élément text et un seul élément entry soit des sections de niveau 2. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M63"/>
   </xsl:template>

   <!--PATTERN S_listOfSurgeriesIHE PCC v3.0 List of Surgeries Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 List of Surgeries Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.11&#34;]"
                 priority="1000"
                 mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.11&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ListOfSurgeries.sch] Erreur de conformité PCC : List of Surgeries doit contenir au moins deux templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ListOfSurgeries.sch] Erreur de conformité PCC : List of Surgeries ne peut être utilisé que dans une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.12']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ListOfSurgeries.sch] Erreur de conformité PCC : Le templateId parent de la section 'List of Surgeries' (2.16.840.1.113883.10.20.1.12) doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;47519-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ListOfSurgeries.sch] Erreur de conformité PCC :  Le code de la section List of Surgeries doit être 47519-4 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ListOfSurgeries.sch] Erreur de conformité PCC :  L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M64"/>
   </xsl:template>

   <!--PATTERN S_lymphaticPhysicalExamIHE PCC v3.0 Lymphatic System-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Lymphatic System</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.32&#34;]"
                 priority="1000"
                 mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.32&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_lymphaticPhysicalExam] Erreur de Conformité PCC: Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code =&#34;11447-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_lymphaticPhysicalExam] Erreur de Conformité PCC: Le code de la section Système cutané doit être 11447-0
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_lymphaticPhysicalExam] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M65"/>
   </xsl:template>

   <!--PATTERN S_macroscopicObservationIHE Palm_Suppl_APSR V2.0 Macroscopic Observation Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Palm_Suppl_APSR V2.0 Macroscopic Observation Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.3']" priority="1000"
                 mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.3']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_macroscopicObservation.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;22634-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_macroscopicObservation.sch] Erreur de Conformité APSR : Le code de la section "Macroscopic Observation" doit être 22634-0
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_macroscopicObservation.sch] Erreur de Conformité APSR : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
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
            [S_macroscopicObservation.sch] Erreur de conformité APSR : La section "Macroscopic Observation" doit contenir un élément text"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_macroscopicObservation.sch] Erreur de conformité APSR : La section "Macroscopic Observation" doit contenir un élément title"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M66"/>
   </xsl:template>

   <!--PATTERN S_medicalDevicesIHE Section medicalD evices-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Section medicalD evices</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.5']"
                 priority="1000"
                 mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.5']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
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
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
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
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46264-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : Le code de la section Dispositifs médicaux doit être 46264-8
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : L'élément 'codeSystem' correspond à la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>

   <!--PATTERN S_medicationAdministeredIHE PCC v3.0 medication Administered Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 medication Administered Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.21&#34;]"
                 priority="1000"
                 mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.21&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_medicationAdministered] Erreur de Conformité PCC : Le templateId de 'medication Administered' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18610-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_medicationAdministered] Erreur de Conformité PCC : Le code de la section 'medication Administered' doit être '18610-6' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_medicationAdministered] Erreur de Conformité PCC : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_medicationAdministered] Erreur de Conformité PCC : La section 'medication Administered' doit contenir des entrées de type Medications Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M68"/>
   </xsl:template>

   <!--PATTERN S_medicationsIHE PCC v3.0 Medications Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Medications Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.19&#34;]"
                 priority="1000"
                 mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.19&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_medications] Erreur de Conformité PCC : Le templateId de 'Medications' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_medications] Erreur de Conformité PCC : Le templateId parent de Medications est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_medications] Erreur de Conformité PCC : Au minimum deux templateIds doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10160-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_medications] Erreur de Conformité PCC : Le code de la section 'Medications doit être '10160-0' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_medications] Erreur de Conformité PCC : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_medications] Erreur de Conformité PCC : La section Medications doit contenir des entrées de type Medications Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M69"/>
   </xsl:template>

   <!--PATTERN S_microscopicObservationIHE Palm_Suppl_APSR V2.0 Microscopic Observation Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Palm_Suppl_APSR V2.0 Microscopic Observation Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.4']" priority="1000"
                 mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.4']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_microscopicObservation.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;22635-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_microscopicObservation.sch] Erreur de Conformité APSR : Le code de la section "Microscopic Observation" doit être 22635-7
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_microscopicObservation.sch] Erreur de Conformité APSR : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
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
            [S_microscopicObservation.sch] Erreur de conformité APSR : La section "Microscopic Observation" doit contenir un élément text"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_microscopicObservation.sch] Erreur de conformité APSR : La section "Microscopic Observation" doit contenir un élément title"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M70"/>
   </xsl:template>

   <!--PATTERN S_musculoIHE PCC v3.0 Musculoskeletal system Section - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Musculoskeletal system Section - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.34&#34;]"
                 priority="1000"
                 mode="M71">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.34&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_musculo] Erreur de Conformité PCC: l'élément 'Musculoskeletal system' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code =&#34;11410-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_musculo] Erreur de Conformité PCC: Le code de la section 'Musculoskeletal system' doit être 11410-8
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_musculo] Erreur de Conformité PCC: L'attribut 'codeSystem' de la section 'Musculoskeletal system' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M71"/>
   </xsl:template>

   <!--PATTERN S_neurologicIHE PCC v3.0 Neurologic System-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Neurologic System</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.35&#34;]"
                 priority="1000"
                 mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.35&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_neurologic] Erreur de Conformité PCC: "Neurologic System" ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code =&#34;10202-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_neurologic] Erreur de Conformité PCC: Le code de la section "Neurologic System" doit être 10202-0
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_neurologic] Erreur de Conformité PCC: L'attribut 'codeSystem' de la section "Neurologic System" doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M72"/>
   </xsl:template>

   <!--PATTERN S_newbornDelivryInformationNewborn Delivry Information Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Newborn Delivry Information Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.2.4&#34;]"
                 priority="1000"
                 mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.2.4&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_newbornDelivryInformation] Erreur de conformité PCC : 'Newborn Delivry Information Section' ne peut être utilisé que comme section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;57075-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_newbornDelivryInformation.sch] Erreur de Conformité PCC : Le code de la section Travail et accouchement doit être 57075-4
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_newbornDelivryInformation.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 'Travail et accouchement' doit
            être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component/cda:section/cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_newbornDelivryInformation.sch] Erreur de conformité PCC : Cette section comporte obligatoirement une sous-section de type Examen physique codé (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M73"/>
   </xsl:template>

   <!--PATTERN S_occupationalDataForHealthIHE PCC v3.0 occupational Data For Health-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 occupational Data For Health</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.37&#34;]"
                 priority="1000"
                 mode="M74">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.37&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_occupationalDataForHealth] Erreur de Conformité PCC: "Occupational Data For Health" ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code =&#34;74166-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_occupationalDataForHealth] Erreur de Conformité PCC: Le code de la section "Occupational Data For Health" doit être 74166-0
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_occupationalDataForHealth] Erreur de Conformité PCC: L'attribut 'codeSystem' de la section "Occupational Data For Health" doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M74"/>
   </xsl:template>

   <!--PATTERN S_patientEducationAndConsentsIHE PCC v3.0 Patient Education and Consents-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Patient Education and Consents</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.39&#34;]"
                 priority="1000"
                 mode="M75">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.39&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_patientEducationAndConsents] 'Patient Education and Consents' ne peut qu'être utilisé que comme sections. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.38&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_patientEducationAndConsents] le templateId parent de la section 'Patient Education and Consents' n'est pas présent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;34895-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_patientEducationAndConsents] Le code de la section 'Patient Education and Consents' doit être '34895-3' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_patientEducationAndConsents] élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M75"/>
   </xsl:template>

   <!--PATTERN S_payersSection couverture sociale-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section couverture sociale</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.7&#34;]"
                 priority="1000"
                 mode="M76">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_payers] Erreur de conformité PCC : 'Couverture sociale' ne peut être utilisé que comme section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId) &gt; 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_payers] Erreur de conformité PCC : Au moins deux templateIds doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='2.16.840.1.113883.10.20.1.9'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_payers] Erreur de conformité PCC : Le template parent CCD payers (2.16.840.1.113883.10.20.1.9) doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;48768-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_payers.sch] Erreur de Conformité PCC : Le code de la section couverture sociale doit être 48768-6
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_payers.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 'couverture sociale' doit
            être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M76"/>
   </xsl:template>

   <!--PATTERN S_physicalExaminationSection Physical Examination-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section Physical Examination</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.24&#34;]"
                 priority="1000"
                 mode="M77">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.24&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_PhysicalExamination] Erreur de Conformité : Le templateId de 'Physical Examination' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;29545-1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_PhysicalExamination] Erreur de Conformité  : Le code de la section Physical Examination doit être '29545-1' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_PhysicalExamination] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M77"/>
   </xsl:template>

   <!--PATTERN S_physicalFunctionSection Physical Function-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section Physical Function</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5&#34;]"
                 priority="1000"
                 mode="M78">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_PhysicalFunction] Erreur de Conformité : Le templateId de 'Physical Function' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46006-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_PhysicalFunction] Erreur de Conformité  : Le code de la section Physical Function doit être '46006-3' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_PhysicalFunction] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M78"/>
   </xsl:template>

   <!--PATTERN S_pregnancyHistorySection FR-Historique-des-grossesses (IHE PCC Pregnancy History Section)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section FR-Historique-des-grossesses (IHE PCC Pregnancy History Section)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4&#34;]"
                 priority="1000"
                 mode="M79">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4&#34;]"/>
      <xsl:variable name="count_E_ObsGross"
                    select="count(//cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5'])"/>
      <xsl:variable name="count_E_HistoGross"
                    select="count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1'])"/>
      <xsl:variable name="count_nb_entrees" select="count(//cda:entry)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [1] [S_pregnancyHistory] Erreur de conformité PCC : Le templateId de 'Pregnancy History' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10162-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [2] [S_pregnancyHistory] Erreur de conformité PCC : Le code de la section FR-Historique-des-grossesses doit être "10162-6" 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [3] [S_pregnancyHistory] Erreur de conformité PCC : Le codeSystem de la section FR-Historique-des-grossesses doit être "2.16.840.1.113883.6.1" (LOINC). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(//cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5'])             + count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1'])              = count(//cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4']/cda:entry))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [4] [S_pregnancyHistory] Erreur de conformité PCC : 
            Une section FR-Historique-des-grossesses doit comporter uniquement des entrées de type :
            - FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) ou 
            - FR-Historique-de-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_E_ObsGross&gt;=0) and ($count_E_HistoGross&gt;=0) and ($count_E_ObsGross+$count_E_HistoGross&gt;=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [5] [S_pregnancyHistory] Erreur de conformité PCC : 
            La section FR-Historique-des-grossesses doit contenir au moins une des deux entrées suivantes (cardinalité [1..*]) :
            - [0..*] FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) (conformité de l'entrée au format IHE PCC) et/ou
            - [0..*] FR-Historique-de-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1) (conformité de l'entrée au format IHE PCC)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M79"/>
   </xsl:template>

   <!--PATTERN S_prenatalEventsIHE PCC v3.0 Prenatal Events Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Prenatal Events Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.2.2&#34;]"
                 priority="1000"
                 mode="M80">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.2.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_prenatalEvents] Erreur de Conformité PCC: 'Prenatal Events' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;57073-9&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_prenatalEvents] Erreur de Conformité PCC: Le code de la section 'Prenatal Events' doit être '57073-9'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_prenatalEvents] Erreur de Conformité PCC: L'élément 'codeSystem' de la section 
            'Prenatal Events' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="@*|node()" priority="-2" mode="M80">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M80"/>
   </xsl:template>

   <!--PATTERN S_prescriptions_int Section IHE "Prescription section"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl"> Section IHE "Prescription section"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.2.1']" priority="1000"
                 mode="M81">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.2.1']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                Il faut obligatoirement un élément 'id' pour la section (cardinalité [1..1]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code='57828-6'] and count(cda:code) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [3] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                L'élément code est obligatoire et doit avoir son attribut @code ="57828-6" (cardinalité [1..1])
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1'] and count(cda:code) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [4] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                L'élément code est obligatoire et doit avoir son attribut @codeSystem = "2.16.840.1.113883.6.1" (cardinalité [1..1])
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(//cda:section[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.2.1']]/cda:entry[cda:substanceAdministration/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']])                 = count(//cda:section[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.2.1']]/cda:entry[//cda:templateId[@root]])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [5] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                La section "Prescription" ne peut contenir qu'une/des entrée(s) "Prescription Item Entry Content Module" (cardinalité [1..*]), 
                dont le 'templateId' doit avoir un attribut @root="1.3.6.1.4.1.19376.1.9.1.3.2" (conformité de l'entrée au format IHE Pharm PRE)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="@*|node()" priority="-2" mode="M81">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M81"/>
   </xsl:template>

   <!--PATTERN S_prescriptions_frCI-SIS section "FR-Prescriptions"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS section "FR-Prescriptions"</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.2.1']" priority="1000"
                 mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.2.1']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.2.250.1.213.1.1.2.171']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [S_prescriptions_fr.sch] Erreur de conformité CI-SIS : 
                La section "FR-Prescriptions" doit avoir un templateId dont l'attribut @root="1.2.250.1.213.1.1.2.171" (Conformité de la section au format CI-SIS)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:entry/cda:substanceAdministration/cda:templateId[@root='1.2.250.1.213.1.1.3.83']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [S_prescriptions_fr.sch] Erreur de conformité CI-SIS :
                La section "FR-Prescriptions" ne peut contenir qu'une/des entrée(s) de type "FR-Traitement-prescrit" (cardinalité [1..*]),
                dont le templateId' doit être @root="1.2.250.1.213.1.1.3.83" (conformité de l'entrée au format CI-SIS).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="@*|node()" priority="-2" mode="M82">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>

   <!--PATTERN S_procedureCarePlanIHE PCC v3.0 Procedure Care Plan Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Procedure Care Plan Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.40&#34;]"
                 priority="1000"
                 mode="M83">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.40&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProcedureCarePlan] Erreur de conformité PCC : 'Coded Care Plan' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProcedureCarePlan] Erreur de conformité PCC: Deux templateIds au moins doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.31&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProcedureCarePlan] Erreur de conformité PCC : Le templateId parent de la section 'Procedure Care Plan' (1.3.6.1.4.1.19376.1.5.3.1.1.9.40) doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18776-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProcedureCarePlan] Erreur de conformité PCC : Le code de la section 'Procedure Care Plan' doit être '18776-5'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProcedureCarePlan] Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'ProcedureCarePlan' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="@*|node()" priority="-2" mode="M83">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M83"/>
   </xsl:template>

   <!--PATTERN S_proceduresInterventionIHE PCC v3.0 Procedures and Intervention Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Procedures and Intervention Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11&#34;]"
                 priority="1000"
                 mode="M84">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_proceduresIntervention] Erreur de conformité PCC: 'Procedures' ne peut être utilisé que comme section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;29554-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_proceduresIntervention] Erreur de conformité PCC: Le code de la section 'Procedures' doit être '29554-3'              
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_proceduresIntervention] Erreur de conformité PCC: L'élément 'codeSystem' de la section 
            'Procedures' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.19&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_proceduresIntervention] Erreur de conformité PCC: Une section "Procedures and Interventions" doit contenir des entrée de type "Procedures entry"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M84"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M84"/>
   <xsl:template match="@*|node()" priority="-2" mode="M84">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M84"/>
   </xsl:template>

   <!--PATTERN S_procedureStepsIHE Palm_Suppl_APSR V2.0 Procedure steps Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Palm_Suppl_APSR V2.0 Procedure steps Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.6']" priority="1000"
                 mode="M85">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.6']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_procedureSteps.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46059-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_procedureSteps.sch] Erreur de Conformité APSR : Le code de la section "Procedure steps" doit être 46059-2
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_procedureSteps.sch] Erreur de Conformité APSR : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
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
            [S_procedureSteps.sch] Erreur de conformité APSR : La section "Procedure steps" doit contenir un élément text"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_procedureSteps.sch] Erreur de conformité APSR : La section "Procedure steps" doit contenir un élément title"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M85"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M85"/>
   <xsl:template match="@*|node()" priority="-2" mode="M85">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M85"/>
   </xsl:template>

   <!--PATTERN S_progressNoteIHE PCC Progress Note Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Progress Note Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.7&#34;]"
                 priority="1000"
                 mode="M86">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.13.2.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_progressNote] Erreur de conformité PCC: Ce template ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18733-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_progressNote] Erreur de conformité PCC: Le code de la section 'Progress Note' doit être 18733-6
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_progressNote] Erreur de conformité PCC: L'élément 'codeSystem' de la section 'Results' 
            doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_progressNote] Erreur de conformité PCC: Cette section doit avoir un titre significatif de son contenu.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_progressNote] Erreur de conformité PCC: Les sections doivent avoir un identifiant unique permettant de les identifier.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M86"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M86"/>
   <xsl:template match="@*|node()" priority="-2" mode="M86">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M86"/>
   </xsl:template>

   <!--PATTERN S_prothesesEtObjetsPersoProthèse et objets personnel Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prothèse et objets personnel Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.53&#34;]" priority="1000"
                 mode="M87">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.53&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProthesesEtObjetsPerso] Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46264-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProthesesEtObjetsPerso] Erreur de Conformité CI-SIS: Le code de la section Protheses Et Objets Personnels doit être 46264-8
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProthesesEtObjetsPerso] Erreur de Conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_ProthesesEtObjetsPerso] Erreur de Conformité CI-SIS : la section 'Protheses Et Objets Personnels' doit avoir une 'Simple Observation Entry'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="@*|node()" priority="-2" mode="M87">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M87"/>
   </xsl:template>

   <!--PATTERN S_psychomotorDevelopmentIHE PCC v3.0 Psychomotor Development-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Psychomotor Development</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.4&#34;]"
                 priority="1000"
                 mode="M88">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.7.3.1.1.13.4&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_psychomotorDevelopment] Erreur de conformité : 'Psychomotor Development' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;xx-MCH-PsychoMDev&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_psychomotorDevelopment] Erreur de conformité : Le code de la section 'Psychomotor Development' doit être 'xx-MCH-PsychoMDev'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_psychomotorDevelopment] Erreur de conformité : L'élément 'codeSystem' de la section 'Psychomotor Development' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_psychomotorDevelopment] Erreur de conformité : La section 'Psychomotor Development' ne contient pas d'entrée 'Simple Observation'.        
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M88"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M88"/>
   <xsl:template match="@*|node()" priority="-2" mode="M88">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M88"/>
   </xsl:template>

   <!--PATTERN S_reasonForReferral-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.1&#34;]" priority="1000"
                 mode="M89">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ReasonForReferral] Erreur de Conformité PCC: Ce composant ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;42349-1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ReasonForReferral] Erreur de Conformité PCC: Le code de la section doit être 42349-1 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ReasonForReferral] Erreur de Conformité PCC: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M89"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M89"/>
   <xsl:template match="@*|node()" priority="-2" mode="M89">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M89"/>
   </xsl:template>

   <!--PATTERN S_rectumIHE PCC v3.0 Rectum Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Rectum Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.37&#34;]"
                 priority="1000"
                 mode="M90">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.37&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_rectum] Erreur de Conformité PCC : Ce template ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10205-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_rectum] Erreur de Conformité PCC :  Le code de la section 'Rectum' doit être 10205-3
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_rectum] Erreur de Conformité PCC : L'élément 'codeSystem' de la section 'Rectum' 
            doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="@*|node()" priority="-2" mode="M90">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M90"/>
   </xsl:template>

   <!--PATTERN S_respiratoryPhysicalExamIHE PCC v3.0 Respiratory System-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Respiratory System</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.30&#34;]"
                 priority="1000"
                 mode="M91">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.30&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_respiratoryPhysicalExam] Erreur de Conformité PCC: Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code =&#34;11412-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_respiratoryPhysicalExam] Erreur de Conformité PCC: Le code de la section doit être 11412-4
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_respiratoryPhysicalExam] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M91"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M91"/>
   <xsl:template match="@*|node()" priority="-2" mode="M91">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M91"/>
   </xsl:template>

   <!--PATTERN S_resultsIHE PCC Results Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Results Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.27&#34;]"
                 priority="1000"
                 mode="M92">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.27&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Results] Erreur de Conformité PCC :  'Results' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = '30954-2']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Results] Erreur de Conformité PCC : Le code de la section 'Results' doit être '30954-2'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Results] Erreur de Conformité PCC : L'élément 'codeSystem' de la section 
            'Results' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.28&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Results] Erreur de Conformité PCC : La section Results est non codée et ne doit contenir aucune entrée
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M92"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M92"/>
   <xsl:template match="@*|node()" priority="-2" mode="M92">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M92"/>
   </xsl:template>

   <!--PATTERN S_socialHistoryIHE PCC v3.0 Social History Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Social History Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.16&#34;]"
                 priority="1000"
                 mode="M93">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.16&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_socialHistory] Erreur de Conformité PCC : Le templateId de 'Social History' ne peut être utilisé que pour une section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_socialHistory] Erreur de Conformité PCC : Le templateId 2.16.840.1.113883.10.20.1.15 parent obligatoire de la section est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;29762-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_socialHistory] Erreur de Conformité PCC : Le code de la section 'Social History' doit être 29762-2
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_socialHistory] Erreur de Conformité PCC : L'attribut 'codeSystem' de la section 'Social History' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M93"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M93"/>
   <xsl:template match="@*|node()" priority="-2" mode="M93">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M93"/>
   </xsl:template>

   <!--PATTERN S_teethPhysicalExamIHE PCC v3.0 Mouth, Throat and Teeth section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Mouth, Throat and Teeth section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.23&#34;]"
                 priority="1000"
                 mode="M94">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.23&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_teethPhysicalExam] Erreur de Conformité PCC: section 'Mouth, Throat and Teeth' ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10201-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_teethPhysicalExam] Erreur de Conformité PCC: Erreur de Conformité PCC: Le code de la section 'Mouth, Throat and Teeth' doit être 10200-4
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_teethPhysicalExam] Erreur de Conformité PCC: Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M94"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M94"/>
   <xsl:template match="@*|node()" priority="-2" mode="M94">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M94"/>
   </xsl:template>

   <!--PATTERN S_thoraxAndLungsIHE PCC v3.0 Neurologic System-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Neurologic System</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.26&#34;]"
                 priority="1000"
                 mode="M95">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.26&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_thoraxAndLungs] Erreur de conformité PCC : "Thorax and Lungs Section" ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code =&#34;10207-9&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_thoraxAndLungs] Erreur de conformité PCC : Le code de la section " Thorax and Lungs Section" doit être 10207-9
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_thoraxAndLungs] Erreur de conformité PCC : L'attribut 'codeSystem' de la section "Thorax and Lungs Section" doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M95"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M95"/>
   <xsl:template match="@*|node()" priority="-2" mode="M95">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M95"/>
   </xsl:template>

   <!--PATTERN S_transfusionHistory-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.12&#34;]"
                 priority="1000"
                 mode="M96">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.9.12&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_transfusionHistory] Erreur de conformité CI-SIS: transfusion History ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;56836-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_transfusionHistory] Erreur de conformité CI-SIS: Le code de la section transfusion History doit être 56836-0 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_transfusionHistory] Erreur de conformité CI-SIS: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="@*|node()" priority="-2" mode="M96">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M96"/>
   </xsl:template>

   <!--PATTERN S_transportMode-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.10.3.2&#34;]"
                 priority="1000"
                 mode="M97">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.10.3.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_transportMode] Erreur de conformité CI-SIS: Transport Mode ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11459-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_transportMode] Erreur de conformité CI-SIS: Le code de la section Transport Mode doit être 11459-5 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_transportMode] Erreur de conformité CI-SIS: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_transportMode] Erreur de conformité CI-SIS: La section Transport Mode Section doit contenir des entrées 
            du type Transport Entry (1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M97"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M97"/>
   <xsl:template match="@*|node()" priority="-2" mode="M97">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M97"/>
   </xsl:template>

   <!--PATTERN S_vitalSignsIHE PCC v3.0 Vital Signs Section - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Vital Signs Section - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.25&#34;]"
                 priority="1000"
                 mode="M98">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.25&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_VitalSigns] Erreur de Conformité PCC : Ce template ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_VitalSigns] Erreur de Conformité PCC : Deux templateIds au moins doivent être présents pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;8716-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_VitalSigns] Erreur de Conformité PCC : Le code de la section Vital signs doit être 8716-3
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_VitalSigns] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_VitalSigns] Erreur de Conformité PCC : L'identifiant du template parent pour la section est absent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M98"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M98"/>
   <xsl:template match="@*|node()" priority="-2" mode="M98">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M98"/>
   </xsl:template>

   <!--PATTERN S_historyOfPresentIllnessVérification de la conformité de la section FR-Histoire-de-la-maladie-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.4) créée par l'ANS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de la section FR-Histoire-de-la-maladie-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.4) créée par l'ANS</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.3.4&#34;]"
                 priority="1000"
                 mode="M99">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.3.4&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_historyOfPresentIllness.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10164-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historyOfPresentIllness.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '10164-2'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historyOfPresentIllness.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:text)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historyOfPresentIllness.sch] Erreur de conformité CI-SIS : Cette section doit contenir un élément 'text'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M99"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M99"/>
   <xsl:template match="@*|node()" priority="-2" mode="M99">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M99"/>
   </xsl:template>

   <!--PATTERN S_examenPhysiqueOculaireVérification de la conformité de la section FR-Examen-physique-oculaire aux spécification IHE EYE CARE GEE (Ocular Physical Exam)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de la section FR-Examen-physique-oculaire aux spécification IHE EYE CARE GEE (Ocular Physical Exam)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.2.5&#34;]" priority="1000"
                 mode="M100">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.2.5&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_examenPhysiqueOculaire] Erreur de conformité IHE Eye Care GEE : Ce template ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;70948-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_examenPhysiqueOculaire] Erreur de conformité IHE Eye Care GEE : Le code de la section FR-Examen-physique-oculaire doit être "70948-5".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_examenPhysiqueOculaire] Erreur de conformité IHE Eye Care GEE : L'élément 'codeSystem' de la section FR-Examen-physique-oculaire 
            doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_examenPhysiqueOculaire] Erreur de conformité IHE Eye Care GEE : La section FR-Examen-physique-oculaire doit avoir un élément "id".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M100"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M100"/>
   <xsl:template match="@*|node()" priority="-2" mode="M100">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M100"/>
   </xsl:template>

   <!--PATTERN S_mesureDeLaRefractionVérification de la conformité de la section FR-Mesure-de-la-refraction aux spécification IHE EYE CARE GEE (Refractive Measurements)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de la section FR-Mesure-de-la-refraction aux spécification IHE EYE CARE GEE (Refractive Measurements)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.2.9&#34;]" priority="1000"
                 mode="M101">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.2.9&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : Ce template ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;70938-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : Le code de la section FR-Mesure-de-la-refraction doit être "70938-6".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : L'élément 'codeSystem' de la section FR-Mesure-de-la-refraction 
            doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.12.1.3.3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : La section 'FR-Mesure-de-la-refraction' doit contenir une entrée 'FR-Liste-des-mesures-de-refraction'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.12.1.3.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : La section 'FR-Mesure-de-la-refraction' doit contenir une entrée 'FR-Liste-des-mesures-acuite-visuelle'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M101"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M101"/>
   <xsl:template match="@*|node()" priority="-2" mode="M101">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M101"/>
   </xsl:template>

   <!--PATTERN S_analyseDesDispositifsOculairesVérification de la conformité de la section FR-Analyse-des-dispositifs-oculaires aux spécification IHE EYE CARE GEE (Lensometry Measurements)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de la section FR-Analyse-des-dispositifs-oculaires aux spécification IHE EYE CARE GEE (Lensometry Measurements)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.2.10&#34;]" priority="1000"
                 mode="M102">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.2.10&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : Ce template ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;70939-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : Le code de la section FR-Analyse-des-dispositifs-oculaires doit être "70939-4".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : L'élément 'codeSystem' de la section FR-Analyse-des-dispositifs-oculaires 
            doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : La section FR-Analyse-des-dispositifs-oculaires doit avoir un élément "id".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:entry/cda:organizer/cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.12.1.3.5&#34;])&gt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : La section 'FR-Analyse-des-dispositifs-oculaires' doit avoir au minimum une entrée FR-Liste-des-mesures-de-dispositifs-oculaires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M102"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M102"/>
   <xsl:template match="@*|node()" priority="-2" mode="M102">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M102"/>
   </xsl:template>

   <!--PATTERN S_bilanOphtalmologiqueVérification de la conformité de la section FR-Bilan-ophtalmologique aux spécification IHE EYE CARE GEE (Routine Eye Exam)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de la section FR-Bilan-ophtalmologique aux spécification IHE EYE CARE GEE (Routine Eye Exam)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.2.6&#34;]" priority="1000"
                 mode="M103">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.2.6&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : Ce template ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10197-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : Le code de la section FR-Bilan-ophtalmologique doit être "10197-2".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : L'élément 'codeSystem' de la section FR-Bilan-ophtalmologique
            doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : La section FR-Bilan-ophtalmologique doit avoir un élément "id".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.12.1.2.6&#34;])&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : La section 'FR-Bilan-ophtalmologique' peut contenir [0..1] sous-section 'FR-Mesure-de-la-refraction'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root =&#34;1.3.6.1.4.1.19376.1.12.1.2.10&#34;])&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : La section 'FR-Bilan-ophtalmologique' peut contenir [0..1] sous-section 'FR-Analyse-des-dispositifs-oculaires'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M103"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M103"/>
   <xsl:template match="@*|node()" priority="-2" mode="M103">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M103"/>
   </xsl:template>

   <!--PATTERN E_allergiesAndIntoleranceConcern_intIHE PCC v3.0 Allergies and Intolerance Concern-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Allergies and Intolerance Concern</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.3']"
                 priority="1000"
                 mode="M104">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.3']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = &#34;2.16.840.1.113883.10.20.1.27&#34;] and             cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntoleranceConcern_int] Erreur de Conformité PCC: Les déclarations de conformité aux templates des parents 
            CCD 'Problem Act' (2.16.840.1.113883.10.20.1.27) 
            et PCC 'Concern Entry' (1.3.6.1.4.1.19376.1.5.3.1.4.5.1) sont requises pour l'entrée 'Allergy and Intolerance Concern'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntoleranceConcern_int] Erreur de conformité PCC : Dans l'élément "allergies And Intolerance Concern", il doit y avoir au minimum trois templateIds
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:entryRelationship[@typeCode=&#34;SUBJ&#34;]//cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            
            [E_allergiesAndIntoleranceConcern_int] Erreur de Conformité PCC: Cette entrée 'Allergy and Intolerance Concern' doit contenir une ou plusieurs entrées se conformant
            au template de l'entrée 'Allergy and Intolerance' (1.3.6.1.4.1.19376.1.5.3.1.4.6).
            Ces entrées sont reliées à l'entrée 'Allergy and Intolerance Concern' par des éléments entryRelationshipdont les attributs 
            'typeCode' et 'inversionInd' prendront respectivement les valeurs 'SUBJ' et 'false'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M104"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M104"/>
   <xsl:template match="@*|node()" priority="-2" mode="M104">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M104"/>
   </xsl:template>

   <!--PATTERN E_allergiesAndIntolerances_intIHE PCC v3.0 Allergies and Intolerances-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Allergies and Intolerances</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]" priority="1000"
                 mode="M105">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode=&#34;OBS&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_AllergiesAndIntolerances_int] Erreur de Conformité PCC: Une entrée 'Allergies and intolerances' est un type particulier 
            de problème et sera de la même manière représentée comme une élément de type 'observation' 
            avec un attribut classCode='OBS'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntolerances_int] Erreur de Conformité PCC: Le template de l'entrée 'Allergies and intolerances' spécialise le template 
            de l'entrée 'Problem Entry'. A ce titre, le templateId de ce dernier (1.3.6.1.4.1.19376.1.5.3.1.4.5) sera déclaré.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntolerances_int] Erreur de conformité PCC : Dans l'élément "Allergies and intolerances", il doit y avoir au moins trois templateIds
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
            [E_allergiesAndIntolerances_int] Erreur de Conformité PCC: L'élément 'code' de l'entrée 'Allergies and Intolerances' indique le 
            type d'allergie provoqué (par un médicament, un facteur environnemental ou un aliment), 
            s'il s'agit d'une allergie, d'une intolérance sans manifestation allergique, ou encore un
            type inconnu de réaction (ni allergique, ni intolérance).
            L'élément 'code' doit obligatoirement comporter les attributs 'code' et 'codeSystem'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:value[@xsi:type=&#34;CD&#34;]) and              (cda:value[@code and @codeSystem] or cda:value[not(@code) and not(@codeSystem)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_allergiesAndIntolerances_int] Erreur de Conformité PCC: L'élément 'value' décrit l'allergie ou la réaction adverse observée. 
            Alors que l'élément 'value' peut être un caractère codé ou non, son type sera 
            toujours 'coded value' (xsi:type='CD'). 
            Dans le cas de l'utilisation d'un code, les attributs les attributs 'code' et 'codeSystem'seront présents, 
            et dans le cas contraire, tout autre attribut que xsi:type='CD' seront absents.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M105"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M105"/>
   <xsl:template match="@*|node()" priority="-2" mode="M105">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M105"/>
   </xsl:template>

   <!--PATTERN E_autorisationSubstitution_intIHE PHARM PRE Entrée FR-Autorisation-substitution-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PHARM PRE Entrée FR-Autorisation-substitution</svrl:text>

	  <!--RULE -->
<xsl:template match="//cda:entryRelationship[@typeCode='COMP']/cda:act[@classCode='ACT'][@moodCode='DEF']"
                 priority="1000"
                 mode="M106">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:entryRelationship[@typeCode='COMP']/cda:act[@classCode='ACT'][@moodCode='DEF']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_autorisationSubstitution_int.sch] Erreur de conformité IHE PRE : 
                L'entrée FR-Autorisation-substitution doit avoir un 'templateId' @root="1.3.6.1.4.1.19376.1.9.1.3.9.1".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:code[@code][@codeSystem='2.16.840.1.113883.5.1070'])=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_autorisationSubstitution_int.sch] Erreur de conformité IHE PRE : 
                L'entrée FR-Autorisation-substitution doit comporter un élément 'code'. 
                Les attributs @code et @codeSystem sont obligatoires et doivent être issus du JDV_HL7_ActSubstanceAdminSubstitutionCode-CISIS (2.16.840.1.113883.5.1070).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:statusCode[@code='completed'])=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [3] [E_autorisationSubstitution_int.sch] Erreur de conformité IHE PRE :  
                L'entrée FR-Autorisation-substitution doit comporter un élément 'statusCode' et son attribut @code="completed". 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M106"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M106"/>
   <xsl:template match="@*|node()" priority="-2" mode="M106">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M106"/>
   </xsl:template>

   <!--PATTERN E_birthEventOrganizer_int-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2&#34;]"
                 priority="1000"
                 mode="M107">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode='CLUSTER' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_int] : L'entrée FR-Naissance est un cluster d'observations à propos d'un événement d'accouchement.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_int] Dans l'entrée FR-Naissance, un élément "id" doit obligatoirement être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_int] Dans l'entrée FR-Naissance, un élément "code" doit obligatoirement être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:subject[@typeCode='SBJ']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_int] : L'entrée FR-Naissance doit contenir un élément "subject" pour décrire le nouveau né
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_birthEventOrganizer_int] : L'entrée FR-Naissance doit contenir au moins un élément component de type FR-Observation-sur-la-grossesse
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--REPORT -->
<xsl:if test="(cda:component/cda:observation/cda:templateId[@root!='1.3.6.1.4.1.19376.1.5.3.1.4.13.5' and @root!='1.3.6.1.4.1.19376.1.5.3.1.4.13' and @root!='1.2.250.1.213.1.1.3.53'])">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="(cda:component/cda:observation/cda:templateId[@root!='1.3.6.1.4.1.19376.1.5.3.1.4.13.5' and @root!='1.3.6.1.4.1.19376.1.5.3.1.4.13' and @root!='1.2.250.1.213.1.1.3.53'])">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_birthEventOrganizer_int] : L'entrée FR-Naissance ne doit pas contenir d'éléments component de type autre que FR-Observation-sur-la-grossesse
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M107"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M107"/>
   <xsl:template match="@*|node()" priority="-2" mode="M107">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M107"/>
   </xsl:template>

   <!--PATTERN E_bloodTypeObservation_intIHE PCC v3.0 vital signs Organizer-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 vital signs Organizer</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.6']"
                 priority="1000"
                 mode="M108">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.6']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC :  L'élément blood Type Observation est un fils de l'élément simple Observation, il doit donc avoir son templateId fixé à la valeur @root ='1.3.6.1.4.1.19376.1.5.3.1.4.13'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.31']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC :  L'élément blood Type Observation doit contenir un templateId avec la l'attribut @root fixé à '2.16.840.1.113883.10.20.1.31'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC : L'élément blood Type Observation doit contenir au minimum trois éléments templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code='882-1' and @codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC : L'élément blood Type Observation doit contenir un élément code avec les attributs suivant : 
            @code='882-1' 
            @displayName='ABO+RH GROUP' 
            @codeSystem='2.16.840.1.113883.6.1' 
            @codeSystemName='LOINC'      
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value[@xsi:type='CE']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC : L'élément blood Type Observation doit contenir un élément value de type CE (@xsi:type='CE')
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M108"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M108"/>
   <xsl:template match="@*|node()" priority="-2" mode="M108">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M108"/>
   </xsl:template>

   <!--PATTERN E_codedAntenatalTestingAndSurveillanceOrg_intIHE PCC v3.0 Coded Antenatal Testing and Surveillance Organizer-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Coded Antenatal Testing and Surveillance Organizer</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10&#34;]"
                 priority="1000"
                 mode="M109">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:organizer"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_codedAntenatalTestingAndSurveillanceOrg_int] Erreur de Conformité PCC: 'Conformité PCC v3.0 (Erreur):' ne peut être utilisé que comme organizer.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code=&#34;XX-ANTENATALTESTINGBATTERY&#34; and              @displayName=&#34;ANTENATAL TESTING AND SURVEILLANCE BATTERY&#34; and             @codeSystem=&#34;2.16.840.1.113883.6.1&#34; and             @codeSystemName=&#34;LOINC&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_codedAntenatalTestingAndSurveillanceOrg_int] L'élément &lt;code&gt; de l'organizer "Antenatal Testing and Surveillance"est requis, et 
            identifie celui-ci comme un organizer contenant des données de test et de surveillance: &lt;code code='XX-ANTENATALTESTINGBATTERY'
            displayName='ANTENATAL TESTING AND SURVEILLANCE BATTERY' codeSystem='2.16.840.1.113883.6.1' codeSystemName="LOINC"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component/cda:observation/cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_codedAntenatalTestingAndSurveillanceOrg_int] L'élément 'Coded Antenatal Testing and Surveillance Organizer' doit 
            au moins contenir une entrée 'Simple Observation' (1.3.6.1.4.1.19376.1.5.3.1.4.13)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_codedAntenatalTestingAndSurveillanceOrg_int] "Coded Antenatal Testing and Surveillance Organizer" aura nécessairement un identifiant &lt;id&gt;.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code=&#34;completed&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_codedAntenatalTestingAndSurveillanceOrg_int] La valeur de l'élément "statusCode" de "Coded Antenatal Testing and Surveillance Organizer" est fixée à "completed".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M109"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M109"/>
   <xsl:template match="@*|node()" priority="-2" mode="M109">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M109"/>
   </xsl:template>

   <!--PATTERN E_comments_intIHE PCC Comments-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Comments</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.2&#34;]" priority="1000"
                 mode="M110">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_comments_int] Erreur de Conformité PCC: Le templateId CCD (2.16.840.1.113883.10.20.1.40) de l'entrée
                Comments doit être déclaré.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code=&#34;48767-8&#34; and                 @codeSystem=&#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_comments_int] Erreur de Conformité PCC: L'élément "code" pour l'entrée "Comments" est requis. Ses attributs "code" et "codeSystem"
                sont obligatoires (cf. CI-SIS Volet de contenu CDA).
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
                [E_comments_int] Erreur de Conformité PCC: La valeur de l'élément "code" de "statusCode" est toujours fixée à "completed". 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:author) or (                 cda:author/cda:time and                 cda:author/cda:assignedAuthor/cda:id and                 cda:author/cda:assignedAuthor/cda:addr and                 cda:author/cda:assignedAuthor/cda:telecom and                 cda:author/cda:assignedAuthor/cda:assignedPerson/cda:name and                 cda:author/cda:assignedAuthor/cda:representedOrganization/cda:name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_comments_int] Erreur de Conformité PCC: Un élément "Comment" peut avoir un auteur.
                L'horodatage de la création de l'élément "Comment" est réalisé à partir de l'élément "time" lorsque l'élément "author" est présent.
                L'identifiant de l'auteur (id), son adresse (addr) et son numéro de téléphone (telecom) sont dans ce cas obligatoires. 
                Le nom de l'auteur et/ou celui de l'organisation qu'il représente doit être présent.
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
                [E_comments_int] Erreur de Conformité PCC (Alerte): L'élément "observation" d'une entrée "Comments" contiendra un composant "text"
                Celui-ci contiendra un élément "reference" qui pointera sur la partie narrative où est notifiée le commentaire, plutôt 
                que de dupliquer ce texte.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M110"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M110"/>
   <xsl:template match="@*|node()" priority="-2" mode="M110">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M110"/>
   </xsl:template>

   <!--PATTERN E_concernEntry_intIHE PCC v3.0 Concern Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Concern Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.1&#34;]"
                 priority="1000"
                 mode="M111">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.1&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:act"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int]  L'entrée "Etat clinique" (Concern Entry) ne peut être utilisée que comme un élément de type "act".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:act[@classCode=&#34;ACT&#34;] and ../cda:act[@moodCode=&#34;EVN&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Une entrée "Etat clinique" (Concern Entry) est un acte ("act classCode='ACT'") qui consiste 
                à enregistrer un événement (moodCode='EVN') relatif à un problème, une allergie ou tout autre élément se rapportant
                à l'état clinique d'un patient.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Le templateId "2.16.840.1.113883.10.20.1.27" indique que l'entrée "Etat clinique" (Concern Entry) se conforme 
                au modèle HL7 CCD "problem acts".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;=2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Erreur de conformité PCC : Dans une entrée "Etat clinique" (Concern Entry), il doit y avoir au moins deux templateId.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), il doit y avoir un élément "id".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@nullFlavor=&#34;NA&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), l'élément "code" prend la valeur nullFlavor='NA'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code=&#34;active&#34; or                  @code=&#34;suspended&#34; or                 @code=&#34;aborted&#34; or                 @code=&#34;completed&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), l'élément "statusCode" doit prendre l'une des valeurs suivantes : 
                "active", "suspended", "aborted" ou "completed".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:effectiveTime[@nullFlavor])or(cda:effectiveTime/cda:low)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), l'élément "effectiveTime" indique le début et la fin de l'élément décrit. 
                Une valeur nullFlavor est acceptée. Autrement, son composant "low" est obligatoire.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:effectiveTime[@nullFlavor]) or ((cda:statusCode[@code=&#34;completed&#34; or @code=&#34;aborted&#34;] and cda:effectiveTime/cda:high) or                 (cda:statusCode[@code=&#34;active&#34; or @code=&#34;suspended&#34;] and not(cda:effectiveTime/cda:high)))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), l'élément "effectiveTime" indique le début et la fin de l'élément décrit.
                Une valeur nullFlavor est acceptée. Autrement, son composant "high" est obligatoire si le statutCode est "completed" ou "aborted" et absent si le statutCode est "active" ou "suspended".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:entryRelationship[@typeCode=&#34;SUBJ&#34;] and cda:entryRelationship/*/cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34; or @root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]) or                   (cda:sourceOf[@typeCode=&#34;SUBJ&#34; and @inversionInd=&#34;false&#34;] and cda:sourceOf/*/cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34; or @root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.6&#34;]) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_concernEntry_int] Une entrée "Etat clinique" (Concern Entry), permet de décrire une liste de problèmes ou une liste d'allergies.  et de regrouper. 
                Cette entrée regroupe, à l'aide d'entryRelationship ayant des attributs typeCode='SUBJ' et inversionInd='false', 
                une ou plusieurs entrées "Problème" ("1.3.6.1.4.1.19376.1.5.3.1.4.5") ou "Allergie ou intolerance" ("1.3.6.1.4.1.19376.1.5.3.1.4.6").
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M111"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M111"/>
   <xsl:template match="@*|node()" priority="-2" mode="M111">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M111"/>
   </xsl:template>

   <!--PATTERN E_encounter_intIHE PCC v3.0 Encounter - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Encounter - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.14']"
                 priority="1000"
                 mode="M112">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.14']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='ENC'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", l'attribut "classCode" sera fixé à la valeur "ENC". 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(@moodCode='EVN') and cda:templateId[@root='2.16.840.1.113883.10.20.1.25']) or (@moodCode='EVN' and cda:templateId[@root='2.16.840.1.113883.10.20.1.21'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", le templateId indique que cet élément 
            se conforme aux contraintes de ce module de contenu.
            NOTE: Lorsque l'entrée "Encounter" est en mode événement (moodCode='EVN'), elle se conforme au template CCD 2.16.840.1.113883.10.20.1.21.
            Dans les autres modes, elle se conforme au template CCD 2.16.840.1.113883.10.20.1.25. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_encounter_int] : Erreur de conformité PCC : Dans une entrée "Encounter", il doit y avoir au minimum deux templateId.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", l'élément "id" est obligatoire. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_encounter_int] Erreur de conformité PCC : L'élément 'text' doit être présent avec un élément 'reference' qui contient une URI dans un attribut @value.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(@moodCode = 'EVN' or @moodCode = 'APT') or cda:effectiveTime"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", l'élément "effectiveTime" 
            horodate l'événement (en mode EVN), ou la date désirée pour la rencontre (en mode ARQ or APT).
            En mode EVN ou APT, l'élément "effectiveTime" sera présent. En mode ARQ, l'élément "effectiveTime" 
            pourra être présent, mais si la date n'est pas présente, l'élément "priorityCode" coit être présent  
            pour indiquer qu'un rappel est nécessaire pour fixer la date de rendez-vous pour la rencontre. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:participant[@typeCode='LOC']) or                  cda:participant[@typeCode='LOC']/cda:participantRole[@classCode='SDLOC']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", un élément "participant" avec un attribut @typeCode='LOC' pourra être présent pour indiquer le lieu de la rencontre. 
            Cet élément aura un élément "participantRole" avec un attribut classCode='SDLOC' décrivant la localisation du service. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:particpant[@typeCode='LOC']) or                 cda:participant[@typeCode='LOC']/cda:playingEntity[@classCode='PLC']/cda:name"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", un élément "participant" avec un attribut @typeCode='LOC' 
            désignera un élément "playingEntity" avec son nom. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M112"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M112"/>
   <xsl:template match="@*|node()" priority="-2" mode="M112">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M112"/>
   </xsl:template>

   <!--PATTERN E_familyHistoryObservation_intIHE PCC Family History Observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Family History Observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.3&#34;]"
                 priority="1000"
                 mode="M113">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.3&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;] and              cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_int] : L'élément "Family History Observations" spécialise "Simple Observation" 
            et hérite ses contraintes de CCD. Il incluera deux template IDs additionnels : 
            1.3.6.1.4.1.19376.1.5.3.1.4.13 et 2.16.840.1.113883.10.20.1.22.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_int] Erreur de conformité PCC : Dans l'élément "Procedure Entry", il doit y avoir au minimum trois templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryObservation_int] : L'élément code doit être présent.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M113"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M113"/>
   <xsl:template match="@*|node()" priority="-2" mode="M113">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M113"/>
   </xsl:template>

   <!--PATTERN E_familyHistoryOrganizer_intIHE PCC Family History Organizer - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Family History Organizer - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.15&#34;]"
                 priority="1000"
                 mode="M114">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.15&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@moodCode=&#34;EVN&#34; and @classCode=&#34;CLUSTER&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int]: Les attributs moodCode et classCode de l'élément organizer doivent être respectivement 'EVN' et 'CLUSTER' </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur PCC : l'élément template du parent CCD 
            doit être présent (2.16.840.1.113883.10.20.1.23).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur de conformité PCC : Dans l'élément "Procedure Entry", il doit y avoir au minimum deux templateIds
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:subject[@typeCode=&#34;SBJ&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur PCC: L'élément "subject" élément doit être présent avec un attribut typeCode="SUBJ"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:subject/cda:relatedSubject[@classCode=&#34;PRS&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur PCC: L'élément "subject" contiendra un élément "relatedSubject"
            qui identifie les relations personnelles du patient (classCode='PRS').
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:subject/cda:relatedSubject[@classCode=&#34;PRS&#34;]/cda:code[@code and @codeSystem=&#34;2.16.840.1.113883.5.111&#34;] or cda:subject/cda:relatedSubject[@classCode=&#34;PRS&#34;]/cda:code[@nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur PCC : L'élément "code" de relatedSubject sera présent et donne 
            le lien entre l'élément "subject" au  patient. L'attribut @code sera présent et contiendra une valeur du vocabulaire HL7 FamilyMember.
            L'attribut "codeSystem" prendra la valeur 2.16.840.1.113883.5.111.
            Le nullFlavor est autorisé
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:participant) or cda:participant/cda:participantRole[@classCode=&#34;PRS&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur PCC : Un élément participant doit contenir un élément participantRole identifiant
            la relation de l'élément "subject" aux autres membres de la famille (classCode='PRS').
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:participant) or              cda:participant/cda:participantRole[@classCode=&#34;PRS&#34;]/cda:code[@code and @codeSystem=&#34;2.16.840.1.113883.5.111&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur PCC :  L'élément "code" sera présent et identifie le lien entre le participant et l'élément "subject".
            L'attribut @code sera présent et contiendra une valeur du vocabulaire HL7 FamilyMember. l'attribut @codeSystem sera présent
            et prendra la valeur "2.16.840.1.113883.5.111". 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:participant) or             cda:participant/cda:participantRole[@classCode=&#34;PRS&#34;]/cda:playingEntity[@classCode=&#34;PSN&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur PCC : L'élément "playingEntity" est présent et identifie la relation.
            Il prendra la valeur &lt;playingEntity classCode='PSN'&gt;.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:component[@typeCode=&#34;COMP&#34;]/cda:observation/cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_familyHistoryOrganizer_int] Erreur PCC : L'organizer Family History contient un ou plusieurs éléments component avec un typeCode fixé à "COMP". 
            Ces éléments se conforment au template "Family History Observation".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M114"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M114"/>
   <xsl:template match="@*|node()" priority="-2" mode="M114">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M114"/>
   </xsl:template>

   <!--PATTERN E_healthStatusObservation_intIHE PCC health Status Observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC health Status Observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2']"
                 priority="1000"
                 mode="M115">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../../cda:entryRelationship[@typeCode=&#34;REFR&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_healthStatusObservation_int] Erreur de Conformité PCC: Une entrée FR-Statut-clinique-du-patient est représentée comme une élément de type 'observation' 
            avec un attribut typeCode='REFR'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_healthStatusObservation_int] Erreur de conformité PCC : Dans l'entrée FR-Statut-clinique-du-patient, le format de base utilisé pour 
            représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
            signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer que l'événement a déjà eu lieu. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_healthStatusObservation_int] Erreur de conformité PCC : Le templateId parent (2.16.840.1.113883.10.20.1.51) doit être présent.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_healthStatusObservation_int] Erreur de conformité PCC : Dans l'entrée FR-Statut-clinique-du-patient, il doit y avoir au minimum deux templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code=&#34;11323-3&#34; and @codeSystem=&#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_healthStatusObservation_int] Erreur de Conformité PCC: L'élément 'code' de l'entrée FR-Statut-clinique-du-patient indique la 
            sévérité de l'allergie provoquée.
            L'élément 'code' doit obligatoirement comporter les attributs 'code' et 'codeSystem'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_healthStatusObservation_int] Erreur de conformité PCC : L'élément 'text' doit être présent avec un élément reference qui contient une URI dans l'attribut @value
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
            [E_healthStatusObservation_int] Erreur de conformité PCC : Le composant "statutCode" d'une entrée FR-Statut-clinique-du-patien sera toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value[@xsi:type=&#34;CE&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_healthStatusObservation_int] Erreur de conformité PCC : Dans l'entrée FR-Statut-clinique-du-patient, l'élément 'value' signale le statut clinique.
            Il est toujours représenté utilisant le datatype 'CE' (xsi:type='CE') 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M115"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M115"/>
   <xsl:template match="@*|node()" priority="-2" mode="M115">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M115"/>
   </xsl:template>

   <!--PATTERN E_immunizations_intIHE PCC v3.0 Immunizations Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Immunizations Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.12']"
                 priority="1000"
                 mode="M116">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.12']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@negationInd=&#34;true&#34; or @negationInd=&#34;false&#34;) and @classCode=&#34;SBADM&#34; and (@moodCode=&#34;EVN&#34; or @moodCode=&#34;INT&#34;)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Dans une entrée 'Immunization', l'attribut negationInd doit prendre la valeur 'true' (la vaccination n'a pas eu lieu) ou la valeur 'false' (la vaccination a eu lieu).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Dans une entrée 'Immunization', l'OID du template CCD parent (2.16.840.1.113883.10.20.1.24) est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Une entrée 'Immunization' doit comporter au minimum deux templateId (cardinalité [2..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_int.sch] Erreur de Conformité PCC :  
            Dans une entrée 'Immunization', l'élément 'id' (identifiant de l'entrée) est obligatoire.
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
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Dans une entrée 'Immunization', l'élément 'code' (type de vaccination) est obligatoire. Les attributs 'code' et 'codeSystem' sont obligatoires. 
            Le type de vaccination permet de préciser s'il s'agit d'un primo-vaccination ou d'un rappel. Si l'information n'est pas connue, utiliser le code='IMMUNIZ' (vaccination sans autre précision).             
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code=&#34;completed&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Dans une entrée 'Immunization', l'élément 'statusCode' est obligatoire et doit prendre la valeur 'completed'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime[@value or @nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_int.sch] Erreur de Conformité PCC :            
            Dans une entrée 'Immunization', l'élément 'effectiveTime' est obligatoire.
            Il permet d'indiquer la date de la vaccination. Si la date est inconnue, utiliser l'attribut nullFlavor="UNK".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:consumable//cda:manufacturedProduct//cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_immunizations_int.sch] Erreur de Conformité PCC :  
            Dans une entrée 'Immunization', l'élément 'consumable' est obligatoire.
            Il doit comporter une entrée 'manufacturedProduc' conforme au template 'Product Entry template' (1.3.6.1.4.1.19376.1.5.3.1.4.7.2).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M116"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M116"/>
   <xsl:template match="@*|node()" priority="-2" mode="M116">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M116"/>
   </xsl:template>

   <!--PATTERN E_instructionsDispensateur_intIHE PCC Entrée FR-Instructions-au-dispensateur (Medication-Fulfillment-Instruction)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Entrée FR-Instructions-au-dispensateur (Medication-Fulfillment-Instruction)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']"
                 priority="1000"
                 mode="M117">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']"/>
      <xsl:variable name="count_code"
                    select="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]/cda:code[@code='FINSTRUCT'][@codeSystem='1.3.6.1.4.1.19376.1.5.3.2'])"/>
      <xsl:variable name="count_text"
                    select="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]/cda:text)"/>
      <xsl:variable name="count_reference"
                    select="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]/cda:text/cda:reference)"/>
      <xsl:variable name="count_statusCode"
                    select="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]/cda:statusCode[@code='completed'])"/>
      <xsl:variable name="count_ER_InstructDispensateur"
                    select="count(//self::cda:entryRelationship[cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.43']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_instructionsDispensateur_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-dispensateur doit avoir deux 'templateId' :
                - Un premier 'templateId' @root="1.3.6.1.4.1.19376.1.5.3.1.4.3.1"
                - Un deuxième 'templateId' @root="2.16.840.1.113883.10.20.1.43"
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_code=$count_ER_InstructDispensateur)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_instructionsDispensateur_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-dispensateur doit comporter un élément 'code' et ses attribut @code="PINSTRUCT" et @codeSystem="1.3.6.1.4.1.19376.1.5.3.2".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_text=$count_ER_InstructDispensateur) and ($count_reference=$count_ER_InstructDispensateur))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [3] [E_instructionsDispensateur_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-dispensateur doit comporter un élément 'text/reference'.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_statusCode=$count_ER_InstructDispensateur)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [4] [E_instructionsDispensateur_int.sch] Erreur de conformité IHE PCC :  
                L'entrée FR-Instructions-au-dispensateur doit comporter un élément 'statusCode' et son attribut @code="completed". 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M117"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M117"/>
   <xsl:template match="@*|node()" priority="-2" mode="M117">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M117"/>
   </xsl:template>

   <!--PATTERN E_instructionsPatient_intIHE PCC Entrée FR-Instructions-au-patient-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Entrée FR-Instructions-au-patient</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']" priority="1000"
                 mode="M118">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']"/>
      <xsl:variable name="count_code"
                    select="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']]/cda:code[@code='PINSTRUCT'][@codeSystem='1.3.6.1.4.1.19376.1.5.3.2'])"/>
      <xsl:variable name="count_text"
                    select="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']]/cda:text)"/>
      <xsl:variable name="count_reference"
                    select="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']]/cda:text/cda:reference)"/>
      <xsl:variable name="count_statusCode"
                    select="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']]/cda:statusCode[@code='completed'])"/>
      <xsl:variable name="count_ER_InstructPatient"
                    select="count(//self::cda:entryRelationship[cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']]])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.49']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_instructionsPatient_fr.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-patient doit avoir deux 'templateId' :
                - Un premier 'templateId' @root="1.3.6.1.4.1.19376.1.5.3.1.4.3"
                - Un deuxième 'templateId' @root="2.16.840.1.113883.10.20.1.49"
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_code=$count_ER_InstructPatient)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_instructionsPatient_fr.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-patient doit comporter un élément 'code' avec les attribut @code="PINSTRUCT" et @codeSystem="1.3.6.1.4.1.19376.1.5.3.2".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_text=$count_ER_InstructPatient) and ($count_reference=$count_ER_InstructPatient))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [3] [E_instructionsPatient_fr.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-patient doit comporter un élément 'text/reference'.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_statusCode=$count_ER_InstructPatient)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [4] [E_instructionsPatient_fr.sch] Erreur de conformité IHE PCC :  
                L'entrée FR-Instructions-au-patient doit comporter un élément 'statusCode' et son attribut @code="completed". 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M118"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M118"/>
   <xsl:template match="@*|node()" priority="-2" mode="M118">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M118"/>
   </xsl:template>

   <!--PATTERN E_itemPlanTraitement_intIHE MTP "Medication Treatment Plan Item Entry" (FR-Item-plan-traitement)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE MTP "Medication Treatment Plan Item Entry" (FR-Item-plan-traitement)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.7']" priority="1000"
                 mode="M119">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.7']"/>
      <xsl:variable name="count_id"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:id)"/>
      <xsl:variable name="count_routeCode"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:routeCode[@codeSystem='2.16.840.1.113883.5.112'])"/>
      <xsl:variable name="count_approachSiteCode"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:approachSiteCode[@codeSystem='2.16.840.1.113883.1.11.19724'])"/>
      <xsl:variable name="count_doseQuantity"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:doseQuantity)"/>
      <xsl:variable name="count_rateQuantity"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:rateQuantity)"/>
      <xsl:variable name="count_maxDoseQuantity"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:maxDoseQuantity)"/>
      <xsl:variable name="count_maxDoseQuantityNum"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:maxDoseQuantity/cda:numerator)"/>
      <xsl:variable name="count_maxDoseQuantityDenom"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:maxDoseQuantity/cda:denominator)"/>
      <xsl:variable name="count_effectiveTime"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:effectiveTime)"/>
      <xsl:variable name="count_MA_normales"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.1']])"/>
      <xsl:variable name="count_MA_progressives"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.8']])"/>
      <xsl:variable name="count_MA_fractionnees"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.9']])"/>
      <xsl:variable name="count_MA_conditionnees"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.10']])"/>
      <xsl:variable name="count_MA_combinees"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.11']])"/>
      <xsl:variable name="count_MA_debutDiff"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.21']])"/>
      <xsl:variable name="count_consumable"
                    select="count(//cda:entryRelationship/cda:substanceAdministration/cda:consumable/cda:manufacturedProduct[@classCode='MANU']/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2'])"/>
      <xsl:variable name="count_ER_MotifTraitement"
                    select="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1']])"/>
      <xsl:variable name="count_ER_TraitementPrescritSub"
                    select="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:sequenceNumber])"/>
      <xsl:variable name="count_ER_InstrucPatient"
                    select="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']])"/>
      <xsl:variable name="count_ER_InstructDispensateur"
                    select="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']])"/>
      <xsl:variable name="count_ER_QuantiteProduit"
                    select="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.8']])"/>
      <xsl:variable name="count_ER_AutorisationSubstitution"
                    select="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']])"/>
      <xsl:variable name="count_E_traitementPrescrit"
                    select="count(//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.24']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un templateId @root="2.16.840.1.113883.10.20.1.24".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter templateId @root="1.3.6.1.4.1.19376.1.5.3.1.4.7".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="                 (($count_MA_normales&gt;=1) and ($count_ER_TraitementPrescritSub=0) and ($count_effectiveTime=2*$count_E_traitementPrescrit)) or                 (($count_MA_progressives&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_effectiveTime=$count_E_traitementPrescrit)) or                 (($count_MA_fractionnees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_effectiveTime=$count_E_traitementPrescrit)) or                 (($count_MA_conditionnees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_effectiveTime=$count_E_traitementPrescrit)) or                 (($count_MA_combinees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_effectiveTime=$count_E_traitementPrescrit)) or                 (($count_MA_debutDiff&gt;=1) and ($count_ER_TraitementPrescritSub=0) and ($count_effectiveTime=2*$count_E_traitementPrescrit))                 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                
                [3] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un 'templateId' indiquant le mode d'administration choisi pour le traitement prescrit. Il doit être choisi parmi la liste suivante :
                
                1.3.6.1.4.1.19376.1.5.3.1.4.7.1  (Mode d'administration : doses normales). De ce fait : 
                - il ne peut pas y avoir d'entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une deuxième occurence de l'élément 'effectiveTime' est obligatoire dans l'entrée (pour décrire la fréquence d'administration).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.8    (Mode d'administration : doses progressives). De ce fait :
                - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une seule occurence de l'élément 'effectiveTime' dans l'entrée (la fréquence d'administration sera décrite dans la subordonnée).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.9    (Mode d'administration : doses fractionnées). De ce fait : 
                - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une seule occurence de l'élément 'effectiveTime' dans l'entrée (la fréquence d'administration sera décrite dans la subordonnée).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.10   (Mode d'administration : doses conditionnelles). De ce fait : 
                - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une seule occurence de l'élément 'effectiveTime' dans l'entrée (la fréquence d'administration sera décrite dans la subordonnée).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.11   (Mode d'administration : doses combinées). De ce fait :
                - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une seule occurence de l'élément 'effectiveTime' dans l'entrée (la fréquence d'administration sera décrite dans la subordonnée).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.21   (Mode d'administration : doses à début différé). De ce fait : 
                - il ne peut pas y avoir d'entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une deuxième occurence de l'élément 'effectiveTime' est obligatoire dans l'entrée (pour décrire la fréquence d'administration).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_id=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [4] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un élément 'id'.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:code)=1 and (                             (                                (count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'])=1 and not(cda:code[@displayName]) and not(cda:code[@codeSystemName]))                             or (count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'][@displayName='Médicament'])=1 and not(cda:code[@codeSystemName]))                             or (count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'][@codeSystemName='HL7:ActCode'])=1 and not(cda:code[@displayName]))                              )                             or count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'][@displayName='Médicament'][@codeSystemName='HL7:ActCode'])=1)                                                  ) or not(cda:code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [5] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement peut comporter un élément 'code', optionnel, qui doit avoir les attribut :
                - @code="DRUG" (cardinalité [1..1])
                - @codeSystem="2.16.840.1.113883.5.4" (cardinalité [1..1])
                - @displayName="Médicament" (cardinalité [0..1])
                - @codeSystemName="HL7:ActCode" (cardinalité [0..1])             
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:text/cda:reference)=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [6] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un élément 'test/reference'.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed'] and count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [7] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un élément 'statusCode', dont l'attribut @code est fixé à la valeur 'completed'.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_routeCode=1) or not(cda:routeCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [8] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                - L'élément optionnel 'routeCode' ne peut être présent plus d'une fois (cardinalité [0..1]), 
                - si présent, les valeurs de ses attributs doivent provenir du jeu de valeurs JDV_HL7_RouteOfAdministration-CISIS (2.16.840.1.113883.5.112).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_approachSiteCode&gt;=1) or not(cda:approachSiteCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [9] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                - L'élément optionnel 'approachSiteCode' ne peut être présent plus d'une fois (cardinalité [0..*]), 
                - si présent, les valeurs de ses attributs doivent provenir du jeu de valeurs JDV_HL7_HumanSubstanceAdministrationSite-CISIS (2.16.840.1.113883.1.11.19724).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_doseQuantity=1) or not(cda:doseQuantity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [10] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'élément optionnel 'doseQuantity' ne peut être présent plus d'une fois (cardinalité [0..1]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_rateQuantity=1) or not(cda:rateQuantity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [11] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'élément optionnel 'rateQuantity' ne peut être présent plus d'une fois (cardinalité [0..1]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_maxDoseQuantity&gt;=1) and ($count_maxDoseQuantityNum=$count_maxDoseQuantity) and ($count_maxDoseQuantityDenom=$count_maxDoseQuantity)) or ($count_maxDoseQuantity=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [12] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                - L'élément optionnel 'maxDoseQuantity' optionnel, peut être présent plusieurs fois (cardinalité [0..*])
                - Si présent, il doit comporter obligatoirement un élément fils 'numerator' [1..1] et un élément fils 'denominator' [1..1].
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_consumable=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [13] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un élément 'consumable' avec l'attribut @classCode="MANU".
                Il doit contenir une entrée de type 'manufacturedProduct' (Medicine entry" - 1.3.6.1.4.1.19376.1.5.3.1.4.7.2).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_MotifTraitement&gt;=1) or ($count_ER_MotifTraitement=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [14] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée optionnelle de type 'act' "IHE Internal Reference Entry" (Motif du traitement), si présente, doit avoir un templateId @root="1.3.6.1.4.1.19376.1.5.3.1.4.4.1".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_InstrucPatient=1) or ($count_ER_InstrucPatient=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [15] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée optionnelle "IHE Patient Medication Instructions" de type act, si présente, doit contenir un 'templateId' @root="1.3.6.1.4.1.19376.1.5.3.1.4.3".                
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_InstructDispensateur=1) or ($count_ER_InstructDispensateur=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [16] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée optionnelle "IHE Medication FulFillment Instructions" de type act, si présente, doit contenir :
                - un MTPmier 'templateId' dont l'attribut @root="2.16.840.1.113883.10.20.1.43" et
                - un deuxième 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.3.1".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_QuantiteProduit=1) or ($count_ER_QuantiteProduit=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [17] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée optionnelle "Amount of units of the consumable Content Module" de type supply, si présente, doit contenir un 'templateId' @root="1.3.6.1.4.1.19376.1.9.1.3.8".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_AutorisationSubstitution&gt;=1) or ($count_ER_AutorisationSubstitution=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [18] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                Si présente, l'entrée de type 'act' "Substitution Permission Content Module" doit avoir un templateId @root="1.3.6.1.4.1.19376.1.9.1.3.9.1".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M119"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M119"/>
   <xsl:template match="@*|node()" priority="-2" mode="M119">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M119"/>
   </xsl:template>

   <!--PATTERN E_laboratoryBatteryOrganizer_intIHE PaLM laboratory Battery Organizer-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PaLM laboratory Battery Organizer</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.1.4&#34;]" priority="1001"
                 mode="M120">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.1.4&#34;]"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='BATTERY' and @moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryBatteryOrganizer_int.sch] Erreur de conformité PaLM : L'élément organizer de laboratory battery organizer doit avoir les attributs @classCode et @moodCode fixés respectivement aux valeurs suivante 'BATTERY' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryBatteryOrganizer_int.sch] Erreur de conformité PaLM : L'élément laboratory battery organizer ne peut pas contenir plus d'un seul id (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed' or @code='aborted']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryBatteryOrganizer_int.sch] Erreur de conformité PaLM : L'élément laboratory battery organizer doit contenir un statusCode avec l'attribut @code quqi prend les valeurs 'completed' ou 'aborted'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M120"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1']/cda:act/cda:subject"
                 priority="1000"
                 mode="M120">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1']/cda:act/cda:subject"/>
      <xsl:variable name="count_adresse" select="count(cda:relatedSubject/cda:addr)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@typeCode='SBJ'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un attribut @typêCode fixé à la valeur 'SBJ' s'il est présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.1.2.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un templateId ayant la valeur @root = '1.3.6.1.4.1.19376.1.3.3.1.2.1'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:relatedSubject"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un relatedSubject
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:relatedSubject/cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément relatedSubject doit contenir un code
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_adresse=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément relatedSubject doit contenir une adresse (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M120"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M120"/>
   <xsl:template match="@*|node()" priority="-2" mode="M120">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M120"/>
   </xsl:template>

   <!--PATTERN E_laboratoryReportDataProcessing_intIHE PaLM laboratory Report Processing-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PaLM laboratory Report Processing</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.1&#34;]" priority="1001"
                 mode="M121">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.1&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:entry[@typeCode='DRIV']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément entry de laboratory report data processing doit avoir un attribut @typeCode fixé à la valeur 'DRIV'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:act[@classCode='ACT' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément act de laboratory report data processing doit être présent et posséder les attributs @classCode et @moodCode prenant respectivement les valeurs 'ACT' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:act/cda:statusCode[@code ='completed' or @code='active' or @code='aborted']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément statusCode doit être présent et possèder l'attribut @code prenant l'une des valeurs suivantes : completed, active ou aborted
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:act/cda:entryRelationship[@typeCode='COMP']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : l'entrée Laboratory Report Data processing doit contenir au moins une entryRelationship dont l'attribut @typeCode est fixé à 'COMP'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M121"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1']/cda:act/cda:subject"
                 priority="1000"
                 mode="M121">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1']/cda:act/cda:subject"/>
      <xsl:variable name="count_adresse" select="count(cda:relatedSubject/cda:addr)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@typeCode='SBJ'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un attribut @typêCode fixé à la valeur 'SBJ' s'il est présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.1.2.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un templateId ayant la valeur @root = '1.3.6.1.4.1.19376.1.3.3.1.2.1'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un templateId 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:relatedSubject"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un relatedSubject
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:relatedSubject/cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément relatedSubject doit contenir un code
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_adresse=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément relatedSubject doit contenir une adresse (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M121"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M121"/>
   <xsl:template match="@*|node()" priority="-2" mode="M121">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M121"/>
   </xsl:template>

   <!--PATTERN E_medications_intIHE PCC v3.0 Medications-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Medications</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]" priority="1000"
                 mode="M122">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='SBADM' and (@moodCode='INT' or @moodCode='EVN')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_int.sch] Erreur de conformité PCC : L'élément subastanceAdministration doit avoit un attribut @classCode fixé à 'SBADM' et un attribut @moodCode dont la valeur 
            est soit 'INT' ou 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = &#34;2.16.840.1.113883.10.20.1.24&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_medications_int.sch] Erreur de conformité PCC : L'entrée 'Medications' doit comporter un templateId "2.16.840.1.113883.10.20.1.24" ('CCD Medication activity').</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.7.1&#34;] |              cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.8&#34;] |             cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.9&#34;] |             cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.10&#34;] |             cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.11&#34;])  &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            
            [E_medications_int.sch] Erreur de conformité PCC : L'entrée 'Medications' doit comporter au minimum l'un des templateId suivants : 
            normal dosing (1.3.6.1.4.1.19376.1.5.3.1.4.7.1), tapered dosing (1.3.6.1.4.1.19376.1.5.3.1.4.8), 
            split dosing (1.3.6.1.4.1.19376.1.5.3.1.4.9), conditional dosing (1.3.6.1.4.1.19376.1.5.3.1.4.10), 
            combination dosing (1.3.6.1.4.1.19376.1.5.3.1.4.11).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.7.1&#34;]) or              count(.//cda:substanceAdministration) = 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_int.sch] Erreur de conformité PCC :  L'utilisation du template normal dosing (1.3.6.1.4.1.19376.1.5.3.1.4.7.1) 
            dans une entrée 'Medications' implique que l'élément 'substanceAdministration' ne comporte pas d'éléments 
            'substanceAdministration' subordonné.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_int.sch] Erreur de conformité PCC : un élément 'substanceAdministration' doit avoir un identifiant unique. Si l'éditeur de
            la source (LPS, SIH,...) n'a pas prévu celle-ci, on pourra lui substituer un GUID, utilisé pour l'attribut 'root',
            l'attribut 'extension' pouvant alors être omis.
            Note: même si HL7 admet qu'un élément puisse avoir plusieurs identifiants, cette entrée n'en utilisera qu'un, et un seul.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:text/cda:reference) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_int.sch] Erreur de conformité PCC : un élément 'substanceAdministration' doit avoir un élément 'text' unique contenant un élément 'reference'. </svrl:text>
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
            [E_medications_int.sch] Erreur de conformité PCC : l'élément 'statusCode' de tout élément 'substanceAdministration' d'une entrée 'Medications' 
            est obligatoirement fixé à la valeur 'completed': soit l'acte a été réalisé, soit la prescription a été faite.</svrl:text>
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
            [medications] L'élément 'consumable' doit obligatoirement être présent dans une entrée 'Medications'.
            Il comportera une entrée 'manufacturedProduct' se conformant au template 'Product Entry' (1.3.6.1.4.1.19376.1.5.3.1.4.7.2).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:effectiveTime[1]) or (cda:effectiveTime[1] and cda:effectiveTime[1][@xsi:type=&#34;IVL_TS&#34;]  and             ((cda:effectiveTime[1]/cda:low and cda:effectiveTime[1]/cda:high)) or cda:effectiveTime[1]/cda:width)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_int.sch] Erreur de conformité PCC : La première occurence de l'élément 'effectiveTime' doit être 
            un intervalle de temps s'il est présent, il sera spécifié comme tel (@xsi:type="IVL_TS").
            Les attributs 'low' et 'high' de cet élément représentent respectivement le début et la fin du tratement prescrit.
            Dans le cas spécifique où seule la durée du médicament est connue, le "low" et le "high" seront remplacés par l'élément "width"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:effectiveTime[2]) or (cda:effectiveTime[2] and cda:effectiveTime[2][@operator=&#34;A&#34; or @nullFlavor])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_medications_int.sch] Erreur de conformité PCC : La fréquence d'administration est requise si elle est connue. 
            Celle-ci sera un élément effectiveTime avec un attribut 'operator' égal à 'A'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M122"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M122"/>
   <xsl:template match="@*|node()" priority="-2" mode="M122">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M122"/>
   </xsl:template>

   <!--PATTERN E_observationRequest_intIHE PCC v3.0 Observation Request-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Observation Request</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1']"
                 priority="1000"
                 mode="M123">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='OBS'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'attribut "classCode" sera fixé à la valeur "OBS". </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@moodCode = 'INT' or @moodCode = 'PRP' or @moodCode = 'GOL'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "moodCode" 
            sera fixé à la valeur "INT" s'il s'agit d'une observation qui fait partie d'un plan de soins à accomplir,
            et il sera fixé à la valeur "PRP" quand l'observation est une proposition faite sur la base d'éléments
            cliniques.
            Dans le cas où l'observation est le but du plan de soins, l'élément "moodCode" sera fixé à la valeur "GOL".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_ObservationRequest_int] : Erreur de Conformité PCC: Cette entrée se conforme au template 2.16.840.1.113883.10.20.1.25 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_ObservationRequest_int] Erreur de conformité PCC : Il doit y avoir au minimum deux templateIds
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "id" est obligatoire. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "code" est obligatoire. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "text" contiendra
            une référence à la partie narrative. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code=&#34;active&#34;] or              cda:statusCode[@code=&#34;suspended&#34;] or             cda:statusCode[@code=&#34;aborted&#34;] or             cda:statusCode[@code=&#34;completed&#34;] or             cda:statusCode[@code=&#34;cancelled&#34;] or             cda:statusCode[@code=&#34;normal&#34;] or             cda:statusCode[@code=&#34;new&#34;] or             cda:statusCode[@code=&#34;held&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_ObservationRequest_int] :  L'élément "statusCode" associé à tout élément "observation request" doit prendre l'une des valeurs suivantes: 
            "active", "suspended", "aborted" ou "completed" ou "cancelled" ou "normal" ou "new" ou "held".</svrl:text>
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
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "effectiveTime" est obligatoire. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M123"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M123"/>
   <xsl:template match="@*|node()" priority="-2" mode="M123">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M123"/>
   </xsl:template>

   <!--PATTERN E_patientTransfer_intIHE PCC v3.0 Patient Transfer - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Patient Transfer - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&#34;]"
                 priority="1001"
                 mode="M124">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='ACT' and (@moodCode='INT' or @moodCode='EVN')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_patientTransfer_int] Erreur de conformité PCC : L'élément patientTransfer est un act, l'élément act doit contenir un attribut @classCode fixé à la valeur act et un attribut @moodCode prenant la valeur 'INT' ou 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:text) or (cda:text and cda:text/cda:reference/@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_patientTransfer_int] Erreur de conformité PCC : Si dans l'élément patientTransfer un élément text est présent, celui-ci doit contenir un élément 'reference' avec un attribut @value
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
            [E_patientTransfer_int] Erreur de conformité PCC : Le statut du transfert est obligatoire. l'attribut @code prend la valeur
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
            [E_patientTransfer_int] Erreur de conformité PCC : effectiveTime est obligatoire lorsque le transfert a eu lieu. 
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
            [E_patientTransfer_int] Erreur de conformité PCC : l'attribut @code prend la valeur @code='completed' si le transfert à eu lieu (moodCode='EVN'). </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M124"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&#34;]/cda:participant"
                 priority="1000"
                 mode="M124">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&#34;]/cda:participant"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@typeCode='DST'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_patientTransfer_int] Erreur de conformité PCC : L'élément participant contenu dans patientTransfert doit contenir l'attribut @typeCode fixé à la valeur 'DST'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_patientTransfer_int] Erreur de conformité PCC : L'élément participant contenu dans patientTransfert doit contenir un templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:participantRole/@classCode='SDLOC'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_patientTransfer_int] Erreur de conformité PCC : L'élément participant contenu dans patientTransfert doit contenir un élément 'participantRole' contenant un attribut @classCode dont la valeur est fixé à 'SDLOC'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:participantRole/cda:playingEntity) or ( cda:participantRole/cda:playingEntity and cda:participantRole/cda:playingEntity/@classCode='ENT')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_patientTransfer_int] Erreur de conformité PCC : Si l'élément participantRole contient un élément playingEntity, celui-ci doit contenir un attribut @classCode fixé à la valeur 'ENT'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:participantRole/cda:playingEntity) or ( cda:participantRole/cda:playingEntity and cda:participantRole/cda:playingEntity/cda:name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_patientTransfer_int] Erreur de conformité PCC : Si l'élément participantRole contient un élément playingEntity, celui-ci doit contenir un élément 'name'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M124"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M124"/>
   <xsl:template match="@*|node()" priority="-2" mode="M124">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M124"/>
   </xsl:template>

   <!--PATTERN E_periodeRenouvellement_intIHE PHARM PRE "Renewal Period"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PHARM PRE "Renewal Period"</svrl:text>

	  <!--RULE -->
<xsl:template match="//cda:entryRelationship[@typeCode='COMP']/cda:supply[@classCode='SPLY'][@moodCode='RQO']/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.15']"
                 priority="1000"
                 mode="M125">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:entryRelationship[@typeCode='COMP']/cda:supply[@classCode='SPLY'][@moodCode='RQO']/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.15']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:effectiveTime)=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_periodeRenouvellement_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Periode-de-renouvellement doit comporter un élément 'effectiveTime'.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:effectiveTime/cda:high) or (cda:effectiveTime/cda:width)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_periodeRenouvellement_int.sch] Erreur de conformité IHE Pharm PRE :  
                Dans l'entrée FR-Periode-de-renouvellement, l'élément 'effectiveTime' doit comporter soit un élément 'high' soit un élément 'width'. 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M125"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M125"/>
   <xsl:template match="@*|node()" priority="-2" mode="M125">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M125"/>
   </xsl:template>

   <!--PATTERN E_pregnancyHistoryOrganizer_intIHE PCC Pregnancy History Organizer (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Pregnancy History Organizer (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1&#34;]"
                 priority="1000"
                 mode="M126">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1&#34;]"/>
      <xsl:variable name="count_Comp_ObsGross"
                    select="count(//cda:component/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5'])"/>
      <xsl:variable name="count_Comp_naiss"
                    select="count(//cda:component/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2'])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode=&#34;CLUSTER&#34; and @moodCode=&#34;EVN&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse est un cluster d'entrées Pregnancy Observations.
            Les attributs classCode et moodCode doivent obligatoirement être respectivement égaux à "CLUSTER" et "EVN"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse doit comporter un identifiant "id".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse doit comporter un code "code" .
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
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse décrit l'observation d'un fait clinique. 
            Son composant "statutCode" sera donc toujours fixé à la valeur code='completed'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="count_statusCode" select="count(cda:statusCode)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_statusCode=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse ne peut avoir qu'un seul élément statusCode.
        </svrl:text>
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
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse doit comporter un élément "effectiveTime" .
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse doit comporter au moins un élément "component" pour représenter la personne ou le dispositif
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_Comp_ObsGross&gt;=0) and ($count_Comp_naiss&gt;=0) and ($count_Comp_ObsGross+$count_Comp_naiss&gt;=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC :
            Une entrée FR-Historique-de-la-grossesse doit contenir au moins une des deux entrées suivantes (cardinalité [1..*]) : 
            - [0..*] FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) et/ou
            - [0..*] FR-Naissance (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1']/cda:component/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5'])             + count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1']/cda:component/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2'])              = count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1']/cda:component))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC :
            Une entrée FR-Historique-de-la-grossesse doit comporter uniquement des entrées de type :
            - FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) ou 
            - FR-Naissance (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:component//cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2&#34;]) or (cda:component//cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2&#34;] and cda:component/cda:sequenceNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse comportant une entrée FR-Naissance (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2) doit contenir un élément "sequenceNumber".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M126"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M126"/>
   <xsl:template match="@*|node()" priority="-2" mode="M126">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M126"/>
   </xsl:template>

   <!--PATTERN E_pregnancyObservation_intIHE PCC Pregnancy Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Pregnancy Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']"
                 priority="1000"
                 mode="M127">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse doit comporter au minimum deux templateIds
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
       [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse doit comporter le templateId parent (1.3.6.1.4.1.19376.1.5.3.1.4.13).
    </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse comporte obligatoirement un élément "code".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--REPORT -->
<xsl:if test="cda:repeatNumber">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="cda:repeatNumber">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse ne doit pas comporter d'élément &lt;repeatNumber&gt;.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse comporte obligatoirement un élément "value".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--REPORT -->
<xsl:if test="cda:interpretationCode or cda:methodCode or cda:targetSiteCode">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="cda:interpretationCode or cda:methodCode or cda:targetSiteCode">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse ne doit pas comporter les éléments &lt;interpretationCode&gt;, 
         &lt;methodCode&gt;, and &lt;targetSiteCode&gt;.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M127"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M127"/>
   <xsl:template match="@*|node()" priority="-2" mode="M127">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M127"/>
   </xsl:template>

   <!--PATTERN E_problemConcernEntry_intIHE PCC v3.0 Problem Concern Entry - errors validation phase-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Problem Concern Entry - errors validation phase</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"
                 priority="1000"
                 mode="M128">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemConcernEntry_int] Problem Concern Entry a un template OID 1.3.6.1.4.1.19376.1.5.3.1.4.5.2. 
            Elle spécialise Concern Entry et doit donc se conformer à ses spécifications 
            en déclarant son template OID qui est 1.3.6.1.4.1.19376.1.5.3.1.4.5.1. Ces éléments 
            sont requis.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = &#34;2.16.840.1.113883.10.20.1.27&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemConcernEntry_int] Le template parent de Problem Concern est absent.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemConcernEntry_int] Erreur de conformité PCC : Dans l'élément "Problem Concern Entry", il doit y avoir au moins trois templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:act[@classCode=&#34;ACT&#34;] and ../cda:act[@moodCode=&#34;EVN&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemConcernEntry_int] une entrée "Concern Entry" est l'acte ("act classCode='ACT'") qui consiste 
            à enregistrer un événement (moodCode='EVN') relatif à un problème, une allergie ou tout autre élément se rapportant
            à l'état clinique d'un patient.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemConcernEntry_int] L'entrée "Problem Concern Entry" requiert un élément "id".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code=&#34;active&#34; or              @code=&#34;suspended&#34; or             @code=&#34;aborted&#34; or             @code=&#34;completed&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemConcernEntry_int] L'élément "statusCode" associé à tout élément concern doit prendre l'une des valeurs suivantes: 
            "active", "suspended", "aborted" ou "completed".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:effectiveTime[@nullFlavor])or(cda:effectiveTime/cda:low)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemConcernEntry_int] l'élément "effectiveTime" indique le début et la fin de la période durant laquelle l'élément "Concern Entry" était actif. 
            Son composant "low" ou un élément nullFlavor sera au moins présent.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:entryRelationship[@typeCode=&#34;SUBJ&#34;]/*/cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemConcernEntry_int] Tout élément "Problem Concern Entry" concerne un ou plusieurs problèmes ou allergies. 
            Cette entrée contient une ou plusieurs entrées qui se conforment aux spécifications de "Problem Entry" ou "Allergies and Intolerance Entry" 
            permettant à une série d'observations d'être regroupées en un unique élément "Concern Entry", ce à partir de liens de type entryRelationship 
            d'attribut typeCode='SUBJ' et inversionInd='false'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M128"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M128"/>
   <xsl:template match="@*|node()" priority="-2" mode="M128">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M128"/>
   </xsl:template>

   <!--PATTERN E_problemEntry_intIHE PCC v3.0 Problem Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Problem Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']" priority="1000"
                 mode="M129">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemEntry_int.sch] Erreur de conformité PCC : Dans l'élément "Problem Entry", le format de base utilisé pour 
            représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
            signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer 
            que l'événement a déjà eu lieu. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.28']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Dans l'élément "Problem Entry", les éléments &lt;templateId&gt; 
            identifient l'entrée comme répondant aux spécifications de PCC et de CCD (2.16.840.1.113883.10.20.1.28). 
            Cette déclaration de conformité est requise.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemEntry_int.sch] Erreur de conformité PCC : Dans l'élément "Problem Entry", il doit y avoir au minimum deux templateId 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:id) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC :  L'élément "Problem Entry" doit nécessairement avoir un identifiant (&lt;id&gt;) 
            qui est utilisé à des fins de traçage. Si la source d'information du SIS ne fournit pas d'identifiant, 
            un GUID sera affecté comme attribut "root", sans extension (ex: id root='CE1215CD-69EC-4C7B-805F-569233C5E159'). 
            Bien que CDA permette l'utilisation de plusieurs identifiants, "Problem Entry" impose qu'un identifiant 
            seulement soit présent. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemEntry_int.sch] Erreur de conformité PCC : L'élément text doit être présent avec un élément reference qui contient une URI dans l'attribut @value
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value/cda:originalText)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemEntry_fr] Erreur de conformité CI-SIS : L'élément "originalText" doit être présent une fois dans l'élément value
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
            [E_problemEntry_int.sch] Erreur de conformité PCC : Un élément "Problem Entry" décrit l'observation d'un fait clinique. 
            Son composant "statutCode" sera donc toujours fixé à la valeur code='completed'. </svrl:text>
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
            [E_problemEntry_int.sch] Erreur de conformité PCC : Bien que CDA permette de nombreuses modalités pour exprimer un intervalle de 
            temps (low/high, low/width, high/width, ou center/width), Problem Entry sera contraint à l'utilisation
            exclusive de la forme low/high.</svrl:text>
         </svrl:successful-report>
      </xsl:if>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime/cda:low[@value or @nullFlavor = 'UNK'] or cda:effectiveTime/cda:low[@value or @nullFlavor = 'NAV']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : La composante "low" de l'élément "effectiveTime" doit être exprimée dans 
            un élément "Problem Entry".
            Des exceptions sont cependant admises, comme dans le cas où le patient ne se souvient pas de 
            la date de survenue d'une affection (ex: rougeole dans l'enfance sans date précise).
            Dans ce cas, l'élément "low" aura pour attribut un "nullFlavor" fixé à la valeur 'UNK'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value[contains(@xsi:type,'CD')]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : L'élément "value" correspond à l'état (clinique) décrit et est donc obligatoire.
            Cet élément est toujours codé et son type sera toujours de type 'CD'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:value[@code and @codeSystem]) or                     (not(cda:value[@code]) and not(cda:value[@codeSystem]))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Si l'élément "value" est codé, les attributs "code" et "codeSystem" 
            seront obligatoirement présents. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1']) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Un et un seul élément évaluant la sévérité d'une affection 
            sera présent (entryRelationship) pour une entrée "Problem Entry" </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1']) or                     (cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1'] and                     cda:entryRelationship[@typeCode='SUBJ'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC :un élément "entryRelationship" optionnel peut être présent 
            et donner une indication sur la sévérité d'une affection. S'il est présent, cet élément 
            se conformera au template Severity Entry (1.3.6.1.4.1.19376.1.5.3.1.4.1).
            Son attribut 'typeCode' prendra alors la valeur 'SUBJ'. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1']) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Un et un seul élément évaluant le statut d'une affection (Problem Status Observation)
            sera présent par le biais d'une relation "entryRelationship" pour toute entrée "Problem Entry"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1']) or                     (cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1'] and                     cda:entryRelationship[@typeCode='REFR'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : un élément "entryRelationship" optionnel peut être présent 
            et donner une indication sur le statut clinique d'une affection -- cf. value set "PCC_ClinicalStatusCodes" (1.2.250.1.213.1.1.4.2.283.2). 
            S'il est présent, cet élément se conformera au template "Problem Status Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.1.1).
            Son attribut 'typeCode' prendra alors la valeur 'REFR'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2']) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Un et un seul élément évaluant le statut de l'état de santé 
            d'un patient (Health Status Observation) sera présent par le biais d'une relation "entryRelationship" 
            pour toute entrée "Problem Entry". </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2']) or                     (cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2'] and                     cda:entryRelationship[@typeCode='REFR'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : un élément "entryRelationship" optionnel peut être présent et donner
            une indication sur le statut de l'état de santé d'un patient -- cf. value set "PCC_HealthStatusCodes" (1.2.250.1.213.1.1.4.2.283.1). 
            S'il est présent, cet élément se conformera au template "Health Status Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.1.2).
            Son attribut 'typeCode' prendra alors la valeur 'REFR'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.2']) or                     (cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.2'] and                     cda:entryRelationship[@typeCode='REFR'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : un ou plusieurs éléments "entryRelationship" optionnels peuvent être présents et 
            permettre d'apporter des informations additionnelles sur le problème observé.
            S'il est présent, cet élément se conformera au template "Comment Entry" (1.3.6.1.4.1.19376.1.5.3.1.4.2).
            Son attribut 'typeCode' prendra alors la valeur 'REFR'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  
            [E_problemEntry_int.sch] Erreur de conformité PCC : L'élément code -- cf. jeu de valeurs "PCC_ProblemCodes" (1.2.250.1.213.1.1.4.2.283.3) 
            d'une entrée Problem Entry permet d'établir à quel stade diagnostique se positionne un problème : par exemple un diagnostic 
            est un stade plus évolué qu'un symptôme dans la description d'un problème. Cette évaluation est importante pour les cliniciens. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--REPORT -->
<xsl:if test="cda:uncertaintyCode">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="cda:uncertaintyCode">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : CDA permet à la description d'un état clinique un certain degré d'incertitude avec 
            l'élément "uncertaintyCode". En l'absence actuelle de consensus clairement établi sur le bon usage de cet élément, 
            PCC déconseille de l'utiliser dans le cadre d'une entrée Problem Entry.</svrl:text>
         </svrl:successful-report>
      </xsl:if>

		    <!--REPORT -->
<xsl:if test="cda:confidentialityCode">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="cda:confidentialityCode">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : CDA permet l'utilisation de l'élément "confidentialtyCode" pour une observation.
            PCC déconseille cependant pour des raisons pratiques de l'utiliser dans le cadre d'une entrée Problem Entry.
            Il y a en effet d'autres manières d'assurer la confidentialité des documents, qui pourront être résolus au sein
            du domaine d'affinité.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M129"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M129"/>
   <xsl:template match="@*|node()" priority="-2" mode="M129">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M129"/>
   </xsl:template>

   <!--PATTERN E_problemOrganizer_intPalm_Suppl_APSR V2.0 Problem Organizer Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Palm_Suppl_APSR V2.0 Problem Organizer Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.8.1.3.6&#34;]" priority="1000"
                 mode="M130">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.8.1.3.6&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='BATTERY' and @moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemOrganizer_int.sch] Erreur de conformité APSR : L'élément "organizer" de l'entrée "Problem organizer" doit avoir les attributs @classCode et @moodCode fixés respectivement aux valeurs suivante 'BATTERY' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed' or @code='aborted']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_problemOrganizer_int.sch] Erreur de conformité APSR : L'entrée "Problem organizer" doit contenir un "statusCode" avec l'attribut @code qui prend les valeurs 'completed' ou 'aborted'
        </svrl:text>
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
            [E_problemOrganizer_int.sch] Erreur de conformité APSR : L'entrée "Problem organizer" doit comporter un élément "effectiveTime" .
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M130"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M130"/>
   <xsl:template match="@*|node()" priority="-2" mode="M130">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M130"/>
   </xsl:template>

   <!--PATTERN E_problemStatusObservation_intIHE PCC Problem Status Observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Problem Status Observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1.1&#34;]"
                 priority="1000"
                 mode="M131">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1.1&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../../cda:entryRelationship[@typeCode=&#34;REFR&#34; and @inversionInd=&#34;false&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_problemStatusObservation_int]Erreur de Conformité PCC: Une entrée 'Problem Status Observation' sera représentée comme un élément de type 'observation' 
                avec un attribut typeCode='SUBJ' et un inversionIND='false'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_problemStatusObservation_int] Erreur de conformité PCC : Dans l'élément 'Problem Status Observation', le format de base utilisé pour 
                représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
                signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer 
                que l'événement a déjà eu lieu. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.57&#34;] and                  cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_problemStatusObservation_int]: Les templates Id CCD 'Problem Status Observation' (2.16.840.1.113883.10.20.1.50)
                et 'Status Observation' (2.16.840.1.113883.10.20.1.57) parents de l'entrée 'Problem Status Observation' seront présents.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_problemStatusObservation_int] Erreur de conformité PCC : Dans l'élément "Severity", il doit y avoir au minimum trois templateIds
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;33999-4&#34; and @codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_problemStatusObservation_int]: Erreur de Conformité PCC : l'élément 'code' d'une entrée 'Problem Status Observation' est obligatoire
                et signale qu'il s'agit d'une observation du statut clinique. L'attribut 'code' est fixé à la valeur '33999-4' 
                et l'attribut 'codeSystem' à la valeur '2.16.840.1.113883.6.1' (LOINC).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_problemStatusObservation_int] Erreur de Conformité PCC : l'élément 'observation' d'une entrée 'Problem Status Observation' comporte 
                une composante 'text' contenant un élément 'reference/@value' pointant sur la partie narrative où la sévérité 
                de l'observation est signalée.</svrl:text>
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
                [E_problemStatusObservation_int] Erreur de Conformité PCC : L'attribut 'code' de l'élément 'statusCode' pour tous les éléments 'Problem Status
                observations' sera nécessarement fixé à la valeur 'completed' dans ce contexte.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:value[@xsi:type=&#34;CE&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_problemStatusObservation_int] Erreur de Conformité PCC : Pour tout élément de type 'Problem Status', l'élément 'value' signale le statut clinique.
                Il est toujours représenté utilisant le datatype 'CE' (xsi:type='CE') 
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
                [E_problemStatusObservation_int] Erreur de Conformité PCC : L'élément 'observation' d'une entrée 'Problem Status Observation' comporte 
                une composante 'text' contenant un élément 'reference' pointant sur la partie narrative où la sévérité 
                de l'observation est signalée.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M131"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M131"/>
   <xsl:template match="@*|node()" priority="-2" mode="M131">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M131"/>
   </xsl:template>

   <!--PATTERN E_procedureEntry_intIHE PCC v3.0 Procedure Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Procedure Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.19&#34;]"
                 priority="1000"
                 mode="M132">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.19&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:procedure[@classCode=&#34;PROC&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", l'attribut "classCode" est fixé à la valeur "PROC".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(self::cda:procedure[@moodCode=&#34;EVN&#34;] and                 cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]) or (self::cda:procedure[@moodCode=&#34;INT&#34;] and                 cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_int]: Lorsque l'entrée "Procedure" est en mode événement (moodCode='EVN'), elle se conforme au template CCD 2.16.840.1.113883.10.20.1.29.
                Lorsque l'entrée "Procedure" est en mode intent (moodCode='INT'), elle se conforme au template CCD 2.16.840.1.113883.10.20.1.25.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", il doit y avoir au minimum deux templateIds.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", il doit y avoir au moins un identifiant "id".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", il doit y avoir un élément "code".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", l'élément 'text' doit être présent avec un élément 'reference' qui contient une URI dans l'attribut @value.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = &#34;completed&#34; or                 @code = &#34;active&#34; or                 @code = &#34;aborted&#34; or                 @code = &#34;cancelled&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_int]: Dans l'entrée "Procedure", l'élément "statusCode" est obligatoire.
                Il prendra la valeur "completed" pour les procédures réalisées, "active" pour les procédures 
                toujours en cours, "aborted" pour les procédures ayant été stoppées avant la fin 
                et "cancelled" pour les procédures qui ont été annulées (avant d'avoir débuté).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(./@moodCode=&#34;INT&#34;) or                  (cda:effectiveTime or cda:priorityCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure" en mode "INT", si l'élément "effectiveTime" est omis alors l'élément "priorityCode" est obligatoire. 
                L'élément "priorityCode" peut être précisé dans d'autres modes pour indiquer le degré de priorité de la procédure.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M132"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M132"/>
   <xsl:template match="@*|node()" priority="-2" mode="M132">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M132"/>
   </xsl:template>

   <!--PATTERN E_product_intIHE PCC v3.0 Product Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Product Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7.2&#34;]"
                 priority="1000"
                 mode="M133">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.7.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_product_int] Erreur de Conformité PCC : Le template CCD parent 'Product' (2.16.840.1.113883.10.20.1.53) est obligatoire.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:manufacturedMaterial/cda:code[@nullFlavor]              or (cda:manufacturedMaterial/cda:code/cda:originalText/cda:reference)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_product_int] Erreur de Conformité PCC : Les éléments 'code' et 'originalText/reference' sont obligatoires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M133"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M133"/>
   <xsl:template match="@*|node()" priority="-2" mode="M133">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M133"/>
   </xsl:template>

   <!--PATTERN E_produitDeSantePrescrit_intIHE PHARM PRE "Prescription-Item"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PHARM PRE "Prescription-Item"</svrl:text>

	  <!--RULE -->
<xsl:template match="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable"
                 priority="1001"
                 mode="M134">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:manufacturedProduct/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Produit-de-sante-prescrit doit avoir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:manufacturedProduct/cda:templateId[@root='2.16.840.1.113883.10.20.1.53']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Produit-de-sante-prescrit doit avoir un 'templateId' dont l'attribut @root="2.16.840.1.113883.10.20.1.53".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:manufacturedProduct/cda:manufacturedMaterial[@classCode='MMAT' and @determinerCode='KIND']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [3] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Produit-de-sante-prescrit doit comporter un élément 'manufacturedMaterial' avec les attributs :
                - @xmlns:pharm="urn:ihe:pharm"
                - @classCode="MMAT"
                - @determinerCode="KIND"
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M134"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial"
                 priority="1000"
                 mode="M134">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial"/>
      <xsl:variable name="count_formCode"
                    select="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:formCode)"/>
      <xsl:variable name="count_lotNumberText"
                    select="count(//cda:manufacturedProduct/cda:manufacturedMaterial/cda:lotNumberText)"/>
      <xsl:variable name="count_expirationTime"
                    select="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:expirationTime)"/>
      <xsl:variable name="count_asContent"
                    select="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:asContent[@classCode='CONT'])"/>
      <xsl:variable name="count_asSpecializedKind"
                    select="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:asSpecializedKind[@classCode='GRIC'])"/>
      <xsl:variable name="count_ingredient"
                    select="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:ingredient[@classCode='ACTI'])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [4] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'manufacturedMaterial' doit avoir un templateId dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.1" (cardinalité [1..1]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(//cda:code[@codeSystem]) or (//cda:code[@nullFlavor='NA'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [5] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - Si le médicament est codé, alors le code doit provenir d'une terminologie (ATC, CIP, CIS, ...).
                - Si le médicament n'est pas codé (ex : préparations magistrales, médecine composée, ...), alors l'attribut @nullFlavor="NA" DOIT être utilisé.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:name"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [6] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'name' dans le 'manufacturedMaterial' est obligatoire (cardinalité [1..1]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_formCode =1) or ($count_formCode =0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [7] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:formCode' ne peut être présent plus d'une fois (cardinalité [0..1])
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_lotNumberText =1) or ($count_lotNumberText =0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [8] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:lotNumberText' ne peut être présent plus d'une fois (cardinalité [0..1])
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_expirationTime =1) or ($count_expirationTime =0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [9] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:expirationTime' ne peut être présent plus d'une fois (cardinalité [0..1])
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_asContent =1) or ($count_asContent=0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [10] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:asContent' ne peut être présent plus d'une fois (cardinalité [0..1]) et son attribut @classCode="CONT".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_asSpecializedKind &gt;=1) or ($count_asSpecializedKind=0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [11] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:asSpecializedKind', si présent, doit avoir son attribut @classCode="GRIC" (cardinalité [0..*]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_ingredient &gt;=1) or ($count_ingredient=0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [12] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:ingredient', si présent, doit avoir son attribut @classCode="ACTI" (cardinalité [0..*]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M134"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M134"/>
   <xsl:template match="@*|node()" priority="-2" mode="M134">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M134"/>
   </xsl:template>

   <!--PATTERN E_quantiteProduit_intIHE Pharm PRE Entrée "Amount of units of the consumable Content Module"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Pharm PRE Entrée "Amount of units of the consumable Content Module"</svrl:text>

	  <!--RULE -->
<xsl:template match="//cda:entryRelationship[@typeCode='COMP']/cda:supply[@classCode='SPLY'][@moodCode='RQO']"
                 priority="1000"
                 mode="M135">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:entryRelationship[@typeCode='COMP']/cda:supply[@classCode='SPLY'][@moodCode='RQO']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.8']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_quantiteProduit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Quantite-de-produit doit avoir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.8".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:independentInd[@value='false'])=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_quantiteProduit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Quantite-de-produit doit comporter un élément 'independentInd' et son attribut @value="false".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:quantity[@value])=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [3] [E_quantiteProduit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Quantite-de-produit doit comporter un élément 'quantity' et son attribut @value. 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M135"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M135"/>
   <xsl:template match="@*|node()" priority="-2" mode="M135">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M135"/>
   </xsl:template>

   <!--PATTERN E_referenceInterne_intEntrée FR-Reference-interne (IHE-PCC - Internal-Reference - 1.3.6.1.4.1.19376.1.5.3.1.4.4.1)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Entrée FR-Reference-interne (IHE-PCC - Internal-Reference - 1.3.6.1.4.1.19376.1.5.3.1.4.4.1)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.4.1&#34;]"
                 priority="1000"
                 mode="M136">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.4.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_reference-interne_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Reference-interne doit comporter un élément 'id'.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:code[@nullFlavor='NA'])=1) or (count(cda:code[@code and @codeSystem])=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [3][E_reference-interne_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Reference-interne doit comporter un 'code' identique à l’élément référencé. Si l’élément référencé n’est pas codé, alors le 'code' doit être @nullFlavor="NA".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M136"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M136"/>
   <xsl:template match="@*|node()" priority="-2" mode="M136">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M136"/>
   </xsl:template>

   <!--PATTERN E_referenceItemPlanTraitement_intIHE-PRE - Reference-to-Medication-Treatment-Plan-Item-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE-PRE - Reference-to-Medication-Treatment-Plan-Item</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']]" priority="1000"
                 mode="M137">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']]"/>
      <xsl:variable name="count_ER_itemPlanTraitement"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']]/cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']])"/>
      <xsl:variable name="count_consumable"
                    select="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']]/cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial[@nullFlavor='NA'])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:id)=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_referenceItemPlanTraitement_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Reference-item-plan-traitement doit comporter un élément 'id'.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cda:code[@code='MTPItem'][@codeSystem='1.3.6.1.4.1.19376.1.9.2.2'])=1) and count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [2] [E_referenceItemPlanTraitement_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Reference-item-plan-traitement doit comporter un élément 'code' et ses attribut :
                - @code="MTPItem" (cardinalité [1..1])
                - @codeSystem="1.3.6.1.4.1.19376.1.9.2.2" (cardinalité [1..1])
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_consumable=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [3] [E_referenceItemPlanTraitement_int.sch] Erreur de conformité IHE Pharm PRE :  
                L'entrée FR-Reference-item-plan-traitement doit comporter un élément 'consumable/manufacturedProduct/manufacturedMaterial' dont la valeur est fixée à la valeur @nullFlavor="NA".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_ER_itemPlanTraitement=1) or ($count_ER_itemPlanTraitement=0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [4] [E_referenceItemPlanTraitement_int.sch] Erreur de conformité IHE Pharm PRE : 
                Dans l'entrée FR-Reference-item-plan-traitement, l'entrée optionnelle FR-Item-plan-traitement doit contenir un 'templateId' @root="1.3.6.1.4.1.19376.1.9.1.3.7".
           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M137"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M137"/>
   <xsl:template match="@*|node()" priority="-2" mode="M137">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M137"/>
   </xsl:template>

   <!--PATTERN E_severity_intIHE PCC v3.0 Severity-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Severity</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1&#34;]" priority="1000"
                 mode="M138">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.1&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../../cda:entryRelationship[@typeCode=&#34;SUBJ&#34; and @inversionInd=&#34;true&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [ER_severity_int]Erreur de Conformité PCC: Une entrée 'severity' représente la sévérité et sera de la même manière représentée comme une élément de type 'observation' 
            avec un attribut typeCode='SUBJ' et un inversionIND='true'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [ER_severity_int] Erreur de conformité PCC : Dans l'élément "severity", le format de base utilisé pour 
            représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
            signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer 
            que l'événement a déjà eu lieu.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [ER_severity_int]Erreur de Conformité PCC: Le template parent (2.16.840.1.113883.10.20.1.55) sera déclaré.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [ER_severity_int] Erreur de conformité PCC : Dans l'élément "Severity", il doit y avoir au minimum deux templateId
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
            [ER_severity_int] Erreur de Conformité PCC: L'élément 'code' de l'entrée 'severity' indique la 
            sévérité de l'allergie provoquée.
            L'élément 'code' doit obligatoirement comporter les attributs 'code' et 'codeSystem'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text/cda:reference[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [ER_severity_int] Erreur de conformité PCC : L'élément text doit être présent avec un élément reference qui contient une URI dans l'attribut @value
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
            [ER_severity_int] Erreur de conformité PCC : Le composant "statutCode" d'un élément "health Status Observation" sera toujours fixé à la valeur code='completed'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:value[@xsi:type=&#34;CD&#34;]) and              (cda:value[(@code) and (@codeSystem)] or cda:value[not(@code) and not(@codeSystem) and not(@displayName) and not(@codeSystemName)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [ER_severity_int] Erreur de conformité PCC : Alors que l'élément 'value' peut être codé ou non, son type sera 
            toujours 'coded value' (xsi:type='CD'). 
            S'il est codé, les attributs  'code' et 'codeSystem' sont obligatoires, sinon, tout attribut autre que xsi:type='CD' est interdit.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M138"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M138"/>
   <xsl:template match="@*|node()" priority="-2" mode="M138">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M138"/>
   </xsl:template>

   <!--PATTERN E_simpleObservation_intIHE PCC v3.0 Simple Observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Simple Observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"
                 priority="1000"
                 mode="M139">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='OBS' and @moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_simpleObservation_int.sch] Erreur de Conformité PCC:  Ce templateId doit être utilisé comme une observation avec les attributs @classCode et @moodCode fixés respectivement aux valeurs 'OBS' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_simpleObservation_int.sch] Erreur de Conformité PCC: "Simple Observation" requiert un élément identifiant &lt;id&gt;.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_simpleObservation_int.sch] Erreur de Conformité PCC: "Simple Observation" requiert un élément "code" décrivant ce qui est observé.</svrl:text>
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
            [E_simpleObservation_int.sch] Erreur de conformité PCC : "Simple Observation" doit contenir un élément texte, qui doit contenir un élément référence
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
            [E_simpleObservation_int.sch] Erreur de Conformité PCC: L'élément "statusCode" est requis dans "Simple Observations" 
            sont fixés à la valeur "completed".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime[@value or @nullFlavor] or cda:effectiveTime/cda:low[@value or @nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_simpleObservation_int.sch] Erreur de Conformité PCC: L'élément &lt;effectiveTime&gt; est requis dans "Simple Observations",
            et représentera la date et l'heure de la mesure effectuée. Cet élément devrait être précis au jour. 
            Si la date et l'heure sont inconnues, l'attribut nullFlavor sera utilisé.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M139"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M139"/>
   <xsl:template match="@*|node()" priority="-2" mode="M139">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M139"/>
   </xsl:template>

   <!--PATTERN E_socialHistoryObservation_intIHE PCC Social History Observation: 1.3.6.1.4.1.19376.1.5.3.1.4.13.4-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC Social History Observation: 1.3.6.1.4.1.19376.1.5.3.1.4.13.4</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]"
                 priority="1000"
                 mode="M140">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.4&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : Le templateId du parent (Simple Observation)doit être présent.
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : Le templateId du parent HL7 CCD Social History doit être présent.
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_int.sch] Erreur de conformité PCC : Dans l'élément "Social History Observation", il doit y avoir au minimum trois templateId
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:repeatNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : L'élément &lt;repeatNumber&gt; devrait être omis.
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:interpretationCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : L'élément &lt;interpretationCode&gt; devrait être omis.
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:methodCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : L'élément &lt;methodCode&gt; devrait être omis.
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:targetSiteCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : L'élément &lt;targetSiteCode&gt; devrait être omis.
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M140"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M140"/>
   <xsl:template match="@*|node()" priority="-2" mode="M140">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M140"/>
   </xsl:template>

   <!--PATTERN E_specimenProcedureStep_intPalm_Suppl_APSR V2.0 Specimen Procedure Step Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Palm_Suppl_APSR V2.0 Specimen Procedure Step Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.10.4.1&#34;]" priority="1000"
                 mode="M141">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.10.4.1&#34;]"/>
      <xsl:variable name="count_text" select="count(cda:text)"/>
      <xsl:variable name="count_statusCode" select="count(cda:statusCode)"/>
      <xsl:variable name="count_effectiveTime" select="count(cda:effectiveTime)"/>
      <xsl:variable name="count_approachSiteCode" select="count(cda:approachSiteCode)"/>
      <xsl:variable name="count_targetSiteCode" select="count(cda:targetSiteCode)"/>
      <xsl:variable name="count_specimen" select="count(cda:specimen)"/>
      <xsl:variable name="count_performer" select="count(cda:performer)"/>
      <xsl:variable name="count_participant" select="count(cda:participant)"/>
      <xsl:variable name="count_entryRelationShip_act"
                    select="count(cda:entryRelationship/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1.3'])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:procedure[@classCode='PROC'] and self::cda:procedure[@moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "procedure" de l'entrée "Specimen Procedure Step" doit avoir les attributs @classCode et @moodCode fixés respectivement aux valeurs suivante 'PROC' et 'EVN'
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
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'entrée "Specimen Procedure Step" doit contenir un élément "code" permettant de la coder(cardinalité [1..1]).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_text &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "text" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_statusCode &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "statusCode" ne peut être présent qu'une seule fois (cardinalité [0..1])
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
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "effectiveTime" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_approachSiteCode &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "approachSiteCode" ne peut être présent qu'une seule fois (cardinalité [0..1])
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
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "targetSiteCode" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_specimen &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "specimen" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_performer &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "performer" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_participant &gt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "participant" doit être présent au minimum une fois (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_entryRelationShip_act &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'entryRelationship act de templateId '1.3.6.1.4.1.19376.1.3.1.3' (pour décrire le spécimen reçu) ne peut être présente qu'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M141"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M141"/>
   <xsl:template match="@*|node()" priority="-2" mode="M141">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M141"/>
   </xsl:template>

   <!--PATTERN E_specimenCollection_intIHE PaLM specimen Collection-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PaLM specimen Collection</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.1.2&#34;]" priority="1000"
                 mode="M142">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.1.2&#34;]"/>
      <xsl:variable name="count_targetSiteCode" select="count(cda:targetSiteCode)"/>
      <xsl:variable name="count_performer" select="count(cda:performer)"/>
      <xsl:variable name="count_participant" select="count(cda:participant)"/>
      <xsl:variable name="count_participant_id"
                    select="count(cda:participant/cda:participantRole/cda:id)"/>
      <xsl:variable name="count_entryRelationShip_act"
                    select="count(cda:entryRelationship/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1.3'])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='PROC' and @moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément procedure de specimen collection doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs 'PROC' and 'EVN'
        </svrl:text>
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
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément effectiveTime doit être présent dans specimen Collection
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
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément targetSite code ne peut être présent qu'une seule fois (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_performer &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément perfermer ne peut être présent q'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_participant =1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément particpant doit être présent, et une seule fois (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_participant_id=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément id de participantRole doit être présent, masi qu'une seule fois (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_entryRelationShip_act &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'entryRelationShip act de templateId '1.3.6.1.4.1.19376.1.3.1.3' ne peut être présente qu'une seule fois au maximum (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M142"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M142"/>
   <xsl:template match="@*|node()" priority="-2" mode="M142">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M142"/>
   </xsl:template>

   <!--PATTERN E_supplyEntry_intIHE PCC v3.0Supply entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0Supply entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']"
                 priority="1003"
                 mode="M143">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>
      <xsl:variable name="count_id" select="count(cda:id)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../../cda:entryRelationship[@typeCode = 'REFR' and  @inversionInd = 'false']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'entryRelationShip doit contenir les attributs 
            @typeCode et @inversionInd fixés respectivement aux valeurs 'REFR' et 'false'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='SPLY' and (@moodCode='INT' or @moodCode='EVN')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'supply' doit contenir l'attribut @classCode fixé à la valeur 'SPLY' et l'attribut @moodCode fixé à la valeur 'INT' ou 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : L'entrée 'Prescription' doit contenir au minimum deux templateId.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : L'entrée 'Prescription' doit contenir un élément id (cardinalité [1..1]).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M143"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:quantity"
                 priority="1002"
                 mode="M143">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:quantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@value"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'quantity' (s'il est présent) doit avoir un attribut 'value'.  
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M143"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:author"
                 priority="1001"
                 mode="M143">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:author"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:time[@value or @nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'time' doit être présent dans l'élément 'author' avec un attribut 'value'. Le nullFlavor est autorisé.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedAuthor"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'author' doit contenir un élément 'assignedAuthor'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedAuthor/cda:assignedPerson/cda:name or cda:assignedAuthor/cda:representedOrganization/cda:name"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', un élément 'assignedPerson' et/ou un élément 'representedOrganization' doit être présent. Ces éléments doivent contenir un élément 'name' pour identifier le prescripteur ou l'organization.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M143"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:performer"
                 priority="1000"
                 mode="M143">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:performer"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@typeCode='PRF'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'performer' doit contenir un attribut typeCode='PRF'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:time[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'performer' doit contenir un élément 'time' avec un attribut 'value'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'performer' doit contenir un élément 'assignedEntity'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:assignedPerson/cda:name or cda:assignedEntity/cda:representedOrganization/cda:name"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'performer/assignedEntity' doit contenir un élément 'assignedPerson/name' et/ou un élément 'representedOrganization/name'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M143"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M143"/>
   <xsl:template match="@*|node()" priority="-2" mode="M143">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M143"/>
   </xsl:template>

   <!--PATTERN E_surveyObservation_intIHE PCC v3.0 Survey observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Survey observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6']"
                 priority="1000"
                 mode="M144">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='OBS'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation, l'attribut "classCode" sera fixé à la valeur "OBS". 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@moodCode = 'EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation", l'élément "moodCode" 
            sera fixé à la valeur "EVN".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation", il doit y avoir au minimum trois éléments templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_surveyObservation_int] Erreur de Conformité PCC : L'entrée "Survey Observation" est un fils de l'entrée simple Observation, elle doit donc avoir son templateId fixé à la valeur @root='1.3.6.1.4.1.19376.1.53.1.4.13'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.31']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_surveyObservation_int] Erreur de Conformité PCC : L'entrée "Survey Observation" doit avoir une templateId fixé à la valeur @root='2.16.840.1.113883.10.20.1.31' pour respecter la conformité CCD
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
            [E_surveyObservation_int] Erreur de Conformité PCC :
            Dans une entrée "Survey Observation", un 'élément "value" est obligatoire (cardinalité [1..*]).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--REPORT -->
<xsl:if test="cda:methodCode">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="cda:methodCode">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation" l'élément methodCode ne doit pas être présent
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>

		    <!--REPORT -->
<xsl:if test="cda:targetSiteCode">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="cda:targetSiteCode">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation", l'élément targetSiteCode ne doit pas être présent
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M144"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M144"/>
   <xsl:template match="@*|node()" priority="-2" mode="M144">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M144"/>
   </xsl:template>

   <!--PATTERN E_transport_intIHE PCC v3.0 transport-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 transport</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1&#34;]"
                 priority="1000"
                 mode="M145">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='ACT' and (@moodCode='INT' or @moodCode='EVN')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_transport_int.sch] Erreur de conformité PCC : L'élément transport act doit avoir un attribut @classCode fixé à 'ACT' et un attribut @moodCode prenant les valeurs 'INT' ou 'EVN'
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id[@root]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_transport_int.sch] Erreur de conformité PCC : L'élément transport doit avoir au moins un élément id
       </svrl:text>
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
            [E_transport_int.sch] Erreur de conformité PCC : L'élément transport doit contenir un élément effectiveTime
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime/cda:low[@value] or cda:effectiveTime/cda:high[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_transport_int.sch] Erreur de conformité PCC : L'élément effectiveTime doit contenir un élément low et/ou un élément high avec l'attribut @value
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M145"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M145"/>
   <xsl:template match="@*|node()" priority="-2" mode="M145">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M145"/>
   </xsl:template>

   <!--PATTERN E_traitementPrescrit_intIHE PRE Prescription Item Entry (1.3.6.1.4.1.19376.1.9.1.3.2)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PRE Prescription Item Entry (1.3.6.1.4.1.19376.1.9.1.3.2)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.2']" priority="1000"
                 mode="M146">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.2']"/>
      <xsl:variable name="count_id" select="count(cda:id) "/>
      <xsl:variable name="count_code"
                    select="count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'])"/>
      <xsl:variable name="count_code_1" select="count(cda:code)"/>
      <xsl:variable name="count_statusCode" select="count(cda:statusCode[@code='completed'])"/>
      <xsl:variable name="count_statusCode_1" select="count(cda:statusCode)"/>
      <xsl:variable name="count_text" select="count(cda:text)"/>
      <xsl:variable name="count_routeCode" select="count(cda:routeCode)"/>
      <xsl:variable name="count_approachSiteCode_1" select="count(cda:approachSiteCode)"/>
      <xsl:variable name="count_approachSiteCode"
                    select="count(cda:approachSiteCode[@codeSystem='2.16.840.1.113883.1.11.19724'])"/>
      <xsl:variable name="count_doseQuantity" select="count(cda:doseQuantity)"/>
      <xsl:variable name="count_rateQuantity" select="count(cda:rateQuantity)"/>
      <xsl:variable name="count_rateQuantity_low" select="count(cda:rateQuantity/cda:low)"/>
      <xsl:variable name="count_rateQuantity_high" select="count(cda:rateQuantity/cda:high)"/>
      <xsl:variable name="count_maxDoseQuantity" select="count(cda:maxDoseQuantity)"/>
      <xsl:variable name="count_maxDoseQuantity_numerator"
                    select="count(cda:maxDoseQuantity/cda:numerator)"/>
      <xsl:variable name="count_maxDoseQuantity_denominator"
                    select="count(cda:maxDoseQuantity/cda:denominator)"/>
      <xsl:variable name="count_author" select="count(cda:author)"/>
      <xsl:variable name="count_reference" select="count(cda:reference)"/>
      <xsl:variable name="count_effectiveTime" select="count(cda:effectiveTime)"/>
      <xsl:variable name="count_MA_normales"
                    select="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.1'])"/>
      <xsl:variable name="count_MA_progressives"
                    select="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.8'])"/>
      <xsl:variable name="count_MA_fractionnees"
                    select="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.9'])"/>
      <xsl:variable name="count_MA_conditionnees"
                    select="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.10'])"/>
      <xsl:variable name="count_MA_combinees"
                    select="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.11'])"/>
      <xsl:variable name="count_MA_debutDiff"
                    select="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.21'])"/>
      <xsl:variable name="count_consumable"
                    select="count(cda:consumable/cda:manufacturedProduct[@classCode='MANU']/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2'])"/>
      <xsl:variable name="count_ER_MotifTraitement"
                    select="count(cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1']])"/>
      <xsl:variable name="count_ER_TraitementPrescritSub"
                    select="count(cda:entryRelationship[cda:sequenceNumber])"/>
      <xsl:variable name="count_ER_RefItemPlanTrait"
                    select="count(cda:entryRelationship[cda:substanceAdministration/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']])"/>
      <xsl:variable name="count_ER_InstrucPatient"
                    select="count(cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']])"/>
      <xsl:variable name="count_ER_InstructDispensateur"
                    select="count(cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']])"/>
      <xsl:variable name="count_ER_QuantiteProduit"
                    select="count(cda:entryRelationship[cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.8']])"/>
      <xsl:variable name="count_ER_AutorisationSubstitution"
                    select="count(cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']])"/>
      <xsl:variable name="count_ER_PeriodeRenouvellement"
                    select="count(cda:entryRelationship[cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.15']])"/>
      <xsl:variable name="count_E_traitementPrescrit"
                    select="count(cda:entryRelationship/cda:substanceAdministration/cda:templateId[@root='1.2.250.1.213.1.1.3.83.1'])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="                 (($count_MA_normales&gt;=1) and ($count_ER_TraitementPrescritSub=0) and ($count_E_traitementPrescrit=0)) or                 (($count_MA_progressives&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_E_traitementPrescrit&gt;0)) or                 (($count_MA_fractionnees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_E_traitementPrescrit&gt;0)) or                 (($count_MA_conditionnees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_E_traitementPrescrit&gt;0)) or                 (($count_MA_combinees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_E_traitementPrescrit&gt;0)) or                 (($count_MA_debutDiff&gt;=1) and ($count_ER_TraitementPrescritSub=0) and ($count_E_traitementPrescrit=0))                 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                
                [3] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                Le dernier 'templateId' indique le mode d'administration choisi pour le traitement prescrit. Il doit être choisi parmi la liste suivante :
                                               
                1.3.6.1.4.1.19376.1.5.3.1.4.7.1  (Mode d'administration : doses normales). De ce fait : 
                                                  - il ne peut pas y avoir d'entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                                                                   
                1.3.6.1.4.1.19376.1.5.3.1.4.8    (Mode d'administration : doses progressives). De ce fait :
                                                  - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                 
                1.3.6.1.4.1.19376.1.5.3.1.4.9    (Mode d'administration : doses fractionnées). De ce fait : 
                                                  - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                  
                1.3.6.1.4.1.19376.1.5.3.1.4.10   (Mode d'administration : doses conditionnelles). De ce fait : 
                                                  - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                  
                1.3.6.1.4.1.19376.1.5.3.1.4.11   (Mode d'administration : doses combinées). De ce fait :
                                                  - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                  
                1.3.6.1.4.1.19376.1.5.3.1.4.21   (Mode d'administration : doses à début différé). De ce fait : 
                                                  - il ne peut pas y avoir d'entryRelationship de type "Prescription Item Entry Content Module" subordonnée
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id&gt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [4] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                Il faut obligatoirement au moins un élément 'id' pour l'entrée (cardinalité [1..*]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_code=1 and $count_code_1=1) or ($count_code_1=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [5] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - L'élément optionnel 'code' ne peut être présent plus d'une fois (cardinalité [0..1]), 
                - si présent, ses attributs doivent être @code="DRUG" et @codeSystem="2.16.840.1.113883.5.4".
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_text=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [6] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée doit comporter obligatoirement un élément 'text' (cardinalité [1..1]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_statusCode=1 and $count_statusCode_1=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [7] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée doit comporter obligatoirement un élément 'statusCode', dont l'attribut @code est fixé à la valeur 'completed'(cardinalité [1..1]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:repeatNumber[@value&gt;=0])                  or (//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:repeatNumber[@nullFlavor='NI'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                
                [8] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'repeatNumber' est obligatoire pour l'entrée "Prescription Item Entry Content Module" et doit avoir une valeur d'attribut. Selon la situation :
                - Si aucun renouvellement autorisé (dispensation unique) : @value="0"
                - Si x renouvellement(s) autorisé(s) : @value="x"
                - Si le renouvellement n’est pas limité (par ex : si une période de renouvellement est définie), la valeur est fixée à @nullFlavor="NI".
                Note : le nombre total de dispensations est égal au repeatNumber + 1
                
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_routeCode&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [9] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'routeCode' ne peut être présent plus d'une fois (cardinalité [0..1])
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_approachSiteCode&gt;0 and $count_approachSiteCode_1&gt;0) or ($count_approachSiteCode_1=0) or (cda:approachSiteCode[@nullFlavor])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [10] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - L'élément optionnel 'approachSiteCode' ne peut être présent plus d'une fois (cardinalité [0..1]), 
                - si présent, les valeurs de ses attributs doivent provenir du jeu de valeurs JDV_HL7_HumanSubstanceAdministrationSite-CISIS (2.16.840.1.113883.1.11.19724).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($count_doseQuantity=1) and (                 (cda:doseQuantity/cda:low) and                 (cda:doseQuantity/cda:high)                 )) or not(cda:doseQuantity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [11] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - L'élément optionnel 'doseQuantity' ne peut être présent plus d'une fois (cardinalité [0..1]).
                - Si présent, alors il doit comporter obligatoirement un 'low' [1..1] et un 'high' [1..1]
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_rateQuantity=1) and (                 ($count_rateQuantity_low=1) and                 ($count_rateQuantity_high=1)                 ) or ($count_rateQuantity=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                
                [12] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - L'élément optionnel 'rateQuantity' ne peut être présent plus d'une fois (cardinalité [0..1]).
                - Si présent, alors il doit comporter obligatoirement un 'low' [1..1] et un 'high' [1..1]
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_maxDoseQuantity&gt;=1) and (                 ($count_maxDoseQuantity_numerator=$count_maxDoseQuantity) and                 ($count_maxDoseQuantity_denominator=$count_maxDoseQuantity)                 ) or ($count_maxDoseQuantity=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                
                [13] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'maxDoseQuantity' (cardinalité [0..*]), si présent, doit comporter obligatoirement un 'numerator [1..1] et un 'denominator' [1..1]
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_consumable =1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [14] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'consumable' est obligatoire pour l'entrée "Prescription Item Entry Content Module" de type 'manufacturedProduct'(cardinalité [1..1]), 
                et ne peut contenir qu'une entrée "FR-Produit-de-santé-prescrit" dont :
                - l'attribut du 'manufacturedProduct' @classcode="MANU"
                - le premier 'templateId' @root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2" (Conformité de l'entrée au volet IHE Pharm PRE)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_author=0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [15] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                Le document étant une prescription, l'élément 'author' est interdit ici.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_MotifTraitement&gt;=1) or ($count_ER_MotifTraitement=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [16] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle de type 'act' "IHE Internal Reference Entry" (Motif du traitement) (cardinalité [0..*]),
                si présente, doit avoir un templateId dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.4.1" (Conformité de l'entrée au parent IHE Pharm PRE)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_RefItemPlanTrait=1) or ($count_ER_RefItemPlanTrait=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [17] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "Reference to Medication Treatment Plan Item Entry" de type substanceAdministration (cardinalité [0..1]), 
                si présente, doit contenir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.10" (Conformité de l'entrée au volet IHE Pharm PRE)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_InstrucPatient=1) or ($count_ER_InstrucPatient=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [18] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "IHE Patient Medication Instructions" de type act (cardinalité [0..1]), 
                si présente, doit contenir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.3" (Conformité de l'entrée au volet IHE PCC)
    
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_InstructDispensateur=1) or ($count_ER_InstructDispensateur=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [19] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "IHE Medication FulFillment Instructions" de type act (cardinalité [0..1]), si présente, doit contenir :
                - un premier 'templateId' dont l'attribut @root="2.16.840.1.113883.10.20.1.43" (Conformité de l'entrée au parent CCD)
                - un deuxième 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.3.1" (Conformité de l'entrée au volet IHE PCC)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_QuantiteProduit=1) or ($count_ER_QuantiteProduit=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [20] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "Amount of units of the consumable Content Module" de type supply (cardinalité [0..1]), si présente, doit contenir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.8" (Conformité de l'entrée au parent IHE Pharm PRE)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_AutorisationSubstitution&gt;=1) or ($count_ER_AutorisationSubstitution=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [21] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                Si présente, l'entryRelationship de type 'act' "Substitution Permission Content Module" (cardinalité [0..*]) doit avoir un templateId dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.9.1" (Conformité de l'entrée au volet IHE Pharm PRE)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($count_ER_PeriodeRenouvellement=1) or ($count_ER_PeriodeRenouvellement=0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [22] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "Renewal Period General Specification" de type supply (cardinalité [0..1]), si présente, doit contenir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.15" (Conformité de l'entrée au volet IHE Pharm PRE)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_reference=0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [23] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'reference' n'est pas utilisé dans le cas d'une prescription.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M146"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M146"/>
   <xsl:template match="@*|node()" priority="-2" mode="M146">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M146"/>
   </xsl:template>

   <!--PATTERN E_traitementPrescritSubordonne_intIHE Pharm PRE subordinate "Prescription Item"-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE Pharm PRE subordinate "Prescription Item"</svrl:text>

	  <!--RULE -->
<xsl:template match="//cda:entry/cda:substanceAdministration/cda:entryRelationship[@typeCode='COMP']/cda:sequenceNumber"
                 priority="1000"
                 mode="M147">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//cda:entry/cda:substanceAdministration/cda:entryRelationship[@typeCode='COMP']/cda:sequenceNumber"/>
      <xsl:variable name="count_id" select="count(//cda:id)"/>
      <xsl:variable name="count_ER_subordonnees"
                    select="count(//cda:entry/cda:substanceAdministration/cda:entryRelationship[@typeCode='COMP'][cda:sequenceNumber])"/>
      <xsl:variable name="count_doseQuantity" select="count(//cda:doseQuantity)"/>
      <xsl:variable name="count_doseQuantityLow" select="count(//cda:doseQuantity/cda:low)"/>
      <xsl:variable name="count_doseQuantityHigh" select="count(//cda:doseQuantity/cda:high)"/>
      <xsl:variable name="count_consumable"
                    select="count(//cda:consumable/cda:manufacturedProduct[cda:manufacturedMaterial[@nullFlavor='NA']])"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_id&gt;=$count_ER_subordonnees"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                [1] [E_traitementPrescritSubordonne_int.sch] Erreur de conformité IHE Pharm PRE : 
                Il faut obligatoirement au moins un élément 'id' pour l'entryRelationship subordinate "Prescription Item Entry Content Module" (cardinalité [1..*]).
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M147"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M147"/>
   <xsl:template match="@*|node()" priority="-2" mode="M147">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M147"/>
   </xsl:template>

   <!--PATTERN E_vitalSignsObservation_int.schIHE PCC v3.0 Vital Signs Observation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Vital Signs Observation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34;]"
                 priority="1000"
                 mode="M148">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13.2&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = &#34;2.16.840.1.113883.10.20.1.31&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : l'identifiant du template parent (2.16.840.1.113883.10.20.1.31) doit être présent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : l'identifiant du template parent (1.3.6.1.4.1.19376.1.5.3.1.4.13) doit être présent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : l'élément 'observation' doit contenir au minimum trois templateId.
        </svrl:text>
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
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : l'élément 'effectiveTime' doit être présent.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;29463-7&#34;]) or (cda:code[@code=&#34;29463-7&#34;] and cda:value[@unit=&#34;kg&#34; or @unit=&#34;g&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure du poids (29463-7) 
            est un nombre indénombrable s'exprimant en grammes (g) ou en kilogrammes (kg).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;9279-1&#34;]) or (cda:code[@code=&#34;9279-1&#34;] and cda:value[@unit=&#34;/min&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la fréquence respiratoire (9279-1) 
            est un nombre indénombrable s'exprimant en min-1 (/min).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;8867-4&#34;]) or (cda:code[@code=&#34;8867-4&#34;] and cda:value[@unit=&#34;/min&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la fréquence cardiaque (8867-4) 
            est un nombre indénombrable s'exprimant en min-1 (/min).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;2708-6&#34;]) or (cda:code[@code=&#34;2708-6&#34;] and cda:value[@unit=&#34;%&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la saturation en oxygène (2708-6)
            est un nombre indénombrable s'exprimant en pourçentage (%).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;8480-6&#34;]) or (cda:code[@code=&#34;8480-6&#34;] and cda:value[@unit=&#34;mm[Hg]&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la pression artérielle systolique (8480-6)
            est un nombre indénombrable s'exprimant en millimètres de mercure (mm[Hg]).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;8462-4&#34;]) or (cda:code[@code=&#34;8462-4&#34;] and cda:value[@unit=&#34;mm[Hg]&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la pression artérielle diastolique (8462-4)
            est un nombre indénombrable s'exprimant en millimètres de mercure (mm[Hg]).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;8310-5&#34;]) or (cda:code[@code=&#34;8310-5&#34;] and cda:value[@unit=&#34;Cel&#34; or @unit=&#34;[degF]&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la Température corporelle (8310-5)
            est un nombre indénombrable s'exprimant en degrés Celsius (Cel) ou en degré Fahrenheit ([degF]).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;8302-2&#34;]) or (cda:code[@code=&#34;8302-2&#34;] and cda:value[@unit=&#34;m&#34; or  @unit=&#34;cm&#34; or @unit=&#34;[in_us]&#34; or @unit=&#34;[in_uk]&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la Taille (8302-2)
            est un nombre indénombrable s'exprimant en degrés mètres (m), en centimètres (cm),
            en inches US ([in_us]) ou en inches UK [in_uk].
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;8287-5&#34;]) or (cda:code[@code=&#34;8287-5&#34;] and cda:value[@unit=&#34;m&#34; or  @unit=&#34;cm&#34; or @unit=&#34;[in_us]&#34; or @unit=&#34;[in_uk]&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure du Périmètre crânien (8287-5)
            est un nombre indénombrable s'exprimant en degrés mètres (m), en centimètres (cm),
            en inches US ([in_us]) ou en inches UK [in_uk].
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;29463-7&#34;]) or (cda:code[@code=&#34;29463-7&#34;] and cda:value[@unit=&#34;kg&#34; or @unit=&#34;g&#34; or @unit=&#34;[lb_av]&#34; or @unit=&#34;[oz_av]&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure du Poids corporel (29463-7)
            est un nombre indénombrable s'exprimant en kilogrammes (kg), en grammes (g),
            en livres avoirdupois ([lb_av]) ou en onces avoirdupois [oz_av].
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:code[@code=&#34;39156-5&#34;]) or (cda:code[@code=&#34;39156-5&#34;] and cda:value[@unit=&#34;kg/m2&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : L'indice de masse corporelle (39156-5)
            est un nombre indénombrable s'exprimant en kilogrammes par m carré (kg/m2)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M148"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M148"/>
   <xsl:template match="@*|node()" priority="-2" mode="M148">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M148"/>
   </xsl:template>

   <!--PATTERN E_vitalSignsOrganizer_intIHE PCC v3.0 vital signs Organizer-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 vital signs Organizer</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.1']"
                 priority="1000"
                 mode="M149">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.1']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode='CLUSTER' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs 'CLUSTER' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.32']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir l'élément templateId avec l'attribut @root fixé à '2.16.840.1.113883.10.20.1.32' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1.35']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir l'élément templateId avec l'attribut @root fixé à '2.16.840.1.113883.10.20.1.35' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir l'élément templateId avec l'attribut @root fixé à '1.3.6.1.4.1.19376.1.5.3.1.4.13.1' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir au minimum trois éléments templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : vitalSignsOrganizer doit contenur un élement Id
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime[@value] or cda:effectiveTime[@nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
          [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir un élément "effectiveTime" avec l'attribut @value
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component[@typeCode='COMP']/cda:observation[@classCode='OBS' and @moodCode='EVN']/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.2']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir une ou plusieurs vital signs obseration (templateId : 1.3.6.1.4.1.19376.1.5.3.1.4.13.2) : 
            &lt;component typeCode='COMP'&gt; 
                &lt;observation classCode='OBS' moodCode='EVN'&gt;
                    &lt;templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.13.2'/&gt;
                   
               &lt;/observation&gt;
           &lt;/component&gt;
             
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M149"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M149"/>
   <xsl:template match="@*|node()" priority="-2" mode="M149">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M149"/>
   </xsl:template>

   <!--PATTERN E_updateInformationOrganizer_intPalm_Suppl_APSR V2.0 Update Information Organizer Entry-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Palm_Suppl_APSR V2.0 Update Information Organizer Entry</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.10.4.5&#34;]" priority="1000"
                 mode="M150">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.3.10.4.5&#34;]"/>
      <xsl:variable name="count_statusCode" select="count(cda:statusCode)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode='BATTERY' and @moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_updateInformationOrganizer_int.sch] Erreur de conformité APSR : L'élément "organizer" de l'entrée "Update Information Organizer" doit avoir les attributs @classCode et @moodCode fixés respectivement aux valeurs suivante 'BATTERY' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_statusCode = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_updateInformationOrganizer_int.sch] Erreur de conformité APSR : L'entrée "Update Information Organizer" doit contenir obligatoirement un élément statusCode (cardinalité [1..1])
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
            [E_updateInformationOrganizer_int.sch] Erreur de conformité APSR : L'attribut "code" de l'élément "statusCode" doit prendre la valeur 'completed'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M150"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M150"/>
   <xsl:template match="@*|node()" priority="-2" mode="M150">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M150"/>
   </xsl:template>

   <!--PATTERN E_mesuresDispositifsOculaires_intVérification de la conformité de l'entrée FR-Liste-des-mesures-de-dispositifs-oculaires aux spécifications IHE EYE CARE (GEE)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de l'entrée FR-Liste-des-mesures-de-dispositifs-oculaires aux spécifications IHE EYE CARE (GEE)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.5']"
                 priority="1000"
                 mode="M151">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.5']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode = 'CLUSTER' and @moodCode = 'EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDispositifsOculaires_int] Erreur de conformité : L'élément "organizer"
            doit contenir les attributs @classCode="CLUSTER" et @moodCode="EVN". 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = '1.3.6.1.4.1.19376.1.12.1.3.5']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDispositifsOculaires_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires
            doit contenir l'élément "templateId" avec l'attribut @root fixé à
            "1.3.6.1.4.1.19376.1.12.1.3.5". 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDispositifsOculaires_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires doit contenur un élement "id". 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDispositifsOculaires_int] Erreur de conformité : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires
            doit contenir un élément "code".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = 'completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDispositifsOculaires_int]
            Erreur de conformité IHE EYE CARE (GEE): L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires doit contenir l'élément "statusCode" avec
            l'attribut @code fixé à 'completed'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDispositifsOculaires_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires doit contenir un élément "effectiveTime" avec
            l'attribut @value
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.9'])&gt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDispositifsOculaires_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires
            doit contenir au minimum une entrée FR-Mesure-dispositif-oculaire (1.3.6.1.4.1.19376.1.12.1.3.9).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M151"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M151"/>
   <xsl:template match="@*|node()" priority="-2" mode="M151">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M151"/>
   </xsl:template>

   <!--PATTERN E_mesuresDispositifsOculairesObservation_intIHE IHE EYE CARE (GEE) v3.0 Lensometry Measurement Observations-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE IHE EYE CARE (GEE) v3.0 Lensometry Measurement Observations</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.3.9&#34;]" priority="1000"
                 mode="M152">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.3.9&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode = 'OBS' and @moodCode = 'EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) : l'élément "mesures de dispositifs oculaires Observation"
            doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs
            'OBS' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement Id 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = 'completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDispositifsOculairesObservation_int]
            Erreur de Conformité IHE EYE CARE (GEE) : l'élément "mesures de dispositifs oculaires Observation" doit contenir l'élément statusCode avec
            l'attribut @code fixé à 'completed'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime[@value] or cda:effectiveTime[@nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDispositifsOculairesObservation_int] Erreur de conformité IHE EYE CARE (GEE) : l'élément 'effectiveTime' doit être présent.
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
               <svrl:text> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement value 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:targetSiteCode[@nullFlavor or @code='MED-976']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement targetSiteCode avec l'attribut @nullFlavor ou @code 'MED-976' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:methodCode"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement methodCode 
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
               <svrl:text> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement author 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M152"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M152"/>
   <xsl:template match="@*|node()" priority="-2" mode="M152">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M152"/>
   </xsl:template>

   <!--PATTERN E_mesuresDeRefractionOrganizer_intVérification de la conformité de l'entrée FR-Liste-des-mesures-de-refraction aux
        spécifications IHE EYE CARE GEE-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de l'entrée FR-Liste-des-mesures-de-refraction aux
        spécifications IHE EYE CARE GEE</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.3']"
                 priority="1000"
                 mode="M153">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.3']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode = 'CLUSTER' and @moodCode = 'EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'élément "organizer" doit
            contenir les attributs @classCode="CLUSTER" et @moodCode="EVN". </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = '1.3.6.1.4.1.19376.1.12.1.3.3']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée
            FR-Liste-des-mesures-de-refraction doit contenir l'élément "templateId" avec l'attribut
            @root fixé à "1.3.6.1.4.1.19376.1.12.1.3.3". </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = '70938-6' and @codeSystem = '2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée
            FR-Liste-des-mesures-de-refraction doit contenir l'élément "code" avec les attributs
            @code="70938-6" et @codeSystem="2.16.840.1.113883.6.1".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = 'completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDeRefractionOrganizer_int]
            Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-refraction doit contenir
            l'élément "statusCode" avec l'attribut @code fixé à "completed".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime[@value] or cda:effectiveTime[@nullFlavor]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée
            FR-Liste-des-mesures-de-refraction doit contenir un élément "effectiveTime" avec
            l'attribut @value.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.7']) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée
            FR-Liste-des-mesures-de-refraction doit contenir au minimum une entrée FR-Mesure-de-refraction (1.3.6.1.4.1.19376.1.12.1.3.7).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M153"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M153"/>
   <xsl:template match="@*|node()" priority="-2" mode="M153">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M153"/>
   </xsl:template>

   <!--PATTERN E_mesureDeRefractionObservation_intIHE PCC v3.0 Refractive Measurement Observations-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Refractive Measurement Observations</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.3.7&#34;]" priority="1000"
                 mode="M154">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.12.1.3.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.12.1.3.7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'identifiant du template parent (1.3.6.1.4.1.19376.1.12.1.3.7) doit être présent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode = 'OBS' and @moodCode = 'EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :l'élément "mesure de refraction Observation"
            doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs
            'OBS' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir un élement Id 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = 'completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir l'élément statusCode avec l'attribut @code fixé à 'completed'
        </svrl:text>
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
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément 'effectiveTime' doit être présent.
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
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir un élement value 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:targetSiteCode"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesureDeRefractionObservation_int]  Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir un élement targetSiteCode 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:methodCode"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir un élement methodCode 
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
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" peut contenir un élement author [0..1].
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M154"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M154"/>
   <xsl:template match="@*|node()" priority="-2" mode="M154">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M154"/>
   </xsl:template>

   <!--PATTERN E_mesuresAcuiteVisuelle_intVérification de la conformité de l'entrée FR-Liste-des-mesures-acuite-visuelle-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de la conformité de l'entrée FR-Liste-des-mesures-acuite-visuelle</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.2']" priority="1000"
                 mode="M155">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.2']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode='CLUSTER' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelle_int] Erreur de conformité IHE EYE CARE (GEE) :
            L'élément "organizer" doit contenir les attributs @classCode="CLUSTER" et @moodCode="EVN".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.12.1.3.2']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelle_int] Erreur de conformité IHE EYE CARE (GEE) :
            L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenir l'élément "templateId" avec l'attribut @root fixé à "1.3.6.1.4.1.19376.1.12.1.3.3".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelle_int] Erreur de conformité IHE EYE CARE (GEE) :
            L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenur un élement "id".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = '70939-4' and @codeSystem = '2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelle_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenir l'élément "code" 
            avec les attributs @code="70939-4" et @codeSystem="2.16.840.1.113883.6.1".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = 'completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelle_int] Erreur de conformité IHE EYE CARE (GEE) :
            L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenir l'élément "statusCode" avec l'attribut @code fixé à 'completed'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime[@value]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelle_int] Erreur de conformité IHE EYE CARE (GEE) :
            L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenir un élément "effectiveTime" avec l'attribut @value.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(.//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.6'])&gt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelle_int] Erreur de conformité IHE EYE CARE (GEE) :
            L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenir au minimum une entrée FR-Mesure-acuite-visuelle (1.3.6.1.4.1.19376.1.12.1.3.6).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M155"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M155"/>
   <xsl:template match="@*|node()" priority="-2" mode="M155">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M155"/>
   </xsl:template>

   <!--PATTERN E_mesuresAcuiteVisuelleObservation_intIHE PCC v3.0 Visual Acuity Measurement Observations-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">IHE PCC v3.0 Visual Acuity Measurement Observations</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34; 1.3.6.1.4.1.19376.1.12.1.3.6&#34;]" priority="1000"
                 mode="M156">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34; 1.3.6.1.4.1.19376.1.12.1.3.6&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.12.1.3.6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) : 
            l'identifiant du template parent ( 1.3.6.1.4.1.19376.1.12.1.3.6) doit être présent. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode = 'OBS' and @moodCode = 'EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) : l'élément "mesure d'acuité visuelle corrigée Observation"
            doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs
            'OBS' et 'EVN'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) :
            l'élément "mesure d'acuité visuelle corrigée Observation" doit contenir un élement Id 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = 'completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) : 
            l'élément "mesure d'acuité visuelle corrigée Observation" doit contenir l'élément statusCode avec l'attribut @code fixé à 'completed'
        </svrl:text>
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
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) : 
            l'élément 'effectiveTime' doit être présent.
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
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) : 
            l'élément "mesure d'acuité visuelle corrigée Observation" doit contenir un élement value 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:targetSiteCode"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) :
            l'élément "mesure d'acuité visuelle corrigée Observation" doit contenir un élement targetSiteCode 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:methodCode"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) : 
            l'élément "mesure d'acuité visuelle corrigée Observation" doit contenir un élement methodCode 
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
            [E_mesuresAcuiteVisuelleObservation_int] Erreur de conformité IHE EYE CARE (GEE) : 
            l'élément "mesure d'acuité visuelle corrigée Observation" doit contenir un élement author 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M156"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M156"/>
   <xsl:template match="@*|node()" priority="-2" mode="M156">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M156"/>
   </xsl:template>
</xsl:stylesheet>