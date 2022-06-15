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
                              title="Vérification de conformité du document au modèle CR-BIO_2021.01"
                              schemaVersion="CI-SIS_CR-BIO_2021.01.sch">
         <xsl:attribute name="phase">CI-SIS_CR-BIO_2021.01</xsl:attribute>
         <xsl:attribute name="document">
            <xsl:value-of select="document-uri(/)"/>
         </xsl:attribute>
         <xsl:attribute name="dateHeure">
            <xsl:value-of select="format-dateTime(current-dateTime(), '[D]/[M]/[Y] à [H]:[m]:[s] (temps UTC[Z])')"/>
         </xsl:attribute>
         <xsl:text/>
         <svrl:active-pattern>
            <xsl:attribute name="id">Entete_CR-BIO</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention</xsl:attribute>
            <svrl:text>Vérification de la conformité d'une section de 1er niveau FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60)</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_FR-Resultats-examens-de-biologie-medicale</xsl:attribute>
            <svrl:text>Vérification de la conformité d'une entrée FR-Resultats-examens-de-biologie-medicale (1.3.6.1.4.1.19376.1.3.1)</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_FR-Batterie-examens-de-biologie-medicale</xsl:attribute>
            <svrl:text>Vérification de la conformité d'une entrée FR-Batterie-examens-de-biologie-medicale (1.3.6.1.4.1.19376.1.3.1.4)</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_FR-Isolat-microbiologique</xsl:attribute>
            <svrl:text>Vérification de la conformité d'une entrée FR-Isolat-microbiologique (1.3.6.1.4.1.19376.1.3.1.5)</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_FR-Laboratoire-executant</xsl:attribute>
            <svrl:text>Vérification de la conformité d'une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7)</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_FR-Prelevement</xsl:attribute>
            <svrl:text>Vérification de la conformité d'une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2)</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_FR-Resultat-examens-de-biologie-element-clinique-pertinent</xsl:attribute>
            <svrl:text>Vérification de la conformité d'une entrée FR-Resultat-examens-de-biologie-element-clinique-pertinent (1.3.6.1.4.1.19376.1.3.1.6)</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">JDV_BIO_Interpretation-CISIS</xsl:attribute>
            <svrl:text>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</svrl:text>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">variables</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Vérification de conformité du document au modèle CR-BIO_2021.01</svrl:text>

   <!--PATTERN Entete_CR-BIO-->


	<!--RULE -->
<xsl:template match="cda:ClinicalDocument" priority="1005" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="cda:ClinicalDocument"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:setId"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'élément setId est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title = &#34;Compte rendu d'examens biologiques&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'élément title est obligatoire et doit être fixé à "Compte rendu d'examens biologiques".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code=&#34;11502-2&#34; and @displayName=&#34;CR d'examens biologiques&#34; and @codeSystem=&#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'élément code est obligatoire et doit être fixé à @code="11502-2" @displayName="CR d'examens biologiques" @codeSystem="2.16.840.1.113883.6.1".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.3.3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'élément templateId fixé à @root="1.3.6.1.4.1.19376.1.3.3" est obligatoire
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument/cda:recordTarget/cda:patientRole" priority="1004"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:addr[@nullFlavor]) or cda:addr[@nullFlavor=&#34;UNK&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Si aucune adresse n’est connue, utiliser la valeur nullFlavor='UNK'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:telecom[@nullFlavor]) or cda:telecom[@nullFlavor=&#34;UNK&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Si aucune coordonnée n’est connue, utiliser la valeur nullFlavor='UNK'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:patient/cda:administrativeGenderCode[@nullFlavor]) or cda:patient/cda:administrativeGenderCode[@nullFlavor=&#34;UNK&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Si le sexe n’est pas connu, utiliser la valeur nullFlavor='UNK'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:patient/cda:birthTime[@nullFlavor]) or cda:patient/cda:birthTime[@nullFlavor=&#34;UNK&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Si la date de naissance n’est pas connue, utiliser la valeur nullFlavor='UNK'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument/cda:authenticator" priority="1003" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:ClinicalDocument/cda:authenticator"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.1.5']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Le templateId "1.3.6.1.4.1.19376.1.3.3.1.5" de l'élément authenticator est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:time"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] La date de la dernière validation effectuée par le biologiste médical est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:addr"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'adresse du biologiste ayant validé des résultats est obligatoire dans l'élément authenticator.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:telecom"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Les coordonnées telecom du biologiste ayant validé des résultats sont obligatoires dans l'élément authenticator.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:assignedEntity/cda:representedOrganization/cda:id) or not (cda:assignedEntity/cda:representedOrganization)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'identifiant du laboratoire est obligatoire dans l'élément authenticator/assignedEntity/representedOrganization/id.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:assignedEntity/cda:representedOrganization/cda:name) or not (cda:assignedEntity/cda:representedOrganization)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Le nom du laboratoire est obligatoire dans l'élément authenticator/assignedEntity/representedOrganization/name.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:assignedEntity/cda:representedOrganization/cda:telecom) or not (cda:assignedEntity/cda:representedOrganization)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Les coordonnées telecom du laboratoire sont obligatoires dans l'élément authenticator/assignedEntity/representedOrganization/telecom.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cda:assignedEntity/cda:representedOrganization/cda:addr) or not (cda:assignedEntity/cda:representedOrganization)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'adresse du laboratoire est obligatoire dans l'élément authenticator/assignedEntity/representedOrganization/addr.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent"
                 priority="1002"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Le code de l'acte documenté est obligatoire dans l'élément documentationOf/serviceEvent/code.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/cda:performer"
                 priority="1001"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/cda:performer"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:time"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] La date d'exécution de l'acte documenté est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:addr"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'Adresse du directeur du laboratoire est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:telecom"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Les Coordonnées télécom du directeur du laboratoire sont obligatoires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:assignedPerson/cda:name"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Le nom du directeur de laboratoire est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:representedOrganization/cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'identifiant du laboratoire est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:representedOrganization/cda:name"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Le nom du laboratoire est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:representedOrganization/cda:telecom"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Les coordonnées telecom du laboratoire sont obligatoires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:representedOrganization/cda:addr"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'adresse du laboratoire est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:representedOrganization/cda:standardIndustryClassCode"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] Le cadre d'exercice du laboratoire est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:responsibleParty/cda:assignedEntity/cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'identifiant du biologiste responsable doit être présent (responsibleParty/assignedEntity/id)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:responsibleParty/cda:assignedEntity/cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] La profession/spécialité du biologiste responsable doit être présente (responsibleParty/assignedEntity/code)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:responsibleParty/cda:assignedEntity/cda:assignedPerson/cda:name/cda:family"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [Entete_CR-BIO] L'identité du biologiste responsable doit être présente (responsibleParty/assignedEntity/assignedPerson/name/family)
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

   <!--PATTERN S_FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.2.250.1.213.1.1.2.60']" priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.60']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [S_FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention] Erreur de conformité :
            Une section FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60) doit comporter un élément code. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

   <!--PATTERN E_FR-Resultats-examens-de-biologie-medicale-->


	<!--RULE -->
<xsl:template match="cda:entry/cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']"
                 priority="1006"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:entry/cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../@typeCode"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité :
            un élément entry d'un CR de biologie doit comporter l'attribut typeCode. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:act and              (../cda:act/cda:code[@codeSystem = '2.16.840.1.113883.6.1'] or not(../cda:act/cda:code/@code))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité :
            Un élément entry doit avoir un élément fils act et le code de cet act s'il existe,
            doit appartenir à la terminologie LOINC. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:act/cda:statusCode[@code = 'completed'] or                 ../cda:act/cda:statusCode[@code = 'active'] or                 ../cda:act/cda:statusCode[@code = 'aborted']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité :
            Un élément entry doit avoir un élément fils act avec un statusCode@code valant 
            'completed', 'active' ou 'aborted'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:act/cda:entryRelationship[@typeCode = 'COMP']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : 
            Un élément entry doit avoir au moins un petit fils act/entryRelationship
            avec un attribut typeCode valant 'COMP'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:observation"
                 priority="1005"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:observation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code and @codeSystem='2.16.840.1.113883.6.1' and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:observation/cda:code/cda:translation"
                 priority="1004"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:observation/cda:code/cda:translation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation"
                 priority="1003"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code and @codeSystem='2.16.840.1.113883.6.1' and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité CR-BIO : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation/cda:code/cda:translation"
                 priority="1002"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation/cda:code/cda:translation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation"
                 priority="1001"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code and @codeSystem='2.16.840.1.113883.6.1' and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation/cda:code/cda:translation"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation/cda:code/cda:translation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
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

   <!--PATTERN E_FR-Batterie-examens-de-biologie-medicale-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.1.4']" priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.1.4']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer and @classCode = 'BATTERY' and @moodCode = 'EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Batterie-examens-de-biologie-medicale] Erreur de conformité : 
            Une entrée FR-Batterie-examens-de-biologie-medicale ('1.3.6.1.4.1.19376.1.3.1.4') doit avoir un classCode='BATTERY' et un moodCode='EVN'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:statusCode[@code = 'completed'] or             ./cda:statusCode[@code = 'active'] or             ./cda:statusCode[@code = 'aborted']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Batterie-examens-de-biologie-medicale] Erreur de conformité :
            Une entrée FR-Batterie-examens-de-biologie-medicale ('1.3.6.1.4.1.19376.1.3.1.4') doit avoir un statusCode@code 'completed', 'active' ou 'aborted'. 
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

   <!--PATTERN E_FR-Isolat-microbiologique-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1.5']" priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1.5']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer and @classCode = 'CLUSTER' and @moodCode = 'EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Isolat-microbiologique] Erreur de conformité :
            Un isolat biologique dans une entry (1.3.6.1.4.1.19376.1.3.1.5)
            doit être un organizer de classCode CLUSTER et de moodCode EVN. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode[@code = 'completed'] or                     cda:statusCode[@code = 'active'] or                     cda:statusCode[@code = 'aborted']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Isolat-microbiologique] Erreur de conformité :
            Un isolat biologique doit avoir un statusCode@code valant 'completed', 'active' ou 'aborted'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:specimen[@typeCode='SPC']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Isolat-microbiologique] Erreur de conformité : 
            Un isolat d'une entry d'un CR d'examens biologiques doit comporter un élément fils 'specimen', de typeCode 'SPC'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:specimen/cda:specimenRole[@classCode='SPEC']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Isolat-microbiologique] Erreur de conformité : 
            Un isolat d'une entry d'un CR d'examens biologiques doit comporter un specimen/specimenRole, de typeCode 'SPEC'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:specimen/cda:specimenRole/cda:specimenPlayingEntity[@classCode='MIC']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Isolat-microbiologique] Erreur de conformité : 
            Un isolat d'une entry d'un CR d'examens biologiques doit comporter un specimen/specimenRole/playingEntity de classCode 'MIC'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:specimen/cda:specimenRole/cda:specimenPlayingEntity/cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Isolat-microbiologique] Erreur de conformité : 
            Un isolat d'une entry d'un CR d'examens biologiques doit comporter un specimen/specimenRole/playingEntity/code. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:performer) or cda:performer[@typeCode='PRF']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Isolat-microbiologique] Erreur de conformité :
            Si un isolat d'une entry d'un CR d'examens biologiques spécifie un exécutant, ce doit être un élément fils performer de type 'PRF'. 
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

   <!--PATTERN E_FR-Laboratoire-executant-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.3.1.7']" priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.3.1.7']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:performer"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Laboratoire-executant] Erreur de conformité :
            Un exécutant dans une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7) doit être un performer. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:assignedEntity/cda:representedOrganization/cda:id and                     cda:assignedEntity/cda:representedOrganization/cda:name"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Laboratoire-executant] Erreur de conformité :
            Dans une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7), les éléments assignedEntity/representedOrganization/id
            et assignedEntity/representedOrganization/name sont obligatoires. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:time"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Laboratoire-executant] Erreur de conformité :
            Dans une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7), l'élément time est obligatoire.
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

   <!--PATTERN E_FR-Prelevement-->


	<!--RULE -->
<xsl:template match="cda:procedure[./cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1.2']"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:procedure[./cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1.2']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:participant[@typeCode = 'PRD' and ./cda:participantRole/@classCode = 'SPEC']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Prelevement] Erreur de conformité :
            Une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2) doit comporter un participant de typeCode 'PRD'
            avec un fils participantRole de classCode 'SPEC'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="             (count(./cda:entryRelationship/cda:act/cda:code[@code = 'SPRECEIVE' and @codeSystem = '1.3.5.1.4.1.19376.1.5.3.2']) = 1 and             ./cda:entryRelationship/cda:act/cda:effectiveTime/@value) or             not(./cda:entryRelationship/cda:act/cda:code[@code = 'SPRECEIVE'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Prelevement] Erreur de conformité :
            Une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2), si elle comporte l'acte "Réception de l'échantillon au laboratoire"
            doit alors préciser la date et heure de réception de l'échantillon à l'aide d'un effectiveTime@value. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="             ./cda:entryRelationship/cda:act[./cda:code/@code = 'SPRECEIVE' and                                              ./cda:code/@codeSystem = '1.3.5.1.4.1.19376.1.5.3.2' and                                             ./cda:effectiveTime/@value] or             not(./cda:entryRelationship/cda:act/cda:code[@code = 'SPRECEIVE'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_FR-Prelevement] Erreur de conformité :
            Une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2), si elle comporte l'acte "Réception de l'échantillon au laboratoire"
            doit alors préciser la date et heure de réception de l'échantillon à l'aide d'un effectiveTime@value. 
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

   <!--PATTERN E_FR-Resultat-examens-de-biologie-element-clinique-pertinent-->


	<!--RULE -->
<xsl:template match="cda:observation[./cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.1.6']"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation[./cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.1.6']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@moodCode = 'EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            Un résultat dans une entry (avec templateId '1.3.6.1.4.1.19376.1.3.1.6')
            doit avoir un @moodCode 'EVN'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:statusCode[@code = 'completed'] or ./cda:statusCode[@code = 'aborted']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            Un résultat doit avoir un statusCode@code valant 'completed' ou 'aborted'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:entryRelationship[@typeCode = 'REFR']/cda:observation/cda:effectiveTime or                       not(./cda:entryRelationship[@typeCode = 'REFR'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [[E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            L'antériorité d'un résultat doit obligatoirement être horodatée avec un élément effectiveTime. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:entryRelationship[@typeCode = 'REFR']/cda:observation/cda:statusCode[@code = 'completed'] or             not(./cda:entryRelationship[@typeCode = 'REFR'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            L'antériorité d'un résultat est obligatoirement au statusCode 'completed'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(./cda:referenceRange) =1 or not(./cda:referenceRange)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            L'intervalle de référence d'un résultat doit être présente au maximum une fois 
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

   <!--PATTERN JDV_BIO_Interpretation-CISIS-->


	<!--RULE -->
<xsl:template match="cda:observation/cda:interpretationCode" priority="1000" mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:observation/cda:interpretationCode"/>
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
                  <xsl:value-of select="observation/interpretationCode"/>
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
                  <xsl:value-of select="observation/interpretationCode"/>
                  <xsl:text/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($JDV_BIO_Interpretation-CISIS)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
        
            [dansJeuDeValeurs] L'élément <xsl:text/>
                  <xsl:value-of select="observation/interpretationCode"/>
                  <xsl:text/>
            [<xsl:text/>
                  <xsl:value-of select="$att_code"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_displayName"/>
                  <xsl:text/>:<xsl:text/>
                  <xsl:value-of select="$att_codeSystem"/>
                  <xsl:text/>] 
            doit faire partie du jeu de valeurs <xsl:text/>
                  <xsl:value-of select="$JDV_BIO_Interpretation-CISIS"/>
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

   <!--PATTERN variables-->
<xsl:variable name="JDV_BIO_Interpretation-CISIS"
                 select="'../jeuxDeValeurs/JDV_BIO_Interpretation-CISIS.xml'"/>

	  <!--RULE -->
<xsl:template match="cda:ClinicalDocument" priority="1001" mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="cda:ClinicalDocument"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : L'élément clinicalDocument/templateId doit être présent avec @root='1.3.6.1.4.1.19376.1.3.3'.
			</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:code[@code='11502-2' and @codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : L'élément code doit égal à @code='11502-2' et @codeSystem='2.16.840.1.113883.6.1'.
			</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="./cda:versionNumber[@value] and number(./cda:versionNumber/@value) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : L'élément "versionNumber" doit être présent dans l'en-tête, avec un attribut @value contenant un entier positif.
			</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(./cda:versionNumber[@nullFlavor])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : L'attribut nullFlavor est interdit pour l'élément "versionNumber".
			</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cda:structuredBody/cda:component/cda:section" priority="1000" mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="cda:structuredBody/cda:component/cda:section"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(./cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.2.1']) or (./cda:templateId[@root='1.2.250.1.213.1.1.2.60']) or (./cda:templateId[@root='1.3.6.1.4.1.19376.1.4.1.2.16'])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : un CR-BIO ne peut comporter que les sections de niveau 1 suivantes : FR-CR-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.1), 
				FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60) et FR-Commentaire-non-code (1.3.6.1.4.1.19376.1.4.1.2.16)
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
</xsl:stylesheet>