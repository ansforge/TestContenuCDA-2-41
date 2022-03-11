<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   CI-SIS_ANEST-CR-CPA_2021.01.sch
   Schématron de vérification de la conformité au modèle du CI-SIS d'un document ANEST-CR-CPA_2021.01
   
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
      21/12/2020 : Création
      07/06/2021 : Correction du contrôle du documentationOf/serviceEvent/code
   ......................................................................................................................................................    
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_ANEST-CR-CPA_2021.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_ANEST-CR-CPA_2021.01">
    <title>Rapport de conformité du document aux spécifications du volet ANEST-CR-CPA</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    
    <!--JDV-->
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_AideAuDeplacement-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_FacteursDeRisqueSociaux-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_FacteursDeRisqueProfessionnels-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_GIR-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_NiveauDependance-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_ObservationIntoleranceType_ANEST-CR-CPA-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_ScoreDuke-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_ScoreMallampati-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_Sedentarite-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_Severite-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/ANEST-CR-CPA_2021.01/JDV_SupportNutritionnel-CISIS.sch"/>
    
    <!-- Sections -->
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_SignesVitaux-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_ExamenPhysiqueDetaille-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_AntecedentsChirurgicauxNonCodee-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_AntecedentsFamiliauxNonCodee-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_ProblemesActifs-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_AntecedentsMedicaux-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_HabitusModeDeVie-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_FonctionsPhysiques-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_AllergiesEtIntolerances-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_Traitements-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_AntecedentsTransfusionnelsNonCodee-CISIS.sch"/>
    <include href="include/specificationsVolets/ANEST-CR-CPA_2021.01/Sections/S_AntecedentsHemorragiquesNonCodee-CISIS.sch"/>
    
    <phase id="CI-SIS_ANEST-CR-CPA_2021.01">
        <active pattern="JDVvariables"/>
        
        <!-- JDV -->
        <active pattern="JDV_AideAuDeplacement-CISIS"/>
        <active pattern="JDV_FacteursDeRisqueSociaux-CISIS"/>
        <active pattern="JDV_FacteursDeRisqueProfessionnels-CISIS"/>
        <active pattern="JDV_GIR-CISIS"/>
        <active pattern="JDV_NiveauDependance-CISIS"/>
        <active pattern="JDV_ObservationIntoleranceType-CISIS"/>
        <active pattern="JDV_ScoreDuke-CISIS"/>
        <active pattern="JDV_ScoreMallampati-CISIS"/>
        <active pattern="JDV_Sedentarite-CISIS"/>
        <active pattern="JDV_Severite-CISIS"/>
        <active pattern="JDV_SupportNutritionnel-CISIS"/>
        
       <!-- Sections spécifiques au volet ANEST-CR-CPA -->
        <active pattern="S_SignesVitaux-CISIS"/>
        <active pattern="S_ExamenPhysiqueDetaille-CISIS"/>
        <active pattern="S_AntecedentsChirurgicauxNonCodee-CISIS"/>
        <active pattern="S_AntecedentsFamiliauxNonCodee-CISIS"/>
        <active pattern="S_ProblemesActifs-CISIS"/>
        <active pattern="S_AntecedentsMedicaux-CISIS"/>
        <active pattern="S_HabitusModeDeVie-CISIS"/>
        <active pattern="S_FonctionsPhysiques-CISIS"/>
        <active pattern="S_AllergiesEtIntolerances-CISIS"/>
        <active pattern="S_Traitements-CISIS"/>
        <active pattern="S_AntecedentsTransfusionnelsNonCodee-CISIS"/>
        <active pattern="S_AntecedentsHemorragiquesNonCodee-CISIS"/>
    </phase>
    
    <pattern id="JDVvariables">
        <let name="jdv_ANEST-CR-CPA_AideAuDeplacement" value="'../jeuxDeValeurs/JDV_AideAuDeplacement-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_FacteursDeRisqueSociaux" value="'../jeuxDeValeurs/JDV_FacteursDeRisqueSociaux-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_FacteursDeRisqueProfessionnels" value="'../jeuxDeValeurs/JDV_FacteursDeRisqueProfessionnels-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_GIR" value="'../jeuxDeValeurs/JDV_GIR-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_NiveauDependance" value="'../jeuxDeValeurs/JDV_NiveauDependance-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_ObservationIntoleranceType" value="'../jeuxDeValeurs/JDV_ObservationIntoleranceType-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_ScoreDuke" value="'../jeuxDeValeurs/JDV_ScoreDuke-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_ScoreMallampati" value="'../jeuxDeValeurs/JDV_ScoreMallampati-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_Sedentarite" value="'../jeuxDeValeurs/JDV_Sedentarite-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_Severite" value="'../jeuxDeValeurs/JDV_HL7_SeverityObservation-CISIS.xml'"/>
        <let name="jdv_ANEST-CR-CPA_SupportNutritionnel" value="'../jeuxDeValeurs/JDV_SupportNutritionnel-CISIS.xml'"/>
        
        <!-- Contrôle spécifique à l'en tête -->
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.41']"> 
                [CI-SIS_ANEST-CR-CPA] Le templateId "1.2.250.1.213.1.1.1.41" (Conformité au modèle ANEST-CR-CPA du CI-SIS) doit être présent.
            </assert>
            <assert test="./cda:code[@code='34749-2' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_ANEST-CR-CPA] L'élément "code" de ANEST-CR-CPA doit avoir les attributs @code ="34749-2" et @codeSystem = "2.16.840.1.113883.6.1". 
            </assert>
            <assert test="(./cda:documentationOf/cda:serviceEvent/cda:code[@code='CS' and @codeSystem='1.2.250.1.215.200.3.3']) or (./cda:documentationOf/cda:serviceEvent/cda:code[@code='APC' and @codeSystem='1.2.250.1.215.200.3.3']) "> 
                [CI-SIS_ANEST-CR-CPA] L'élément "code" de l'acte principal doit avoir les attributs @code ="CS" ou "APC" et @codeSystem = "1.2.250.1.215.200.3.3". 
            </assert>
        </rule>
        
        <!-- présence des sections obligatoires -->
        <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody">
            
            <assert test="count(cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2'])=1"> 
                [CI-SIS_ANEST-CR-CPA] Erreur de conformité au modèle ANEST-CR-CPA : La section "FR-Signes-vitaux" (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2)  doit être présente.
            </assert>
            
        </rule>
        
    </pattern>
</schema>