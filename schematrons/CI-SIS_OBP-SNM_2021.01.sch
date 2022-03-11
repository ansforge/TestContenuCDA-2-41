<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_OBP-SNM_2021.01.sch
    ANS   
    ......................................................................................................................................................    
    Historique :
        17/10/2013 : Création
        19/06/2015 : Maj des include telecom20110728.sch  -> telecom20150317.sch
        14/03/2018 : MAJ du pattern Variables 
        10/09/2021 : Modification du nom du schématron       
        13/09/2021 : Modification pour nouvelle version 2021.01
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_OBP-SNM_2021.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_OBP-SNM_2021.01.sch">
    <title>Vérification de la conformité au modèle OBP-SNM_2021.01</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!-- Abstract patterns -->    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>     
    
    <!--Entete-->    
    <include href="include/specificationsVolets/OBP_2021.01/Entete/Entete_OBP.sch"/>
    
    <!-- Sections -->    
    <include href="include/specificationsVolets/OBP_2021.01/S_activeProblem_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_BirthOrganizer_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_codedDetailedPhysicalExamination_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_codedSocialHistory_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_patientEducation_OBP.sch"/>
    <include href="include/specificationsVolets/OBP_2021.01/S_pregnancyHistoryOrganizer_OBP.sch"/>    
    <include href="include/specificationsVolets/OBP_2021.01/SNM/S_procedureIntervention_SNM.sch"/>
    
    <!-- Entrées -->    
    <include href="include/specificationsVolets/OBP_2021.01/SNM/E_problemEntry_SNM.sch"/>

    <!-- JDV -->    
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_AllergyAndIntoleranceCodes_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_MotifDeclenchementTravail_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_TypeAnesthesieAvantNaissance_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_TypeAnesthesieApresNaissance_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_TypeActePostPartum_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_ModeDebutTravail_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP_2021.01/JDV_ComplicationsAnesthesie_OBP.sch"/>

    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CI-SIS_OBP-SNM_2021.01">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>
        
        <!-- Activation Entete-->
        <active pattern="Entete_OBP"/>        
        
        <!-- Activation Sections-->
        <active pattern="S_procedureIntervention_SNM"/>
        
        <!-- Activation Entrées -->
        <active pattern="E_problemEntry_SNM"/>
        
        <!-- Activation JDV -->
        <active pattern="JDV_MotifDeclenchementTravail_OBP"/>
        <active pattern="JDV_TypeAnesthesieAvantNaissance_OBP"/>
        <active pattern="JDV_TypeAnesthesieApresNaissance_OBP"/>
        <active pattern="JDV_TypeActePostPartum_OBP"/>
        <active pattern="JDV_ModeDebutTravail_OBP"/>
        <active pattern="JDV_ComplicationsAnesthesie_OBP"/>        
        
    </phase>
    
    <pattern id="variables">

        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_OBP_MotifDeclenchementTravail" value="'../jeuxDeValeurs/JDV_OBP_MotifDeclenchementTravail-CISIS.xml'"/>
        <let name="jdv_OBP_TypeAnesthesieAvantNaissance" value="'../jeuxDeValeurs/JDV_OBP_TypeAnesthesieAvantNaissance-CISIS.xml'"/>
        <let name="jdv_OBP_TypeAnesthesieApresNaissance" value="'../jeuxDeValeurs/JDV_OBP_TypeAnesthesieApresNaissance-CISIS.xml'"/>
        <let name="jdv_OBP_TypeActePostPartum" value="'../jeuxDeValeurs/JDV_OBP_TypeActePostPartum-CISIS.xml'"/>
        <let name="jdv_OBP_ModeDebutTravail" value="'../jeuxDeValeurs/JDV_OBP_ModeDebutTravail-CISIS.xml'"/>
        <let name="jdv_OBP_ComplicationsAnesthesie" value="'../jeuxDeValeurs/JDV_OBP_ComplicationsAnesthesie-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.12.2']"> 
                [CI-SIS_OBP-SNM_2021.01] Le template du modèle OPB-SNM (1.2.250.1.213.1.1.1.12.2) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='15508-5' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_OBP-SNM_2021.01] L'élément code doit avoir @code ="15508-5" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
        
    </pattern>
</schema>
