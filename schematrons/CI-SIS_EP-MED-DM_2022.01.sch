<?xml version="1.0" encoding="UTF-8"?>

<!-- CI-SIS_EP-MED_2022.01.sch 
     ......................................................................................................................................................
     Vérification de la conformité au modèle du document eP-MED_2022.01 du CI-SIS.
     ......................................................................................................................................................
     Historique :
        - 01/09/2021 : Création
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="EP-MED-DM_2022.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="EP-MED-DM_2022.01.sch">
    
    <title>Rapport de conformité du document aux spécifications du modèle de document eP-MED-DM_2022.01 (ePrescription de médicaments et/ou de dispositifs médicaux)</title>
    
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    <ns prefix="pharm" uri="urn:ihe:pharm"/>
    
    <!-- Abstract patterns -->
    <include href="abstract/dansJeuDeValeurs.sch"/> 
    <include href="abstract/IVL_TS.sch"/>
    
    <!-- Entête du document eP-MED -->
    <include href="include/specificationsVolets/EP-MED-DM_2022.01/Entete/Entete_EP-MED-DM_2022.01.sch"/>
    
    <!-- Sections specifiques du document eP-MED -->    
    <include href="include/specificationsVolets/EP-MED-DM_2022.01/Sections/S_prescriptionMedicaments.sch"/>
    <include href="include/specificationsVolets/EP-MED-DM_2022.01/Sections/S_prescriptionDispositifsMedicaux.sch"/>
    
    
    <!-- Entrées du document eP-MED -->
    <include href="include/specificationsVolets/EP-MED-DM_2022.01/Entrees/E_medicamentPrescrit.sch"/>
    <include href="include/specificationsVolets/EP-MED-DM_2022.01/Entrees/E_dispositifMedicalPrescrit.sch"/>
    
    <!-- JDV du document eP-MED -->
    <include href="include/jeuxDeValeurs/EP-MED-DM_2022.01/JDV_SeverityObservation.sch"/>
    
    <!-- Phase en vigueur -->
    <phase id="EP-MED-DM_2022.01">
        <active pattern="variables"/>
        
        <!-- schématron de l'entête eP-MED-DM -->
        <active pattern="Entete_EP-MED-DM_2022.01"/> 
        
        <!-- schématrons des entrées eP-MED-DM -->
        <active pattern="E_medicamentPrescrit"/>
        <active pattern="E_dispositifMedicalPrescrit"/>
        
        <!-- schématrons des JDV eP-MED-DM -->
        <active pattern="JDV_SeverityObservation"/>
        
    </phase>
    
    <!-- Variables globales -->
    <pattern id="variables">
        
        <!-- JDV eP-MED -->
        <let name="jdv_SeverityObservation" value="'../jeuxDeValeurs/JDV_HL7_SeverityObservation-CISIS.xml'"/> 
        
        <!-- présence des sections obligatoires -->    
        <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody">
            <!-- [1..1] Section FR-Code-a-barres-ins : Code à barres INS (obligatoire) -->
            <assert test="cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.223']"> 
                [EP-MED-DM_2022.01] Erreur de conformité : La section "FR-Code-a-barres-ins" (1.2.250.1.213.1.1.2.223) doit être présente.
            </assert>                        
            
            <!-- Verifier la présence d'une Section FR-Prescription-medicaments et/ou  d'une Section FR-Prescription-dispositifs-medicaux-->
            <assert test="count(cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.171']) =1 
                or count(cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.222']) =1">
                [EP-MED-DM_2022.01] Erreur de conformité : La e-Prescription doit contenir une seule section FR-Prescription-medicaments (1.2.250.1.213.1.1.2.171)
                et/ou  une seule section FR-Prescription-dispositifs-medicaux (1.2.250.1.213.1.1.2.222).
            </assert>
            
        </rule>
        
    </pattern>
    
</schema>