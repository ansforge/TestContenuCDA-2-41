<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   CI-SIS_CANCER-CR-GM_2021.01.sch
   auteur : ANS
   Ce volet décrit les données contenues dans un Compte Rendu de Génétique Moléculaire
   ......................................................................................................................................................    
    Historique :
       08/01/2019 : Création
       30/03/2021 : Suppression du JDV HGNC (remplacé par toute la termino)
       21/04/2021 : Intégration des contrôles des sections obligatoires
       -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_CANCER-CR-GM_2021.01"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        schemaVersion="CI-SIS_CANCER-CR-GM_2021.01.sch">
        <title>Rapport de conformité du document aux spécifications du volet
                CANCER-CR-GM_2021.01</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

        <!-- Abstract patterns -->
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>

        <!--Sections spécifiques au CR-GM-->
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Sections/S_additionalSpecified_CRGM.sch"/>
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Sections/S_clinicalInformation_CRGM.sch"/>
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Sections/S_diagnosticConclusion_CRGM.sch"/>
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Sections/S_intraoperativeObservation_CRGM.sch"/>
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Sections/S_macroscopicObservation_CRGM.sch"/>
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Sections/S_microscopicObservation_CRGM.sch"/>
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Sections/S_procedureSteps_CRGM.sch"/>

        <!--Entrées spécifiques au CR-GM-->
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Entrees/E_problemOrganizer_CRGM.sch"/>
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Entrees/E_specimenProcedureSteps_CRGM.sch"/>

        <!--JDV spécifiques au CR-GM-->
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_Conditionnement-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_ClasseTherapie-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_ImpactMutation-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_MethodePreparationEchantillon-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_NatureFraction-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_NatureMaterielEtudie-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_Organe-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_QualificationFraction-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_RaisonNonRealisation-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_TypeConclusion-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_TypeHistoEtatTumoral-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_TypePrelevOrigine-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_TypeResultat-CISIS.sch"/>
        <include href="include/jeuxDeValeurs/CANCER-CR-GM_2021.01/JDV_StatutDoc-CISIS.sch"/>

        <!--Entete spécifiques au CR-GM-->
        <include href="include/specificationsVolets/CANCER-CR-GM_2021.01/Entete/Entete_CR-GM.sch"/>

        <phase id="CI-SIS_CANCER-CR-GM_2021.01">
                <active pattern="variables"/>

                <active pattern="S_additionalSpecified_CRGM"/>
                <active pattern="S_clinicalInformation_CRGM"/>
                <active pattern="S_diagnosticConclusion_CRGM"/>
                <active pattern="S_intraoperativeObservation_CRGM"/>
                <active pattern="S_macroscopicObservation_CRGM"/>
                <active pattern="S_microscopicObservation_CRGM"/>
                <active pattern="S_procedureSteps_CRGM"/>

                <active pattern="E_problemOrganizer_CRGM"/>
                <active pattern="E_specimenProcedureSteps_CRGM"/>

                <active pattern="JDV_Conditionnement-CISIS"/>
                <active pattern="JDV_ClasseTherapie-CISIS"/>
                <active pattern="JDV_ImpactMutation-CISIS"/>
                <active pattern="JDV_MethodePreparationEchantillon-CISIS"/>
                <active pattern="JDV_NatureFraction-CISIS"/>
                <active pattern="JDV_NatureMaterielEtudie-CISIS"/>
                <active pattern="JDV_Organe-CISIS"/>
                <active pattern="JDV_QualificationFraction-CISIS"/>
                <active pattern="JDV_RaisonNonRealisation-CISIS"/>
                <active pattern="JDV_TypeConclusion-CISIS"/>
                <active pattern="JDV_TypeHistoEtatTumoral-CISIS"/>
                <active pattern="JDV_TypePrelevOrigine-CISIS"/>
                <active pattern="JDV_TypeResultat-CISIS"/>
                <active pattern="JDV_StatutDoc-CISIS"/>

                <!--Entete-->
                <active pattern="Entete_CR-GM"/>
                
        </phase>

        <pattern id="variables">

                <let name="JDV_Conditionnement-CISIS"
                        value="'../jeuxDeValeurs/JDV_Conditionnement-CISIS.xml'"/>
                <let name="JDV_ClasseTherapie-CISIS"
                        value="'../jeuxDeValeurs/JDV_ClasseTherapie-CISIS.xml'"/>
                <let name="JDV_ImpactMutation-CISIS"
                        value="'../jeuxDeValeurs/JDV_ImpactMutation-CISIS.xml'"/>
                <let name="JDV_MethodePreparationEchantillon-CISIS"
                        value="'../jeuxDeValeurs/JDV_MethodePreparationEchantillon-CISIS.xml'"/>
                <let name="JDV_NatureFraction-CISIS"
                        value="'../jeuxDeValeurs/JDV_NatureFraction-CISIS.xml'"/>
                <let name="JDV_NatureMaterielEtudie-CISIS"
                        value="'../jeuxDeValeurs/JDV_NatureMaterielEtudie-CISIS.xml'"/>
                <let name="JDV_Organe-CISIS" value="'../jeuxDeValeurs/JDV_Organe-CISIS.xml'"/>
                <let name="JDV_QualificationFraction-CISIS"
                        value="'../jeuxDeValeurs/JDV_QualificationFraction-CISIS.xml'"/>
                <let name="JDV_RaisonNonRealisation-CISIS"
                        value="'../jeuxDeValeurs/JDV_RaisonNonRealisation-CISIS.xml'"/>
                <let name="JDV_TypeConclusion-CISIS"
                        value="'../jeuxDeValeurs/JDV_TypeConclusion-CISIS.xml'"/>
                <let name="JDV_TypeHistoEtatTumoral-CISIS"
                        value="'../jeuxDeValeurs/JDV_TypeHisto_EtatTumoral-CISIS.xml'"/>
                <let name="JDV_TypePrelevOrigine-CISIS"
                        value="'../jeuxDeValeurs/JDV_TypePrelevOrigine-CISIS.xml'"/>
                <let name="JDV_TypeResultat-CISIS"
                        value="'../jeuxDeValeurs/JDV_TypeResultat-CISIS.xml'"/>
                <let name="JDV_StatutDoc-CISIS" value="'../jeuxDeValeurs/JDV_StatutDoc-CISIS.xml'"/>


                <!-- Vérifier que toutes les sections obligatoires du document sont présentes -->
                <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.1.32"]'>
                        
                        <!-- Vérifier le code du document -->
                        <assert test="./cda:code[@code='51969-4' and @codeSystem='2.16.840.1.113883.6.1']"> 
                                [CI-SIS_CANCER-CR-GM_2021.01] : Erreur de conformité : L'élément
                                "code" de la FRCP doit avoir les attributs @code="51969-4" et
                                @codeSystem="2.16.840.1.113883.6.1". 
                        </assert>
                        
                        <!-- Présence obligatoire de la section FR-Informations-cliniques (1.3.6.1.4.1.19376.1.8.1.2.1) -->
                        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.1"]'>
                                [CI-SIS_CANCER-CR-GM_2021.01] Erreur de conformité : 
                                La section FR-Informations-cliniques (1.3.6.1.4.1.19376.1.8.1.2.1) est obligatoire.
                        </assert>

                        <!-- Présence obligatoire de la section FR-Prelevements (1.3.6.1.4.1.19376.1.8.1.2.6) -->
                        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.6"]'>
                                [CI-SIS_CANCER-CR-GM_2021.01] Erreur de conformité :
                                La section FR-Prelevements (1.3.6.1.4.1.19376.1.8.1.2.6) est obligatoire.
                        </assert>

                        <!-- Présence obligatoire de la section FR-Observation-macroscopique (1.3.6.1.4.1.19376.1.8.1.2.3) -->
                        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.3"]'>
                                [CI-SIS_CANCER-CR-GM_2021.01] Erreur de conformité :
                                La section FR-Observation-macroscopique (1.3.6.1.4.1.19376.1.8.1.2.3) est obligatoire.
                        </assert>
                        
                        <!-- Présence obligatoire de la section FR-Observation-extemporane (1.3.6.1.4.1.19376.1.8.1.2.2) -->
                        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.2"]'>
                                [CI-SIS_CANCER-CR-GM_2021.01] Erreur de conformité : 
                                La section FR-Observation-extemporane (1.3.6.1.4.1.19376.1.8.1.2.2) est obligatoire.
                        </assert>
                        
                        <!-- Présence obligatoire de la section FR-Conclusion-diagnostic (1.3.6.1.4.1.19376.1.8.1.2.5) -->
                        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.5"]'>
                                [CI-SIS_CANCER-CR-GM_2021.01] Erreur de conformité : 
                                La section FR-Conclusion-diagnostic (1.3.6.1.4.1.19376.1.8.1.2.5) est obligatoire.
                        </assert>

                        <!-- Présence obligatoire de la section FR-Constatations-pathologiques-complementaires (1.3.6.1.4.1.19376.1.3.10.3.1) -->
                        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.3.10.3.1"]'>
                                [CI-SIS_CANCER-CR-GM_2021.01] Erreur de conformité : 
                                La section FR-Constatations-pathologiques-complementaires (1.3.6.1.4.1.19376.1.3.10.3.1) est obligatoire.
                        </assert>
                        
                        <!-- Présence obligatoire de la section FR-Statut-du-document (1.2.250.1.213.1.1.2.35) -->
                        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.35"]'>
                                [CI-SIS_CANCER-CR-GM_2021.01] Erreur de conformité : 
                                La section FR-Statut-du-document (1.2.250.1.213.1.1.2.35) est obligatoire.
                        </assert>
                        
                </rule>
                
        </pattern>
</schema>
