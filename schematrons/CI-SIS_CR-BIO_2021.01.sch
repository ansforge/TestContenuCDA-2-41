<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   CI-SIS_CR-BIO_2021.01.sch 
   auteur : ANS
   ......................................................................................................................................................    
   Historique :
   26/02/2021 : Création
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_CR-BIO_2021.01"
	xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CR-BIO_2021.01.sch">
	
	<title>Vérification de conformité du document au modèle CR-BIO_2021.01</title>
	<ns prefix="cda" uri="urn:hl7-org:v3"/>
	<ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
	<ns prefix="jdv" uri="http://esante.gouv.fr"/>
	<ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
	
	<!-- Abstract patterns -->	
	<include href="abstract/dansJeuDeValeurs.sch"/>
	<include href="abstract/IVL_TS.sch"/>   
	
	<!-- Entête du volet CR-BIO -->	
	<include href="include/specificationsVolets/CR-BIO_2021.01/Entete/Entete_CR-BIO.sch"/>
	
	<!-- Sections relatives au volet CR-BIO -->
	<include href="include/specificationsVolets/CR-BIO_2021.01/Sections/S_FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention.sch"/>
	
	<!-- Entrées relatives au volet CR-BIO -->
	<include href="include/specificationsVolets/CR-BIO_2021.01/Entrees/E_FR-Resultats-examens-de-biologie-medicale.sch"/>
	<include href="include/specificationsVolets/CR-BIO_2021.01/Entrees/E_FR-Batterie-examens-de-biologie-medicale.sch"/>
	<include href="include/specificationsVolets/CR-BIO_2021.01/Entrees/E_FR-Isolat-microbiologique.sch"/>
	<include href="include/specificationsVolets/CR-BIO_2021.01/Entrees/E_FR-Laboratoire-executant.sch"/>
	<include href="include/specificationsVolets/CR-BIO_2021.01/Entrees/E_FR-Prelevement.sch"/>
	<include href="include/specificationsVolets/CR-BIO_2021.01/Entrees/E_FR-Resultat-examens-de-biologie-element-clinique-pertinent.sch"/>
	
	<!-- JDV relatives au volet CR-BIO -->
	<include href="include/jeuxDeValeurs/CR-BIO_2021.01/JDV_BIO_Interpretation-CISIS.sch"/>
	
	<phase id="CI-SIS_CR-BIO_2021.01">
		<active pattern="variables"/>
		
		<!-- Activation de l'en-tête  -->
		<active pattern="Entete_CR-BIO"/>
		
		<!-- activation des sections -->
		<active pattern="S_FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention"/>
		
		<!-- Activation des entrées  -->
		<active pattern="E_FR-Resultats-examens-de-biologie-medicale"/>
		<active pattern="E_FR-Batterie-examens-de-biologie-medicale"/>
		<active pattern="E_FR-Isolat-microbiologique"/>
		<active pattern="E_FR-Laboratoire-executant"/>
		<active pattern="E_FR-Prelevement"/>
		<active pattern="E_FR-Resultat-examens-de-biologie-element-clinique-pertinent"/>
		
		<!-- Activation des JDVs  -->
		<active pattern="JDV_BIO_Interpretation-CISIS"/>
	</phase>	
	
	<!-- ::::::::::::::::::::::::::::::::::::: -->
	<!--           Variables globales          -->
	<!-- ::::::::::::::::::::::::::::::::::::: -->
	
	<pattern id="variables">
		
		<!-- chemins relatifs des fichiers jeux de valeurs -->
		<let name="JDV_BIO_Interpretation-CISIS" value="'../jeuxDeValeurs/JDV_BIO_Interpretation-CISIS.xml'"/>
		
		<rule context="cda:ClinicalDocument">
			
			<assert test="./cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3']"> 
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : L'élément clinicalDocument/templateId doit être présent avec @root='1.3.6.1.4.1.19376.1.3.3'.
			</assert>
			
			<assert test="./cda:code[@code='11502-2' and @codeSystem='2.16.840.1.113883.6.1']"> 
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : L'élément code doit égal à @code='11502-2' et @codeSystem='2.16.840.1.113883.6.1'.
			</assert>
			
			<assert
				test="./cda:versionNumber[@value] and number(./cda:versionNumber/@value) &gt; 0">
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : L'élément "versionNumber" doit être présent dans l'en-tête, avec un attribut @value contenant un entier positif.
			</assert>
			
			<assert
				test="not(./cda:versionNumber[@nullFlavor])">
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : L'attribut nullFlavor est interdit pour l'élément "versionNumber".
			</assert>
			
		</rule>
		
		<!-- Contrôles des sections de niveau 1 autorisées -->
		<rule context="cda:structuredBody/cda:component/cda:section">
			<assert test="(./cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.2.1']) or (./cda:templateId[@root='1.2.250.1.213.1.1.2.60']) or (./cda:templateId[@root='1.3.6.1.4.1.19376.1.4.1.2.16'])"> 
				[CI-SIS_CR-BIO_2021.01] Erreur de conformité : un CR-BIO ne peut comporter que les sections de niveau 1 suivantes : FR-CR-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.1), 
				FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60) et FR-Commentaire-non-code (1.3.6.1.4.1.19376.1.4.1.2.16)
			</assert>
		</rule>
		
	</pattern>
	
</schema>
