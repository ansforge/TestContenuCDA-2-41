<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   Schématron : CI-SIS_DLU-DLU_2021.01.sch
   Vérification de la conformité au modèle du document DLU-DLU_2021.01 (Document de liaison Urgence)
   ...................................................................................................................................................... 
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
       12/12/2016 : Création
       14/03/2018 : MAJ du pattern variables
       06/01/2021 : Ajout du contrôle du JDV_ObservationEtatPatient
       19/02/2021 : Test de la présence des sections, du templateId du volet et du code
   ......................................................................................................................................................
       -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    	xmlns:cda="urn:hl7-org:v3" 
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" queryBinding="xslt2" schemaVersion="CI-SIS_DLU-DLU_2021.01.sch">
    
	<title>Rapport de conformité au modèle DLU-DLU</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>    

	<!-- Abstract patterns -->
	<include href="abstract/dansJeuDeValeurs.sch"/>
	<include href="abstract/IVL_TS.sch"/>   
	
	<!-- Schématrons JDV spécifiques au DLU-DLU -->
	<include href="include/jeuxDeValeurs/DLU-DLU_2021.01/JDV_CheckListDLU_DLU.sch"/>
	<include href="include/jeuxDeValeurs/DLU-DLU_2021.01/JDV_ObservationEtatPatient.sch"/>
	
	<!-- Schématron entete spécifique au DLU-DLU -->
	<include href="include/specificationsVolets/DLU-DLU_2021.01/Entete/Entete_DLU-DLU.sch"/>
	
	<phase id="CI-SIS_DLU-DLU_2021.01">
		<active pattern="variables"/>
		<active pattern="Entete_DLU-DLU"/>		
		<active pattern="JDV_CheckListDLU_DLU"/>
		<active pattern="JDV_ObservationEtatPatient"/>
	</phase>
	
	<pattern id="variables">
		<let name="JDV_CheckListDLU_DLU" value = "'../jeuxDeValeurs/JDV_ChecklistDLU-CISIS.xml'"/>
		<let name="JDV_ObservationEtatPatient" value = "'../jeuxDeValeurs/JDV_ObservationEtatPatient-CISIS.xml'"/>
		
		<rule context="cda:ClinicalDocument">
			<assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.22']"> 
				[CI-SIS_DLU-DLU_2021.01] Le templateId "1.2.250.1.213.1.1.1.22" (Conformité au modèle DLU-DLU du CI-SIS) doit être présent.
			</assert>
			<assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
				[CI-SIS_DLU-DLU_2021.01] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.10'])=1"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Dispositions : Etablissement de santé de préférence" doit être présente une fois. Cardinalité [1..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.6'])&lt; 2"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Pathologies actives" ne peut être présente qu'une fois. Cardinalité [0..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.8'])&lt; 2"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Antecedents médicaux" ne peut être présente qu'une fois. Cardinalité [0..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.13'])&lt; 2"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Allergies et intolérances" ne peut être présente qu'une fois. Cardinalité [0..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.19'])=1"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Traitements" doit être présente une fois. Cardinalité [1..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.35'])=1"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Directives anticipees : Soins palliatifs / Directives anticipées" doit être présente une fois. Cardinalité [1..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'])=1"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Resultats d'évenements : Etat psychique / Handicaps - déficits / Déplacements - transferts / Autres risques" doit être présente une fois. Cardinalité [1..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.28'])=1"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Resultats d'examens : bactérie multirésistante (BMR)" doit être présente une fois. Cardinalité [1..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.23'])&lt; 2"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Vaccinations" ne peut être présente qu'une fois. Cardinalité [0..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.37'])=1"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Documents ajoutés" doit être présente une fois. Cardinalité [1..1].
			</assert>
			<assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.4.1.2.16'])&lt; 2"> 
				[CI-SIS_DLU-DLU_2021.01] La section "Commentaire non codé" ne peut être présente qu'une fois. Cardinalité [0..1].
			</assert>
			
		</rule>
	</pattern>
	
</schema>
