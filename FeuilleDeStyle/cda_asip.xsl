<?xml version="1.0" encoding="utf-8"?>
<!--
  Title : cda_asip.xsl
  =======================================================================================================================================================
  This StyleSheet is based on the StyleSheet "Modular CDA XSL StyleSheet (cda_modular.xsl)" made by Alchuler Associates LCC.
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
  =======================================================================================================================================================
  Suivi des version de la feuille de style française (ANS) :
    - The original StyleSheet has been modified for FRANCE in order to :
         - Translate the labels from english to french
         - Display observationMedia images
         - Edit supplementary informations
         - Detect a Xades envelopping signature of a Clinical Document
         - Add comments in case of impossibility to edit pdf files in nonXMLBody and within structuredBody with IE/EDGE and Firefox 3.x
         - Be able to supersede the inner stylesheet of a self-presented document (Oct 30, 2012)
    - Version : 1.3.0.2 (16/06/2015)
    - Version : 1.4 (30/12/2019) : modification de l'ordre de la présentation des informations de l'en-tête
  =======================================================================================================================================================
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:n1="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:data="urn:asip-sante:ci-sis" xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
	xmlns:xad="http://uri.etsi.org/01903/v1.2.2#" exclude-result-prefixes="n1 xsi data ds xad">
	<xsl:import href="headers.xsl"/>
	<xsl:import href="style.xsl"/>
	<xsl:output method="html" indent="yes" version="4.01" encoding="utf-8"
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
			<xsl:when test="$title-sign = ''">
				<xsl:choose>
					<xsl:when test="string-length(n1:ClinicalDocument/n1:title) &gt;= 1">
						<xsl:value-of select="n1:ClinicalDocument/n1:title"/>
					</xsl:when>
					<xsl:when test="n1:ClinicalDocument/n1:code/@displayName">
						<xsl:value-of select="n1:ClinicalDocument/n1:code/@displayName"/>
					</xsl:when>
					<xsl:when
						test="string-length(xsl:stylesheet/data:Contenu/n1:ClinicalDocument/n1:title) &gt;= 1">
						<xsl:value-of
							select="xsl:stylesheet/data:Contenu/n1:ClinicalDocument/n1:title"/>
					</xsl:when>
					<xsl:when
						test="xsl:stylesheet/data:Contenu/n1:ClinicalDocument/n1:code/@displayName">
						<xsl:value-of
							select="xsl:stylesheet/data:Contenu/n1:ClinicalDocument/n1:code/@displayName"
						/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Document médical</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when
						test="string-length(/ds:Signature/ds:Object/n1:ClinicalDocument/n1:title) &gt;= 1">
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
	<xsl:template match="link">
		<xsl:element name="a">
			<xsl:for-each select="link_html/@*">
				<xsl:if test='not(name() = "originator" or name() = "confidentiality")'>
					<xsl:attribute name="{name()}">
						<xsl:value-of select="."/>
					</xsl:attribute>
				</xsl:if>
			</xsl:for-each>
			<xsl:value-of select="link_html"/>
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
				<!-- A FAIRE -->
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<title>
					<xsl:value-of select="$title"/>
				</title>
				<link rel="stylesheet" type="text/css" href="../FeuilleDeStyle/cda.css"/>
				<!--<script>
					// Boutton Plier/Déplier
					function displayMenu() {
						var targetDiv = document.getElementById('structuredBodyId');
						var list_item = document.getElementById("ul_o").getElementsByTagName("li");
						if (targetDiv.style.display !== "none") {
							targetDiv.style.display = "none";
							document.getElementById('deplierId').innerHTML = 'Plier tout';
							for (var item in list_item) {
								if(list_item[item].style  != undefined) {
									list_item[item].style.display = "block";
								}
							}
						
						} else {
							targetDiv.style.display = "block";
							document.getElementById('deplierId').innerHTML = 'Déplier tout';
							for (var item in list_item) {
								if(list_item[item].style  != undefined) {
									list_item[item].style.display = "none";
								}
							}
						}
					};
					// Ouvrir/Fermer Menu Table des matières
					function openCloseCollapse() {
						var list_item = document.getElementById("ul_o").getElementsByTagName("li");
						for (var item in list_item) {
							if(list_item[item].style  != undefined) {
								if(list_item[item].style.display == "none"){
									list_item[item].style.display = "block";
								}
								else {
									list_item[item].style.display = "none";
								}
							}	
						}
					};
					// Afficher le lien href dans le cas ou le plie est activé
					function displayHref() {
						document.getElementById('structuredBodyId').style.display = "block";
						document.getElementById('deplierId').innerHTML = 'Déplier tout';
					};
				</script>-->
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
						<td id="td">
							<table>
								<tr>
									<td>
										<xsl:call-template name="recordTarget"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="authorization"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="informant"/>
									</td>
								</tr>
							</table>
						</td>

						<td id="td">
							<table>
								<tr>
									<td>
										<xsl:call-template name="documentationOf"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="componentof"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="inFulfillmentOf"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="participant"/>
									</td>
								</tr>
							</table>
						</td>
						<td id="td">
							<table>
								<tr>
									<td>
										<xsl:call-template name="author"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="authenticator"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="dataEnterer"/>
									</td>
								</tr>
							</table>
						</td>
						<td id="td">
							<table>
								<tr>
									<td>
										<xsl:call-template name="documentGeneral"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="legalAuthenticator"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="custodian"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="informationRecipient"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<!-- END display top portion of clinical document -->
				<!--  -->
				<!-- produce table of contents -->
				<hr align="left" size="2" color="#003366" id="hr" />
				<xsl:if test="n1:component/n1:structuredBody">
					<xsl:call-template name="make-tableofcontents"/>
				</xsl:if>
				<hr align="left" color="#003366" size="2" width="80%"/>
				<!-- produce human readable document content -->
				<xsl:apply-templates
					select="n1:component/n1:structuredBody|n1:component/n1:nonXMLBody"/>
				<br/>
				<hr align="left" color="teal" size="2" width="80%"/>
				<br/>
				<!--<xsl:call-template name="make-collapseAll"/>-->
			</body>
		</html>
	</xsl:template>
	<!-- generate table of contents -->
	<xsl:template name="make-tableofcontents">
		<ul class="ul">
			<label for="collapse" class="label">Table des matières</label>
			<input type="checkbox" id="collapse"/>
			<div id="details">
				<xsl:for-each
					select="n1:component/n1:structuredBody/n1:component/n1:section/n1:title">
					<li class="li">
						<a href="#{generate-id(.)}" class="href">
							<xsl:value-of select="."/>
						</a>
					</li>
				</xsl:for-each>
			</div>
		</ul>
	</xsl:template>
	<!-- generate show hide contents -->
	<xsl:template name="make-collapseAll">
		<ul class="ul">
			<label for="collapseId" class="label" id="depiler">Déplier/Plier Section</label>
		</ul>
		<input type="checkbox" id="collapseId"/>
		<hr align="left" size="2" id="hr1" color="#003366"/>
		<br/>
		<div id="one">
			<xsl:for-each
				select="n1:component/n1:structuredBody/n1:component/n1:section/n1:title">
				<li class="li">
					<a href="#{generate-id(.)}" class="href1">
						<i class="next"></i><span class="span" />
						<xsl:value-of select="."/>
					</a>
				</li>
			</xsl:for-each>
		</div>
		<div id="two">
			<xsl:apply-templates
				select="n1:component/n1:structuredBody | n1:component/n1:nonXMLBody"/>
		</div>
		<br/>
		<hr align="left" size="2" color="#003366" id="hr" />
	</xsl:template>
</xsl:stylesheet>
