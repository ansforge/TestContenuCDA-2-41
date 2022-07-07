<?xml version="1.0" encoding="utf-8"?>
<!--
  Title : cda_asip.xsl
  Version : 1.3.0.2
  Date de mise à jour 16/06/2015
  This StyleSheet is based on the StyleSheet "Modular CDA XSL StyleSheet (cda_modular.xsl)" made by Alchuler Associates LCC.
  The original StyleSheet has been modified by ASIP Santé (http://www.asipsante.fr) in order to :
  - Translate the labels from english to french
  - display observationMedia images
  - Edit supplementary informations
  - Detect a Xades envelopping signature of a Clinical Document
  - add comments in case of impossibility to edit pdf files in nonXMLBody and within structuredBody with IE/EDGE and Firefox 3.x
  - be able to supersede the inner stylesheet of a self-presented document (Oct 30, 2012)

  Below is the original declaration of Alschuler Associates LCC
  Title: Modular CDA XSL StyleSheet
  Original Filename: cda_modular.xsl 
  Intended for use with: headers.xsl, style.xsl, utility.xsl, cda.css
  Version: 3.0
  Revision History: 8/12/09 Jingdong Li updated 
  Specification: ANSI/HL7 CDA, R2-2005  
  The current version and documentation are available at www.alschulerassociates.com/cda/?topic=cda-xsl. 
  We welcome feedback to tools@alschulerassociates.com
  The stylesheet is the cumulative work of several developers; the most significant prior milestones were the foundation work from HL7 
  Germany and Finland (Tyylitiedosto) and HL7 US (Calvin Beebe), and the presentation approach from Tony Schaller, medshare GmbH provided at IHIC 2009. 
-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:n1="urn:hl7-org:v3" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:data="urn:asip-sante:ci-sis"
	xmlns:ds="http://www.w3.org/2000/09/xmldsig#" 
	xmlns:xad="http://uri.etsi.org/01903/v1.2.2#"
	exclude-result-prefixes="n1 xsi data ds xad">
	<xsl:import href="headers_CRBIO.xsl"/>
	<xsl:import href="style_CRBIO.xsl"/>
	<xsl:output method="html" indent="yes" version="4.01" encoding="UTF-8"
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"
		doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<!-- global variable title -->
	<!-- Titre Signature -->
	<xsl:variable name="title-sign">
		<xsl:choose>
			<xsl:when test="string-length(/ds:Signature/@Id) &gt;= 1">
				<xsl:text>Ce document est signé électroniquement. Utilisez un logiciel de vérification de signature pour vérifier la validité de cette signature </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- global variable title -->
	<xsl:variable name="title">
		<xsl:choose>
			<xsl:when test=" $title-sign='' ">
				<xsl:choose>
					<xsl:when test="string-length(n1:ClinicalDocument/n1:title)  &gt;= 1">
						<xsl:value-of select="n1:ClinicalDocument/n1:title"/>
					</xsl:when>
					<xsl:when test="n1:ClinicalDocument/n1:code/@displayName">
						<xsl:value-of select="n1:ClinicalDocument/n1:code/@displayName"/>
					</xsl:when>
					<xsl:when test="string-length(xsl:stylesheet/data:Contenu/n1:ClinicalDocument/n1:title)  &gt;= 1">
						<xsl:value-of select="xsl:stylesheet/data:Contenu/n1:ClinicalDocument/n1:title"/>
					</xsl:when>
					<xsl:when test="xsl:stylesheet/data:Contenu/n1:ClinicalDocument/n1:code/@displayName">
						<xsl:value-of select="xsl:stylesheet/data:Contenu/n1:ClinicalDocument/n1:code/@displayName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Document médical</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when
						test="string-length(/ds:Signature/ds:Object/n1:ClinicalDocument/n1:title)  &gt;= 1">
						<xsl:value-of select="/ds:Signature/ds:Object/n1:ClinicalDocument/n1:title"
						/>
					</xsl:when>
					<xsl:when
						test="/ds:Signature/ds:Object/n1:ClinicalDocument/n1:code/@displayName">
						<xsl:value-of
							select="/ds:Signature/ds:Object/n1:ClinicalDocument/n1:code/@displayName"
						/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Document médical</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- Main -->
	<xsl:template match="ds:SignedInfo"/> 
	<xsl:template match="ds:SignatureValue"/> 
	<xsl:template match="ds:KeyInfo"/> 
	<xsl:template match="xad:*"/> 
	<xsl:template match="xsl:template"/> 
	
	<!--
		turn the link_html subelement into an HTML a element,
		complete with any attributes and content it may have,
		while stripping off any CDA specific attributes
	-->
	<xsl:template match='link'>
		<xsl:element name='a'>
			<xsl:for-each select='link_html/@*'>
				<xsl:if test='not(name()="originator" or name()="confidentiality")'>
					<xsl:attribute name='{name()}'>
						<xsl:value-of select='.'/>
					</xsl:attribute>
				</xsl:if>
			</xsl:for-each>
			<xsl:value-of select='link_html'/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="n1:ClinicalDocument">
		<html>
			<xsl:comment> Do not edit this HTML directly, it was generated by an XSLT transformation
				from a source CDA document. The stylesheet which produced this display of the CDA
				document was most recently updated by Jingdong Li, AALLC, on November 13, 2008. The
				current version and documentation are always available at
				www.alschulerassociates.com/cda/?topic=cda-tools. We welcome feedback to
				___@alschulerassociates.com The stylesheet is the cumulative work of several
				developers; the most significant prior milestones were the foundation work from HL7
				Finland (Tyylitiedosto) and HL7 US (Calvin Beebe), and the presentation approach
				from [[the Swiss]]. </xsl:comment>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title>
					<xsl:value-of select="$title"/>
				</title>
				
				<link rel="stylesheet" type="text/css" href="cda_CRBIO.css"/>
			</head>
			<body>
				<h1 class="h1center">
					<xsl:value-of select="$title"/>
				</h1>
				<h3>
					<xsl:value-of select="$title-sign"/>
				</h3>
				<br/>
				<!-- START display top portion of clinical document -->
				<table class="table_generale">
	
					<tr>
						<td>
							<tr><xsl:call-template name="recordTarget"/></tr>
							<tr><xsl:call-template name="authorization"/></tr>
						</td>
						<td>
							<tr><xsl:call-template name="documentationOf"/></tr>
							<tr><xsl:call-template name="componentof"/></tr>
							<tr><xsl:call-template name="inFulfillmentOf"/></tr>							
						</td>					
						<td>
							<tr><xsl:call-template name="legalAuthenticator"/></tr>
							<tr><xsl:call-template name="custodian"/></tr>
							<tr><xsl:call-template name="authenticator"/></tr>
							<tr><xsl:call-template name="dataEnterer"/></tr>
						</td>
						<td><xsl:call-template name="documentGeneral"/></td>
					</tr>
					<tr>
						<td><xsl:call-template name="informant"/></td>
						<td><xsl:call-template name="participant"/></td>
						<td><xsl:call-template name="author"/></td>
						<td><xsl:call-template name="informationRecipient"/></td>
					</tr>
				</table>
				<!-- END display top portion of clinical document -->
				

				<!-- produce table of contents -->
				<hr align="left" color="#003366" size="2" width="80%"/>
				<xsl:call-template name="make-tableofcontents"/>
				<hr align="left" color="#003366" size="2" width="80%"/>
				<!-- produce human readable document content -->
				<xsl:apply-templates
					select="n1:component/n1:structuredBody|n1:component/n1:nonXMLBody"/>
				<br/>
				<hr align="left" color="teal" size="2" width="80%"/>
				<br/>
			</body>
		</html>
	</xsl:template>
	<!-- generate table of contents -->
	<xsl:template name="make-tableofcontents">
		<h2>
			<a name="toc">Table des matières</a>
		</h2>
		<ul>
			<xsl:for-each select="n1:component/n1:structuredBody/n1:component/n1:section/n1:title">
				<li>
					<a href="#{generate-id(.)}">
						<xsl:value-of select="."/>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>
