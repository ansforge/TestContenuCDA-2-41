<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_OBP-SNE_2021.01.sch    
    ......................................................................................................................................................    
    Auteur : ANS
    ......................................................................................................................................................    
    Historique :
        17/10/2013 : Création
        19/06/2015 : Maj des include telecom20110728.sch -> telecom20150317.sch
        14/03/2018 : MAJ du pattern Variables
        20/11/2020 : Modification du nom du schématron JDV appelé (ancien JDV_routeOfAdministration_OBP.sch)        
        10/09/2021 : Modification du nom du schématron
        13/09/2021 : Modification pour version 2021.01
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_OBP-SNE_2021.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_OBP-SNE_2021.01.sch">
    <title>Vérification de la conformité au modèle OBP-SNE_2021.01</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!-- Abstract patterns -->    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    
    <!-- Entete -->    
    <include href="include/specificationsVolets/OBP_2021.01/Entete/Entete_OBP.sch"/>
    
    <!-- Sections -->   
    <include href="include/specificationsVolets/OBP_2021.01/S_BirthOrganizer_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_activeProblem_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_codedDetailedPhysicalExamination_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_codedSocialHistory_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_patientEducation_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_pregnancyHistoryOrganizer_OBP.sch"/>
    
    <!-- JDV -->   
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_ModeNaissance_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_TypeInterventionVoieBasse_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_PresentationFoetale_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_QuantiteLA_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_AspectLA_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_CirconstancesDeces_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_GesteReanimationNN_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_approachSiteCode_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_PrelevementsPeriph_OBP.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CI-SIS_OBP-SNE_2021.01">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>
        
        <!-- Activation Entete -->        
        <active pattern="Entete_OBP"/>
        
        <!-- Activation Sections -->        
        <active pattern="S_BirthOrganizer_OBP"/>
        <active pattern="S_activeProblem_OBP"/>
        <active pattern="S_CodedDetailedPhysicalExamination_OPB.sch"/>
        <active pattern="S_codedSocialHistory_OBP"/>
        <active pattern="S_patientEducation_OBP"/>
        <active pattern="S_pregnancyHistoryOrganizer_OBP"/>
        
        <!-- Activation JDV -->        
        <active pattern="JDV_ModeNaissance_OBP"/>
        <active pattern="JDV_TypeInterventionVoieBasse_OBP"/>
        <active pattern="JDV_PresentationFoetale_OBP"/>
        <active pattern="JDV_QuantiteLA_OBP"/>
        <active pattern="JDV_AspectLA_OBP"/>
        <active pattern="JDV_CirconstancesDeces_OBP"/>
        <active pattern="JDV_GesteReanimationNN_OBP"/>
        <active pattern="JDV_approachSiteCode_OBP"/>
        <active pattern="JDV_PrelevementsPeriph_OBP"/>
 
    </phase>
    
    <!-- Variables globales -->
    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_approachSiteCode_OBP" value="'../jeuxDeValeurs/JDV_HL7_RouteOfAdministration-CISIS.xml'"/>
        <let name="jdv_OBP_ModeNaissance" value="'../jeuxDeValeurs/JDV_OBP_ModeNaissance-CISIS.xml'"/>
        <let name="jdv_OBP_TypeInterventionVoieBasse" value="'../jeuxDeValeurs/JDV_OBP_TypeInterventionVoieBasse-CISIS.xml'"/>
        <let name="jdv_OBP_PresentationFoetale" value="'../jeuxDeValeurs/JDV_OBP_PresentationFoetale-CISIS.xml'"/>
        <let name="jdv_OBP_QuantiteLA" value="'../jeuxDeValeurs/JDV_OBP_QuantiteLA-CISIS.xml'"/>
        <let name="jdv_OBP_AspectLA" value="'../jeuxDeValeurs/JDV_OBP_AspectLA-CISIS.xml'"/>
        <let name="jdv_OBP_CirconstancesDeces" value="'../jeuxDeValeurs/JDV_OBP_CirconstancesDeces-CISIS.xml'"/>
        <let name="jdv_OBP_GesteReanimationNN" value="'../jeuxDeValeurs/JDV_OBP_GesteReanimationNN-CISIS.xml'"/>
        <let name="jdv_OBP_PrelevementsPeriph" value="'../jeuxDeValeurs/JDV_OBP_PrelevementsPeriph-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.12.3']"> 
                [CI-SIS_OBP-SNE_2021.01] Le template "Synthèse Salle de Naissance Enfant (SNE)" (1.2.250.1.213.1.1.1.12.2) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='15508-5' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_OBP-SNE_2021.01] L'élément code doit avoir @code="15508-5" et @codeSystem="2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
        
    </pattern>
</schema>
