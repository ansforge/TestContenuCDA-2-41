<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_OPH-CR-RTN_2021.01.sch
    ......................................................................................................................................................
    Vérification de la conformité sémantique au volet Compte-rendu de rétinographie du CI-SIS.
    ......................................................................................................................................................
    Historique :
        05/11/2021 : Création                   
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_OPH-CR-RTN_2021.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_OPH-CR-RTN_2021.01.sch">
    <title>Vérification de la conformité au modèle OPH-CR-RTN_2021.01</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!-- Abstract patterns -->    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
  
    <!-- Entete -->    
    <include href="include/specificationsVolets/OPH-CR-RTN_2021.01/Entete/Entete_OPH-CR-RTN.sch"/>
     
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CI-SIS_OPH-CR-RTN_2021.01">
        <active pattern="variables"/>
        <active pattern="Entete_CR-RTN"/>
    </phase>
    
    <!-- Variables globales -->
    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->

        <let name="jdv_confidentialityCode" value="'../jeuxDeValeurs/JDV_HL7_Confidentiality-CISIS.xml'"/>  
        <let name="jdv_encompassingEncounterCode" value="'../jeuxDeValeurs/JDV_encompassingEncounterCode-CISIS.xml'"/>        
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.4.1.2.16']">
                [Entete_OPH-CR-RTN] Erreur de conformité : La section FR-Commentaire-non-code est obligatoire dans ce volet
            </assert>
            
            <assert test="cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.37']">
                [Entete_OPH-CR-RTN] Erreur de conformité : La section FR-Documents-ajoutes est obligatoire dans ce volet
            </assert>
            
        </rule>
        
    </pattern>
</schema>