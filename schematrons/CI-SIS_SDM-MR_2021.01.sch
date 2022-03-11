<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_SDM-MR_2021.01.sch
    ANS   
    ......................................................................................................................................................    
    Historique :
        17/10/2017 : Création
        14/03/2018 : Maj du pattern variables  
        05/11/2021 : version 2021.01
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_SDM-MR_2021.01.sch">
    
    <title>Vérification de la conformité au modèle SDM-MR_2021.01</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!-- Abstract patterns -->    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>
    
    <!--Entete-->    
    <include href="include/specificationsVolets/SDM-MR_2021.01/Entete/Entete_SDMMR.sch"/>    
    
    <!-- JDV --> 
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_Age_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_AppreciationDiagnosticEntree_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_CasSporadiqueFamilial_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_MalformationAntenatale_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_ModeConfirmationDiagnostic_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_ObjectifActivite_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_PatientAdressePar_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_StatutActuelDiagnostic_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_ContexteActivite_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_TechniquesDiagnostic_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_InvestigationsRealisees_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDM-MR_2021.01/JDV_ProfessionPersonnelActivite_SDMMR.sch"/>
        
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CI-SIS_SDM-MR_2021.01">
        
        <active pattern="variables"/>
        
        <!-- Entete -->
        <active pattern="Entete_SDMMR"/> 
        
        <!-- JDV -->
        <active pattern="JDV_Age_SDMMR"/>
        <active pattern="JDV_AppreciationDiagnosticEntree_SDMMR"/>
        <active pattern="JDV_CasSporadiqueFamilial_SDMMR"/>
        <active pattern="JDV_MalformationAntenatale_SDMMR"/>
        <active pattern="JDV_ModeConfirmationDiagnostic_SDMMR"/>
        <active pattern="JDV_ObjectifActivite_SDMMR"/>
        <active pattern="JDV_PatientAdressePar_SDMMR"/>
        <active pattern="JDV_StatutActuelDiagnostic_SDMMR"/>
        <active pattern="JDV_ContexteActivite_SDMMR"/>
        <active pattern="JDV_TechniquesDiagnostic_SDMMR"/>
        <active pattern="JDV_InvestigationsRealisees_SDMMR"/>
        <active pattern="JDV_ProfessionPersonnelActivite_SDMMR"/>
        
    </phase>
    
    <pattern id="variables">
        <let name="jdv_Age" value="'../jeuxDeValeurs/JDV_Age-CISIS.xml'"/>
        <let name="jdv_AppreciationDiagnosticEntree" value="'../jeuxDeValeurs/JDV_AppreciationDiagnosticCentre-CISIS.xml'"/>
        <let name="jdv_CasSporadiqueFamilial" value="'../jeuxDeValeurs/JDV_CasSporadiqueFamilial-CISIS.xml'"/>
        <let name="jdv_MalformationAntenatale" value="'../jeuxDeValeurs/JDV_MalformationAntenatale-CISIS.xml'"/>
        <let name="jdv_ModeConfirmationDiagnostic" value="'../jeuxDeValeurs/JDV_InvestigationsRealisees-CISIS'"/>
        <let name="jdv_ObjectifActivite" value="'../jeuxDeValeurs/JDV_ObjectifActivite-CISIS.xml'"/>
        <let name="jdv_StatutActuelDiagnostic" value="'../jeuxDeValeurs/JDV_StatutActuelDiagnostic-CISIS.xml'"/>
        <let name="jdv_PatientAdressePar" value="'../jeuxDeValeurs/JDV_PatientAdressePar-CISIS.xml'"/>
        <let name="jdv_ContexteActivite" value="'../jeuxDeValeurs/JDV_ContexteActivite-CISIS.xml'"/>
        <let name="jdv_TechniquesDiagnostic" value="'../jeuxDeValeurs/JDV_TechniquesDiagnostic-CISIS.xml'"/>
        <let name="jdv_InvestigationsRealisees" value="'../jeuxDeValeurs/JDV_InvestigationsRealisees-CISIS.xml'"/>
        <let name="jdv_ProfessionPersonnelActivite" value="'../jeuxDeValeurs/JDV_ProfessionPersonnelActivite-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.30']"> 
                [CI-SIS_SDM-MR_2021.01] Le template du modèle SDM-MR (1.2.250.1.213.1.1.1.30) doit être présent.
            </assert>
            <assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI_SIS_SDM-MR_2021.01] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1" 
            </assert>
            <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.35']) = 1"> 
                [CI_SIS_SDM-MR_2021.01] La section Directives anticipées (1.3.6.1.4.1.19376.1.5.3.1.3.35) est obligatoire et unique
            </assert>
            <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.6']) = 1"> 
                [CI_SIS_SDM-MR_2021.01] La section Problèmes actifs (1.3.6.1.4.1.19376.1.5.3.1.3.6) est obligatoire et unique
            </assert>
        </rule>
    </pattern>
</schema>