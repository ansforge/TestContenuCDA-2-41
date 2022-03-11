<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   CI-SIS_TLM-CR_2021.01.sch
   Auteur : ANS
   ......................................................................................................................................................    
   Historique :
   16/09/2021 : Création nouvelle version TLM-CR_2021.01
   ......................................................................................................................................................       
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_TLM-CR_2021.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_TLM-CR_2021.01.sch">
    <title>Vérification de la conformité du document aux spécifications du CI-SIS</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

    <!-- Abstract patterns -->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>

    <!-- Entete spécifiques au TLM-CR -->
    <include href="include/specificationsVolets/TLM-CR_2021.01/Entete_TLM-CR.sch"/>

    <!-- Sections spécifiques au TLM-CR -->
    <!-- Néant -->

    <!-- Entrées spécifiques au TLM-CR -->
    <!-- Néant -->

    <!-- JDV spécifiques au TLM-CR -->
    <!-- Néant -->

    <phase id="CI-SIS_TLM-CR_2021.01">
        <active pattern="variables"/>
        <!--Entete-->
        <active pattern="Entete_TLM-CR"/>
    </phase>

    <pattern id="variables">
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root = '1.3.6.1.4.1.19376.1.2.20']"> [CI-SIS_TLM-CR_2021.01] Le
                templateID du modèle TLM-CR non structuré doit être celui commun à tous les documents
                non structurés (1.3.6.1.4.1.19376.1.2.20). </assert>
        </rule>
    </pattern>
</schema>
