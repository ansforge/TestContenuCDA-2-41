<?xml version="1.0" encoding="UTF-8"?>


<!-- 
    CI-SIS_LDL-SES_2020.01.sch
    Vérification de la conformité du document au modèle LDL-SES_2020.01 du CI-SIS
    ......................................................................................................................................................    
    Historique :
        16/08/2016 : Création
        19/12/2016 : Modification des entrées, sections et JDV
        14/03/2018 : MAJ du pattern Variables
        22/02/2021 : Renommage schématron   
        03/05/2021 : Ajout des contrôles des sections obligatoires
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_LDL-SES_2020.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_LDL-SES_2020.01.sch">
    <title>Vérification de la conformité au modèle LDL-SES_2020.01 du CI-SIS</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!--  Abstract patterns  -->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/> 

    <!-- JDV -->
    <include href="include/jeuxDeValeurs/LDL-SES_2020.01/JDV_ModaliteEntree_LDL-SES.sch"/>
    <include href="include/jeuxDeValeurs/LDL-SES_2020.01/JDV_ModaliteSortie_LDL-SES.sch"/>

    <!-- Entete -->
    <include href="include/specificationsVolets/LDL-SES_2020.01/Entete/Entete_LDL-SES.sch"/>
    
    <!-- Section -->
    <include href="include/specificationsVolets/LDL-SES_2020.01/Sections/S_ResultatsEvenements_LDL-SES.sch"/>
    
    <phase id="CI-SIS_LDL-SES_2020.01">
        <active pattern="variables"/>
        <p>Vérification de la conformité au modèle LDL-SES du CI-SIS</p>

        <!-- Activation JDV -->
        <active pattern="JDV_ModaliteEntree_LDL-SES"/>
        <active pattern="JDV_ModaliteSortie_LDL-SES"/>

        <!--Entete-->
        <active pattern="Entete_LDL-SES"/>
        <active pattern="S_ResultatsEvenements_LDL-SES"/>
        
    </phase>
    
    <pattern id="variables">
 
        <let name="JDV_ModaliteEntree_LDL-SES" value="'../jeuxDeValeurs/JDV_ModaliteEntree-CISIS.xml'"/>
        <let name="JDV_ModaliteSortie_LDL-SES" value="'../jeuxDeValeurs/JDV_ModaliteSortie-CISIS.xml'"/>
        
        <!-- Vérifier que toutes les sections obligatoires du document sont présentes -->
        <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.1.29"]'>
            
            <!-- Présence obligatoire de la section FR-Statut-du-document-LDL-SES (1.2.250.1.213.1.1.2.35.1) -->
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.35.1"]'>
                [CI-SIS_LDL-SES_2021.01] Erreur de conformité : 
                La section FR-Statut-du-document-LDL-SES (1.2.250.1.213.1.1.2.35.1) est obligatoire.
            </assert>
            
            <!-- Présence obligatoire de la section FR-Raison-de-la-recommandation-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.1) -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.1"]'>
                [CI-SIS_LDL-SES_2021.01] Erreur de conformité :
                La section FR-Raison-de-la-recommandation-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.1) est obligatoire.
            </assert>
            
            <!-- Présence obligatoire de la section FR-Resultats-evenements-LDL-SES (1.3.6.1.4.1.19376.1.7.3.1.1.13.7) -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]'>
                [CI-SIS_LDL-SES_2021.01] Erreur de conformité :
                La section FR-Resultats-evenements-LDL-SES (1.3.6.1.4.1.19376.1.7.3.1.1.13.7) est obligatoire.
            </assert>
            
            <!-- Présence obligatoire de la section FR-Traitements-a-la-sortie (1.3.6.1.4.1.19376.1.5.3.1.3.22) -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.22"]'>
                [CI-SIS_LDL-SES_2021.01] Erreur de conformité : 
                La section FR-Traitements-a-la-sortie (1.3.6.1.4.1.19376.1.5.3.1.3.22) est obligatoire.
            </assert>
            
        </rule>
        
    </pattern>
    
    
</schema>