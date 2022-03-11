<?xml version="1.0" encoding="UTF-8"?>
<!--
  Title : selectCDA.xsl - F.Macary 
  Contexte :
  		Un document électronique CDA conforme au CI-SIS peut être éventuellement signé et/ou auto-présentable.
  		Dans ces cas particuliers l'élément racine n'est pas <ClinicalDocument> 
  But : 
  		Sélection et envoi vers la sortie du sous-arbre <ClinicalDocument> 
  Utilisation :
  		Cette feuille de style est utilisée avant l'appel de la validation CDA et de la vérification de conformité schématron,
  		pour produire dans le sous-répertoire moteur/tmp un document intermédiaire ne contenant que le sous-arbre ClinicalDocument, 
  		qui sera soumis à la validation xsd et schématron 
    09/10/12 : FMA : Création 
    17/10/12 : FMA : Mise au point et integration dans les scripts compilverif.bat et verif.bat
    29/10/12 : FMA : Prise en compte des documents auto-présentables associant les éléments CDA à un préfixe représentant urn:hl7-org:v3
    08/04/13 : FMA : Simplification
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:c="urn:hl7-org:v3">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/> 
	<xsl:template match="xsl:stylesheet">
	<xsl:apply-templates select="//ClinicalDocument | //c:ClinicalDocument"/> 	
	</xsl:template>
	<!-- Extraction du sous-arbre ClinicalDocument -->
	<xsl:template match="c:ClinicalDocument">
		<ClinicalDocument xmlns="urn:hl7-org:v3" 
			xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2" 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">	
			<xsl:for-each select="*">
				<xsl:copy-of select="." copy-namespaces="no"/>
			</xsl:for-each>	
		</ClinicalDocument>
	</xsl:template>
	<!-- 
	Traitement des documents dont ClinicalDocument ne serait pas associé au namespace urn:hl7-org:v3, ce qui ne doit pas arriver 
	<xsl:template match="ClinicalDocument">
		<ClinicalDocument xmlns="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 	xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2">	
			<xsl:apply-templates/>
		</ClinicalDocument>
	</xsl:template>
	<xsl:template match="*">
		<xsl:element name="{local-name()}" namespace="urn:hl7-org:v3">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	-->	
</xsl:stylesheet>	