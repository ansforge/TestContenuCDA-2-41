<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_CANCER-FRCP_2021.01.sch
    ......................................................................................................................................................
    Auteur : ANS 
    Vérification de la conformité au document FRCP_2021.01
    ......................................................................................................................................................    
    16/04/2021 : ANS : Création Schématron FRCP_2021.01
    ......................................................................................................................................................    
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CANCER-FRCP_2021.01.sch">
    <title>Rapport de conformité du document aux spécifications du modèle FRCP_2021.01 du CI-SIS</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

    <!-- Abstract patterns -->    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>
    
    <!-- JDV -->
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_NatureDiscussion-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_OMSEchPerf-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_OMSInterpret-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_PhaseCancer-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_RCP-Appareil-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_RCP-Organe-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_StatutCasPresente-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_StatutDoc-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_StatutQuorum-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_TraitementSoins-FRCP-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_Tumeur-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_TypeTraitement-FRCP-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CANCER-FRCP_2021.01/JDV_Morphologie-CISIS.sch"/>
    
    <include href="include/specificationsVolets/CANCER-FRCP_2021.01/Entete/Entete_FRCP.sch"/>
    <include href="include/specificationsVolets/CANCER-FRCP_2021.01/Sections/S_cancerDiagnosis_FRCP.sch"/>
    
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CI-SIS_CANCER-FRCP_2021.01">
        <active pattern="variables"/>
        
        <active pattern="JDV_NatureDiscussion-CISIS"/>
        <active pattern="JDV_OMSEchPerf-CISIS"/>
        <active pattern="JDV_OMSInterpret-CISIS"/>    
        <active pattern="JDV_PhaseCancer-CISIS"/>   
        <active pattern="JDV_RCP-Appareil-CISIS"/>
        <active pattern="JDV_RCP-Organe-CISIS"/>
        <active pattern="JDV_StatutCasPresente-CISIS"/>
        <active pattern="JDV_StatutDoc-CISIS"/>
        <active pattern="JDV_StatutQuorum-CISIS"/>
        <active pattern="JDV_TraitementSoins-FRCP-CISIS"/>
        <active pattern="JDV_Tumeur-CISIS"/>
        <active pattern="JDV_TypeTraitement-FRCP-CISIS"/>
        
        <active pattern="Entete_FRCP"/>
        <active pattern="S_cancerDiagnosis_FRCP"/>
        <active pattern="JDV_Morphologie-CISIS"/>
        
    </phase>    

    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Variables globales          -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <pattern id="variables">

        <!-- JDV -->        
        
        <let name="JDV_NatureDiscussion-CISIS" value="'../jeuxDeValeurs/JDV_NatureDiscussion-CISIS.xml'"/>
        <let name="JDV_OMSEchPerf-CISIS" value="'../jeuxDeValeurs/JDV_OMSEchPerf-CISIS.xml'"/>
        <let name="JDV_OMSInterpret-CISIS" value="'../jeuxDeValeurs/JDV_OMSInterpret-CISIS.xml'"/>
        <let name="JDV_PhaseCancer-CISIS" value="'../jeuxDeValeurs/JDV_PhaseCancer-CISIS.xml'"/>
        <let name="JDV_RCP-Appareil-CISIS" value="'../jeuxDeValeurs/JDV_RCP-Appareil-CISIS.xml'"/>
        <let name="JDV_RCP-Organe-CISIS" value="'../jeuxDeValeurs/JDV_RCP-Organe-CISIS.xml'"/>
        <let name="JDV_StatutCasPresente-CISIS" value="'../jeuxDeValeurs/JDV_StatutCasPresente-CISIS.xml'"/>
        <let name="JDV_StatutDoc-CISIS" value="'../jeuxDeValeurs/JDV_StatutDoc-CISIS.xml'"/>
        <let name="JDV_StatutQuorum-CISIS" value="'../jeuxDeValeurs/JDV_StatutQuorum-CISIS.xml'"/>
        <let name="JDV_TraitementSoins-FRCP-CISIS" value="'../jeuxDeValeurs/JDV_TraitementSoins-FRCP-CISIS.xml'"/>
        <let name="JDV_Tumeur-CISIS" value="'../jeuxDeValeurs/JDV_Tumeur-CISIS.xml'"/>
        <let name="JDV_TypeTraitement-FRCP-CISIS" value="'../jeuxDeValeurs/JDV_TypeTraitement-FRCP-CISIS.xml'"/>
        <let name="JDV_Morphologie-CISIS" value="'../jeuxDeValeurs/JDV_Morphologie-CISIS.xml'"/>
        
        <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.1.8"]'>
            
            <!-- Vérifier que toutes les sections obligatoires du document sont présentes -->
            
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.2"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Raison-de-la-recommandation doit être présente dans le document.
            </assert> 
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Resultats-evenements doit être présente dans le document.
            </assert> 
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.7.3.1.3.14.1"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Diagnostic-du-cancer doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.25"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Note-de-progression doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.4"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Histoire-de-la-maladie-non-code doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Plan-de-soins doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.45"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Cadre-de-la-proposition-therapeutique doit être présente dans le document.
            </assert>            
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.33"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Statut-dossier-RCP doit être présente dans le document.
            </assert> 
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.35"]'>
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : La section FR-Statut-du-document doit être présente dans le document.
            </assert>
            <assert test="./cda:code[@code='34794-8' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_CANCER-FRCP_2021.01] : Erreur de conformité : L'élément "code" de la FRCP doit avoir les attributs @code ="34794-8" et @codeSystem = "2.16.840.1.113883.6.1". 
            </assert>
                        
        </rule>
    </pattern>
</schema>
