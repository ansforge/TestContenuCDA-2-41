<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_Modeles_ANS.sch
    ......................................................................................................................................................
    Auteur : ANS
    ......................................................................................................................................................
    Vérification de la conformité des sections et entrées créées par l'ANS
    ......................................................................................................................................................      
    Historique :
        21/08/2017 : Creation
        10/10/2019 : Mise à jour pour l'entrée Dispositif médical
        01/12/2020 : Mise à jour pour eP-MED et renommage ASIP en ANS
        07/09/2021 : Suppression schématrons S_interpretation_ANS.sch (car section D2LM) et 
        07/09/2021 : Remplacé S_bilan-cancerologie_ANS par S_bilan-diagnostic-immediat_ANS
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_Modeles_ANS"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2" xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_Modeles_ANS.sch">
    
    <title>Vérification de la conformité des sections et entrées créées par l'ANS</title>

    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    <ns prefix="lab" uri="urn:oid:1.3.6.1.4.1.19376.1.3.2"/>
    <ns prefix="pharm" uri="urn:ihe:pharm"/>

    <!-- sections créées par l'ANS -->
    
    <include href="../include/sections/S_allergiesIntolerances_ANS.sch"/>   
    <include href="../include/sections/S_anamnese_ANS.sch"/>  
    <include href="../include/sections/S_anamneseEtFacteursDeRisques_ANS.sch"/>  
    <include href="../include/sections/S_antecedentsMedicaux_ANS.sch"/>   
    <include href="../include/sections/S_bilan-diagnostic-immediat_ANS.sch"/>
    <include href="../include/sections/S_bilanPre-therapeutique_ANS.sch"/>
    <include href="../include/sections/S_cadrePropositionTherapeutique_ANS.sch"/><!--
    <include href="../include/sections/S_cadrePropositionTherapeutiqueFRCP_ANS.sch"/>-->
    <include href="../include/sections/S_comment_ANS.sch"/>
    <include href="../include/sections/S_conclusionCR-ACP_ANS.sch"/>
    <include href="../include/sections/S_conclusionCRO_ANS.sch"/>
    <include href="../include/sections/S_diagnosticSortie_ANS.sch"/>
    <include href="../include/sections/S_dispositifs_medicaux_ANS.sch"/>
    <include href="../include/sections/S_dispositionsMedicoSociales_ANS.sch"/>
    <include href="../include/sections/S_documentsAjoutes_ANS.sch"/>
    <include href="../include/sections/S_documentsReference_ANS.sch"/>
    <include href="../include/sections/S_dossier_ANS.sch"/>
    <include href="../include/sections/S_elementsCliniquesRapportes_ANS.sch"/>
    <include href="../include/sections/S_facteursDeRisque_ANS.sch"/>
    <include href="../include/sections/S_facteursDeRisque-non-code_ANS.sch"/>
    <include href="../include/sections/S_historiqueExamensBiologiques_ANS.sch"/>
    <include href="../include/sections/S_informationsAssure_ANS.sch"/>
    <include href="../include/sections/S_laborAndDelivery_ANS.sch"/>
    <include href="../include/sections/S_motifHospitalisation-non-code_ANS.sch"/>
    <include href="../include/sections/S_noteProgression_ANS.sch"/>
    <include href="../include/sections/S_pathologieAntecedentsAllergiesFacteursDeRisques_ANS.sch"/>
    <include href="../include/sections/S_pathologieEnCoursAntecedentsAllergies_ANS.sch"/>
    <include href="../include/sections/S_planTraitement_ANS.sch"/>
    <include href="../include/sections/S_protheseEtObjetPersonnel_ANS.sch"/>
    <include href="../include/sections/S_resultatExamBio-non-code_ANS.sch"/>
    <include href="../include/sections/S_resultatLaboBioSeconde_ANS.sch"/>
    <include href="../include/sections/S_scoreEvaluationClinique_ANS.sch"/>
    <include href="../include/sections/S_scoreGlasgow_ANS.sch"/>
    <include href="../include/sections/S_scoreNIHSS_ANS.sch"/>
    <include href="../include/sections/S_scoreRankin_ANS.sch"/>
    <include href="../include/sections/S_statutDoc_ANS.sch"/>
    <include href="../include/sections/S_statutDossierRCP_ANS.sch"/>
    <include href="../include/sections/S_traitementsMaladiesRares_ANS.sch"/>
    <include href="../include/sections/S_traitementsSortie-non-code_ANS.sch"/>
    <include href="../include/sections/S_travailAccouchement-non-code_ANS.sch"/>
    <include href="../include/sections/S_dispositions_ANS.sch"/>
    <include href="../include/sections/S_travailEtAccouchement_ANS.sch"/>
    <include href="../include/sections/S_principalMotif-non-code_ANS.sch"/>
    
    <!-- Entrées créées par l'ANS -->
    
    <include href="../include/entrees/E_dispositifMedical-2_ANS.sch"/>
    <include href="../include/entrees/E_dispositifMedicalComplement_ANS.sch"/>
    <include href="../include/entrees/E_dispositifMedicalImplante_ANS.sch"/>
    <include href="../include/entrees/E_enRapportAccidentTravail_ANS.sch"/>
    <include href="../include/entrees/E_enRapportALD_ANS.sch"/>
    <include href="../include/entrees/E_horsAMM_ANS.sch"/>
    <include href="../include/entrees/E_nonRemboursable_ANS.sch"/>
    <include href="../include/entrees/E_observationNIHSSComponent_ANS.sch"/>
    <include href="../include/entrees/E_observationScoreNIHSS_ANS.sch"/>
    <include href="../include/entrees/E_organizerDocumentAttache_ANS.sch"/>
    <include href="../include/entrees/E_organizerRCP_ANS.sch"/>
    <include href="../include/entrees/E_organizerTraitementInitialAVC_ANS.sch"/>


    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->

    <phase id="CI-SIS_Modeles_ANS"> 

        <!-- Activition des sections -->
        <active pattern="S_allergiesIntolerances_ANS"/>
        <active pattern="S_anamnese_ANS"/>
        <active pattern="S_anamneseEtFacteursDeRisques_ANS"/>
        <active pattern="S_antecedentsMedicaux_ANS"/>
        <active pattern="S_bilan-diagnostic-immediat_ANS"/>
        <active pattern="S_bilanPre-therapeutique_ANS"/>
        <active pattern="S_cadrePropositionTherapeutique_ANS"/><!--
        <active pattern="S_cadrePropositionTherapeutiqueFRCP_ANS"/>-->
        <active pattern="S_comment_ANS"/>
        <active pattern="S_conclusionCR-ACP_ANS"/>
        <active pattern="S_conclusionCRO_ANS"/>
        <active pattern="S_conclusionCR-ACP_ANS"/>
        <active pattern="S_diagnosticSortie_ANS"/>
        <active pattern="S_dispositifs_medicaux_ANS"/>
        <active pattern="S_dispositionsMedicoSociales_ANS"/>
        <active pattern="S_documentsAjoutes_ANS"/>
        <active pattern="S_documentsReferences_ANS"/>
        <active pattern="S_dossier_ANS"/>
        <active pattern="S_elementsCliniquesRapportes_ANS"/>
        <active pattern="S_facteursDeRisque_ANS"/>
        <active pattern="S_facteursDeRisque-non-code_ANS"/>
        <active pattern="S_historiqueExamensBiologiques_ANS"/>
        <active pattern="S_historiqueExamensBiologiques_ANS"/>
        <active pattern="S_informationAssure_ANS"/>
        <active pattern="S_laborAndDelivery_ANS"/>
        <active pattern="S_motifHospitalisation-non-code_ANS"/>
        <active pattern="S_noteProgression_ANS"/>
        <active pattern="S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS"/>
        <active pattern="S_pathologieAntecedentsAllergies_ANS"/>
        <active pattern="S_planTraitement_ANS"/>
        <active pattern="S_protheseEtObjetPersonnel_ANS"/>
        <active pattern="S_resultatExamBio-non-code_ANS"/>
        <active pattern="S_resultatLaboBioSeconde_ANS"/>
        <active pattern="S_scoreEvaluationClinique_ANS"/>
        <active pattern="S_scoreGlasgow_ANS"/>
        <active pattern="S_scoreNIHSS_ANS"/>
        <active pattern="S_scoreRankin_ANS"/>
        <active pattern="S_statutDoc_ANS"/>
        <active pattern="S_statutDossierRCP_ANS"/>
        <active pattern="S_traitementsMaladiesRares_ANS"/>
        <active pattern="S_traitementsSortie-non-code_ANS"/>
        <active pattern="S_travailAccouchement-non-code_ANS"/>
        <active pattern="S_dispositions_ANS"/>
        <active pattern="S_travailEtAccouchement_ANS"/>
        <active pattern="S_principalMotif-non-code_ANS"/>
 
        <!-- Activation des entrées  -->
        <active pattern="E_dispositifMedical-2_ANS"/>
        <active pattern="E_dispositifMedicalComplement_ANS"/>
        <active pattern="E_dispositifMedicalImplante_ANS"/>
        <active pattern="E_enRapportAccidentTravail_ANS"/>
        <active pattern="E_enRapportALD_ANS"/>
        <active pattern="E_horsAMM_ANS"/>
        <active pattern="E_nonRemboursable_ANS"/>
        <active pattern="E_observationNIHSSComponent_ANS"/>
        <active pattern="E_observationScoreNIHSS_ANS"/>
        <active pattern="E_organizerDocumentAttache_ANS"/>
        <active pattern="E_organizerRCP_ANS"/>
        <active pattern="E_organizerTraitementInitialAVC_ANS"/>

    </phase>
</schema>
