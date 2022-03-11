<?xml version="1.0" encoding="UTF-8"?>


<!-- 
    CI-SIS_LDL-EES_2020.01.sch
    Vérification de la conformité du document au modèle LDL-EES_2020.01 du CI-SIS   
    ......................................................................................................................................................    
    Historique :
        06/11/2017 : Création
        14/03/2018 : Suppression du pattern Variables
        22/02/2021 : Renommage schématron     
        03/05/2021 : Ajout des contrôles des sections obligatoires   
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_LDL-EES_2020.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_LDL-EES_2020.01.sch">
    <title>Vérification de la conformité au modèle LDL-EES_2020.01 du CI-SIS</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>    
    
    <!--  Abstract patterns  -->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    
    <!--Entete-->
    <include href="include/specificationsVolets/LDL-EES_2020.01/Entete/Entete_LDL-EES.sch"/>
    
    <!-- JDV -->
    <include href="include/jeuxDeValeurs/LDL-EES_2020.01/JDV_SeverityObservation-CISIS.sch"/>
    
    <phase id="CI-SIS_LDL-EES_2020.01">
        <active pattern="variables"/>
        <p>Vérification de la conformité au modèle LDL-EES du CI-SIS</p>        
        
        <!--Entete-->
        <active pattern="Entete_LDL-EES"/>
        
        <!--JDV-->
        <active pattern="JDV_SeverityObservation-CISIS"/>
        
    </phase>
    
    <pattern id="variables">
        <let name="jdv_SeveriteObservation-CISIS" value="'../jeuxDeValeurs/JDV_HL7_SeverityObservation-CISIS.xml'"/> 
        
        <!-- Vérifier que toutes les sections obligatoires du document sont présentes -->
        <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.1.21"]'>
            
            <!-- Présence obligatoire de la section FR-Raison-de-la-recommandation-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.1) -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.1"]'>
                [CI-SIS_LDL-EES_2021.01] Erreur de conformité :
                La section FR-Raison-de-la-recommandation-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.1) est obligatoire.
            </assert>
            
            <!-- Présence obligatoire de la section FR-Traitements-a-l-admission (1.3.6.1.4.1.19376.1.5.3.1.3.20) -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.20"]'>
                [CI-SIS_LDL-EES_2021.01] Erreur de conformité :
                La section FR-Traitements-a-l-admission (1.3.6.1.4.1.19376.1.5.3.1.3.20) est obligatoire.
            </assert>
            
            <!-- Présence obligatoire de la section FR-Allergies-et-intolerances (1.3.6.1.4.1.19376.1.5.3.1.3.13) -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.13"]'>
                [CI-SIS_LDL-EES_2021.01] Erreur de conformité : 
                La section FR-Allergies-et-intolerances (1.3.6.1.4.1.19376.1.5.3.1.3.13) est obligatoire.
            </assert>
            
            <!-- Présence obligatoire de la section FR-Commentaire-non-code (1.3.6.1.4.1.19376.1.4.1.2.16) -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.4.1.2.16"]'>
                [CI-SIS_LDL-EES_2021.01] Erreur de conformité : 
                La section FR-Commentaire-non-code (1.3.6.1.4.1.19376.1.4.1.2.16) est obligatoire.
            </assert>
            
        </rule>
        
    </pattern>
</schema>