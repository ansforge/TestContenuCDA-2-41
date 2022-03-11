<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_ModelesDeContenusCDA.sch
    ......................................................................................................................................................
    Auteur : ANS
    ......................................................................................................................................................
    Vérification de la conformité des entrées IHE (corps d'un document CDA) aux spécifications françaises
    ......................................................................................................................................................  
    Historique :
        27/05/11 : FMY : Création
        31/05/11 : FMY : Compléments
        15/06/11 : FMY : Compléments
        27/06/11 : FMY : publication dans la version 1.0.1 du CI-SIS
        22/07/11 : FMY : Mise à jour des commentaires ci-dessus (retirer le pattern et l'include nonXMLBody), ajout variable OIDLOINC
                         ajout pattern observationInterpretation
        27/07/11 : FMY : Ajout des patterns de sections et d'entries de PCC et du CI-SIS, transversaux à tous types de documents       
        19/12/11 : FMY : Ajout du contrôle / jeu de valeurs confidentialityCode
        08/10/12 : FMY : CI-SIS 1.3 => retrait des include assignedAuthor, confidentialityCode et custodianOrganization. 
                         Maj des include assignedEntity (addr & telecom optionnels) et addr (contrôle structure des adresses)
                         Actualisation nom de fichiers include problemEntry, concernentry, procedureentry 
        24/01/13 : FMY : Ajout de contrôle de encompassingEncounter/code par rapport au jeu de valeurs CI-SIS_jdv_encompassingEncounterCode
        08/04/13 : FMA : Ajout du préfixe lab (pour CR de biologie et CR-ACP, et appel nouveau pattern serviceEventLabStatusCode
        05/12/13 : FMA : Désactivation du contrôle de l'adresse pour livraison au groupement DMP (qui n'a pas implémenté l'évolution addr)
        10/03/15 : JDS : Réactivation du contrôle de l'élément addr (spécifié dans la version du CI-SIS v1.2.0 de 2012 )
                         Maj des include serviceEventLabStatusCode20130408.sch      -> serviceEventLabStatusCode20150317.sch
                         Maj des include telecom20110728.sch                        -> telecom20150317.sch
        10/10/19 : APE : Suppression des appels aux schématrons Dispositif médical FR qui n'existe pas
        10/10/19 : APE : Renommage du nom du schématron encounter (sans 's' à la fin)
        01/12/20 : ANS : Mise à jour pour eP-MED
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_ModelesDeContenusCDA"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2" xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_ModelesDeContenusCDA.sch">
    
    <title>Rapport de conformité du document aux spécifications françaises (corps – sections, entrées, jeux de valeurs IHE)</title>

    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    <ns prefix="lab" uri="urn:oid:1.3.6.1.4.1.19376.1.3.2"/>
    <ns prefix="pharm" uri="urn:ihe:pharm"/>

    <!-- Entrées -->
    <include href="../include/entrees/E_allergiesAndIntoleranceConcern_fr.sch"/>
    <include href="../include/entrees/E_allergiesAndIntolerances_fr.sch"/>
    <include href="../include/entrees/E_autorisationSubstitution_fr.sch"/>
    <include href="../include/entrees/E_birthEventOrganizer_fr.sch"/>
    <include href="../include/entrees/E_bloodTypeObservation_fr.sch"/>
    <include href="../include/entrees/E_concernEntry_fr.sch"/>
    <include href="../include/entrees/E_encounter_fr.sch"/>
    <include href="../include/entrees/E_familyHistoryObservation_fr.sch"/>
    <include href="../include/entrees/E_immunizations_fr.sch"/>
    <include href="../include/entrees/E_instructionsPatient_fr.sch"/>
    <include href="../include/entrees/E_instructionsDispensateur_fr.sch"/>
    <include href="../include/entrees/E_itemPlanTraitement_fr.sch"/>
    <include href="../include/entrees/E_medications_fr.sch"/>
    <include href="../include/entrees/E_observationRequest_fr.sch"/>
    <include href="../include/entrees/E_patientTransfer_fr.sch"/>
    <include href="../include/entrees/E_periodeRenouvellement_fr.sch"/>  
    <include href="../include/entrees/E_pregnancyHistoryOrganizer_fr.sch"/>
    <include href="../include/entrees/E_pregnancyObservation_fr.sch"/>
    <include href="../include/entrees/E_problemConcernEntry_fr.sch"/>
    <include href="../include/entrees/E_problemEntry_fr.sch"/>
    <include href="../include/entrees/E_problemStatusObservation_fr.sch"/>
    <include href="../include/entrees/E_procedureEntry_fr.sch"/>
    <include href="../include/entrees/E_produitDeSantePrescrit_fr.sch"/>
    <include href="../include/entrees/E_quantiteProduit_fr.sch"/>
    <include href="../include/entrees/E_referenceItemPlanTraitement_fr.sch"/>
    <include href="../include/entrees/E_severity_fr.sch"/>
    <include href="../include/entrees/E_simpleObservation_fr.sch"/>
    <include href="../include/entrees/E_socialHistoryObservation_fr.sch"/>
    <include href="../include/entrees/E_supplyEntry_fr.sch"/>
    <include href="../include/entrees/E_surveyObservation_fr.sch"/>
    <include href="../include/entrees/E_traitementPrescrit_fr.sch"/>
    <include href="../include/entrees/E_traitementPrescritSubordonnee_fr.sch"/>
    <include href="../include/entrees/E_transport_fr.sch"/>
    <include href="../include/entrees/E_vitalSignsObservation_fr.sch"/>
    <include href="../include/entrees/E_vitalSignsOrganizer_fr.sch"/>  
    <include href="../include/entrees/E_disposition_fr.sch"/> 
    <include href="../include/entrees/E_statutDuDocument_fr.sch"/> 
    <include href="../include/entrees/E_evenementIndesirablePendantHospitalisation_fr.sch"/> 
    <include href="../include/entrees/E_evenementIndesirableSuiteAdministrationDerivesSang_fr.sch"/> 
    <include href="../include/entrees/E_identificationMicroOrganismesMultiresistants_fr.sch"/>
    <include href="../include/entrees/E_accidentsTransfusionnels_fr.sch"/>
    <include href="../include/entrees/E_payers_fr.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->

    <phase id="CI-SIS_ModelesDeContenusCDA">
        
        <!-- Activation des entrées  -->
        <active pattern="E_allergiesAndIntoleranceConcern_fr"/>
        <active pattern="E_allergiesAndIntolerances_fr"/>
        <active pattern="E_autorisationSubstitution_fr"/>
        <active pattern="E_birthEventOrganizer_fr"/>
        <active pattern="E_bloodTypeObservation_fr"/>
        <active pattern="E_concernEntry_fr"/>
        <active pattern="E_encounter_fr"/>
        <active pattern="E_familyHistoryObservation_fr"/>
        <active pattern="E_immunizations_fr"/>
        <active pattern="E_instructionsPatient_fr"/>
        <active pattern="E_instructionsDispensateur_fr"/>
        <active pattern="E_itemPlanTraitement_fr"/>
        <active pattern="E_medications_fr"/>
        <active pattern="E_observationRequest_fr"/>
        <active pattern="E_patientTransfer_fr"/>
        <active pattern="E_periodeRenouvellement_fr"/>
        <active pattern="E_pregnancyHistoryOrganizer_fr"/>
        <active pattern="E_pregnancyObservation_fr"/>
        <active pattern="E_problemConcernEntry_fr"/>
        <active pattern="E_problemEntry_fr"/>
        <active pattern="E_problemStatusObservation_fr"/>
        <active pattern="E_procedureEntry_fr"/>
        <active pattern="E_produitDeSantePrescrit_fr"/>
        <active pattern="E_quantiteProduit_fr"/>
        <active pattern="E_referenceItemPlanTraitement_fr"/>
        <active pattern="E_severity_fr"/>
        <active pattern="E_simpleObservation_fr"/>
        <active pattern="E_socialHistoryObservation_fr"/>
        <active pattern="E_supplyEntry_fr"/>
        <active pattern="E_surveyObservation_fr"/>
        <active pattern="E_transport_fr"/>
        <active pattern="E_traitementPrescrit_fr"/>
        <active pattern="E_traitementPrescritSubordonnee_fr"/>
        <active pattern="E_vitalSignsOrganizer_fr"/>
        <active pattern="E_vitalSignsObservation_fr"/>
        <active pattern="E_disposition_fr"/>  
        <active pattern="E_statutDuDocument_fr"/>  
        <active pattern="E_evenementIndesirablePendantHospitalisation_fr"/>
        <active pattern="E_evenementIndesirableSuiteAdministrationDerivesSang_fr"/>
        <active pattern="E_identificationMicroOrganismesMultiresistants_fr"/>
        <active pattern="E_accidentsTransfusionnels_fr"/>
        <active pattern="E_payers_fr"/>
                
    </phase>
</schema>
