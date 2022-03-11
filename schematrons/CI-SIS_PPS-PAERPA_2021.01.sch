<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_PPS-PAERPA_2021.01.sch
    ANS   
    ......................................................................................................................................................    
    Historique :
    24/08/2021 : Création    
    26/10/2021 : Suppression du test de présence de la section FR-Education-et-consentement-du-patient
    ......................................................................................................................................................    
      
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_PPS-PAERPA_2021.01.sch">
    
    <title>Rapport de conformité du document aux spécifications du modèle PPS-PAERPA_2021.01</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!-- Abstract patterns -->    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>
    
    <!-- JDV --> 
    <include href="include/jeuxDeValeurs/PPS-PAERPA_2021.01/JDV_ProblemePPSPAERPA-CISIS.sch"/>
        
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CI-SIS_PPS-PAERPA_2021.01">
        
        <active pattern="variables"/>
        
        <!-- JDV -->
        <active pattern="JDV_ProblemePPSPAERPA-CISIS"/>
        
    </phase>
    
    <pattern id="variables">
        <let name="JDV_ProblemePPSPAERPA-CISIS" value="'../jeuxDeValeurs/JDV_ProblemePPSPAERPA-CISIS.xml'"/>        
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.20']"> 
                [CI-SIS_PPS-PAERPA_2021.01] Le templateId de conformité au modèle PPS-PAERPA_2021.01 (1.2.250.1.213.1.1.1.20) doit être présent.
            </assert>
            <assert test="./cda:code[@code='18776-5' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_PPS-PAERPA_2021.01] L'élément code doit avoir @code ="18776-5" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>        
        
        <!-- présence des sections obligatoires -->        
        <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody">            
            <!--<assert test="count(cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.9.39'])=1"> 
                [CI-SIS_PPS-PAERPA_2021.01] Erreur de conformité au modèle : La section "FR-Education-et-consentement-du-patient" (1.3.6.1.4.1.19376.1.5.3.1.1.9.39) est obligatoire [1..1].
            </assert> -->
            <assert test="count(cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.44'])=1"> 
                [CI-SIS_PPS-PAERPA_2021.01] Erreur de conformité au modèle : La section "FR-Dispositions-medico-sociales" (1.2.250.1.213.1.1.2.44) est obligatoire [1..1].
            </assert>
            <assert test="count(cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.35'])=1"> 
                [CI-SIS_PPS-PAERPA_2021.01] Erreur de conformité au modèle : La section "FR-Statut-du-document" (1.2.250.1.213.1.1.2.35) est obligatoire [1..1].
            </assert>
        </rule>
    </pattern>
</schema>