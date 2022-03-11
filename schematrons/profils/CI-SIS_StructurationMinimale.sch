<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_StructurationMinimale.sch
    ......................................................................................................................................................
    Vérification de la conformité sémantique au volet Structuration Commune des Documents Médicaux du CI-SIS.
    ......................................................................................................................................................
    Utilisation des répertoires sous testContenuCDA :
    - testContenuCDA : les documents CDA d'exemples conformes au CI-SIS, ainsi que la feuille de style par défaut cda_asip.xsl pour la visualisation
    - - documentsAnnexes : Des documents annexes liés aux exemples et des documents de référence
    - - infrastructure/cda : Le schéma XML CDA.xsd
    - - jeuxDeValeurs : les jeux de valeurs du CI-SIS dans le format SVS.xsd
    - - processable/coreschemas : Les sous-schémas XML de CDA.xsd (de l'édition normative HL7 v3 de 2005, correspondant à CDAr2)
    - - schematrons : les schématrons des volets du CI-SIS sous la forme source (<CI-SIS_<nom>.sch) et sous la forme compilée en xslt2 (<CI-SIS_<nom>.xsl)
    - - - abstract : les sous-schématrons de patterns abstraits (un fichier par abstract pattern)
    - - - include : les sous-schématrons de patterns concrets (un fichier par pattern)
    - - - - sections : les sous-schématrons de patterns pour la vérification de conformité des sections du corps CDA
    - - - - - entries : les sous-schématrons de patterns pour la vérification de conformité des entries du corps CDA
    - - - moteur : le moteur xslt2 de vérification de conformité sémantique d'un document d'exemple, 
                   avec ses différents composants : saxon9he.jar, script verif.bat et feuilles de transformation xslt2 intermédiaires
    - - - rapports : les rapports de vérification de conformité produits, et la feuille de style qui sert à leur visualisation
    ......................................................................................................................................................
    Pour réaliser le schematron d'un volet de contenu du CI-SIS :
        1) Recopier le présent schématron sous le nom CI-SIS_<nom du volet>.sch, dans le répertoire courant (schematrons)
        2) conserver les include, pattern existants, à l'exception du pattern et de l'include nonXMLBody inutiles pour un volet structuré.
        3) Créer dans le répertoire include les patterns concrets supplémentaires requis par le volet (ou réutiliser ceux qui sont réutilisables)
        4) le cas échéant créer dans le répertoire abstract les paterns abstraits supplémentaires requis par le volet
        5) Inclure tous les patterns supplémentaires dans le schématron CI-SIS_<nom du volet>.sch
        6) Activer dans la phase "latotale<aaaammjj>" les patterns concrets supplémentaires.
        7) La première opération de validation de conformité d'un document au volet compilera le schematron en xslt2 : CI-SIS_<nom du volet>.xsl
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
        14/03/18 : NMA : Compléments
        17/02/20 : NMA : Création du schématron abstrait dansTypeCode et du schématron JDV_participationType.sch
        27/10/20 : APE : Ajout du schématron JDV_authorFunctionCode.sch
        27/10/20 : APE : Ajout du schématron JDV_administrativeGenderCode.sch
        27/10/20 : APE : Suppression du schématron abstrait "dansTypeCode.sch" et du schématron "JDV_participationType.sch" qui ne servent à rien puisque le typeCode est contrôlé par le schéma CDA.
        27/10/20 : APE : Suppression du schématron abstrait "personName20110627.sch" qui n'est pas utilisé
        27/10/20 : APE : Regroupement des valeurs des JDV JDV_J01-XdsAuthorSpecialty-CISIS et JDV_J48-ProfessionNonPS-CISIS dans le JDV_AuthorSpecialty-CISIS pour le contrôle du code profession/spécialité de l'auteur
        28/10/20 : APE : Déplacement des schématrons de JDV de l'en-tête dans le nouveau répertoire include\jeuxDeValeurs\en-tête
        28/10/20 : APE : Renommage du schématron documentCode.sch en JDV_typeCode.sch et déplacé dans le nouveau répertoire include\jeuxDeValeurs\en-tête
        28/10/20 : APE : Renommage du schématron HumanSubstanceAdministrationSite.sch en JDV_substanceAdministration_approachSiteCode.sch
        28/10/20 : APE : Création des schématrons de JDV de l'en-tête : JDV_authenticatorSpecialty.sch, JDV_componentOfResponsibleSpecialty, JDV_legalAuthenticatorSpecialty.sch, JDV_informantRelatedEntityCode.sch
        30/11/20 : APE : Modification pour eP-MED
        28/12/20 : ANS : Mise en conformité volet structuration minimale v1.7
        09/06/21 : ANS : Suppression du schématron JDV_SeverityObservation.sch
--> 
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="Struct_minimale" 
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2" xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_StructurationMinimale.sch">
    <title>Rapport de conformité du document aux spécifications françaises (en-tête)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    <ns prefix="lab" uri="urn:oid:1.3.6.1.4.1.19376.1.3.2"/>

    <!-- Inclusion du IHE_XDS-SD -->

    <!-- Inclusions d'abstract patterns : -->
    <include href="../abstract/IVL_TS.sch"/>
    <include href="../abstract/dansJeuDeValeurs.sch"/>   
    
    <include href="../abstract/abstractFunctionCode.sch"/> 
    <include href="../abstract/abstractHealthcareFacilityCode.sch"/>
    <include href="../abstract/abstractInformantRelatedEntityCode.sch"/> 
    <include href="../abstract/abstractSpecialty.sch"/> 
    <include href="../abstract/abstractStandardIndustryClassCode.sch"/>
    <include href="../abstract/typeCodeDansJeuDeValeurs.sch"/> 
    <include href="../abstract/abstractTypeCode.sch"/>
    <include href="../abstract/abstractEncompassingEncounterCode.sch"/>
    
    <!-- schématrons des éléments de l'en-tête -->
    <include href="../include/en-tete/addr.sch"/>   
    <include href="../include/en-tete/assignedAuthor_fr.sch"/>
    <include href="../include/en-tete/assignedEntity_fr.sch"/>
    <include href="../include/en-tete/associatedEntity_fr.sch"/>
    <include href="../include/en-tete/authenticator_fr.sch"/>
    <include href="../include/en-tete/author_fr.sch"/>
    <include href="../include/en-tete/componentOf_fr.sch"/>
    <include href="../include/en-tete/custodian_fr.sch"/>
    <include href="../include/en-tete/documentationOf_fr.sch"/>
    <include href="../include/en-tete/documentEffectiveTime.sch"/>
    <include href="../include/en-tete/informantRelatedEntity_fr.sch"/>
    <include href="../include/en-tete/informationRecipient_fr.sch"/>
    <include href="../include/en-tete/inFulfillementOf_fr.sch"/>
    <include href="../include/en-tete/legalAuthenticator_fr.sch"/>
    <include href="../include/en-tete/modeleEntete_fr.sch"/>
    <include href="../include/en-tete/participant_fr.sch"/>
    <include href="../include/en-tete/recordTarget_fr.sch"/>
    <include href="../include/en-tete/relatedDocument_fr.sch"/>
    <include href="../include/en-tete/serviceEventLabStatusCode.sch"/>
    <include href="../include/en-tete/telecom.sch"/>
    
    <!-- schématrons des JDV de l'en-tête -->   
    <include href="../include/jeuxDeValeurs/en-tête/JDV_authenticatorSpecialty.sch"/>
    <include href="../include/jeuxDeValeurs/en-tête/JDV_authorFunctionCode.sch"/>
    <include href="../include/jeuxDeValeurs/en-tête/JDV_authorSpecialty.sch"/>
    <include href="../include/jeuxDeValeurs/en-tête/JDV_componentOfResponsibleSpecialty.sch"/>
    <include href="../include/jeuxDeValeurs/en-tête/JDV_healthcareFacilityCode.sch"/> 
    <include href="../include/jeuxDeValeurs/en-tête/JDV_informantRelatedEntityCode.sch"/>
    <include href="../include/jeuxDeValeurs/en-tête/JDV_legalAuthenticatorSpecialty.sch"/> 
    <include href="../include/jeuxDeValeurs/en-tête/JDV_participantFunctionCode.sch"/>
    <include href="../include/jeuxDeValeurs/en-tête/JDV_participantAssociatedEntityCode.sch"/>
    <include href="../include/jeuxDeValeurs/en-tête/JDV_standardIndustryClassCode.sch"/>  
    <include href="../include/jeuxDeValeurs/en-tête/JDV_typeCode.sch"/> 
    <include href="../include/jeuxDeValeurs/en-tête/JDV_confidentialityCode.sch"/> 
    <include href="../include/jeuxDeValeurs/en-tête/JDV_encompassingEncounterCode.sch"/>
     
    <!-- schématrons des JDV génériques -->
    <include href="../include/jeuxDeValeurs/JDV_clinicalStatusCodes.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_healthStatusCodes.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_substanceAdministration_approachSiteCode.sch"/> 
    <include href="../include/jeuxDeValeurs/JDV_problemCodes.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_actSubstanceAdministrationImmunizationCode.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_observationIntoleranceType.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_substanceAdministration_ImmunizationRouteCodes.sch"/>
<!--    <include href="../include/jeuxDeValeurs/JDV_substanceAdministration_RouteOfAdministration.sch"/>-->
    <include href="../include/jeuxDeValeurs/JDV_vitalSignCode.sch"/>   
    <include href="../include/jeuxDeValeurs/JDV_administrativeGenderCode.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->

    <phase id="Struct_minimale">

        <!-- obligatoire dans tout schématron -->
        <active pattern="variablesSM"/>

        <!-- schématrons des éléments de l'en-tête -->
        <active pattern="addr"/>
        <active pattern="assignedAuthor_fr"/>
        <active pattern="assignedEntity_fr"/>
        <active pattern="associatedEntity_fr"/>
        <active pattern="authenticator_fr"/>
        <active pattern="author_fr"/>
        <active pattern="componentOf_fr"/>
        <active pattern="custodian_fr"/>
        <active pattern="documentationOf_fr"/>
        <active pattern="documentEffectiveTime"/>
        <active pattern="informantRelatedEntity_fr"/>
        <active pattern="informationRecipient_fr"/>
        <active pattern="inFulfillmentOf_fr"/>
        <active pattern="legalAuthenticator_fr"/>
        <active pattern="modeleEntete_fr"/>
        <active pattern="participant_fr"/>
        <active pattern="recordTarget_fr"/>
        <active pattern="relatedDocument_fr"/>         
        <active pattern="serviceEventLabStatusCode"/>        
        <active pattern="telecom"/>
        
        <!-- schématrons des JDV de l'en-tête -->
        <active pattern="JDV_authenticatorSpecialty"/> 
        <active pattern="JDV_authorFunctionCode"/>
        <active pattern="JDV_authorSpecialty"/>
        <active pattern="JDV_componentOfResponsibleSpecialty"/>
        <active pattern="JDV_healthcareFacilityCode"/>    
        <active pattern="JDV_informantRelatedEntityCode"/>
        <active pattern="JDV_legalAuthenticatorSpecialty"/>
        <active pattern="JDV_participantAssociatedEntityCode"/>
        <active pattern="JDV_participantFunctionCode"/>
        <active pattern="JDV_standardIndustryClassCode"/>
        <active pattern="JDV_typeCode"/>
        <active pattern="JDV_confidentialityCode"/>
        <active pattern="JDV_encompassingEncounterCode"/>
        
        <!-- schématrons des JDV génériques -->
        <active pattern="JDV_actSubstanceAdministrationImmunizationCode"/>
        <active pattern="JDV_clinicalStatusCodes"/>
        <active pattern="JDV_healthStatusCodes"/>        
        <active pattern="JDV_observationIntoleranceType"/>  
        <active pattern="JDV_problemCodes"/>        
        <active pattern="JDV_substanceAdministration_approachSiteCode"/>         
        <active pattern="JDV_substanceAdministration_ImmunizationRouteCodes"/>
<!--        <active pattern="JDV_substanceAdministration_RouteOfAdministration"/>-->
        <active pattern="JDV_vitalSignCode"/>     
        <active pattern="JDV_administrativeGenderCode"/>
         
    </phase>

    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Variables globales          -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->

    <pattern id="variablesSM">
        
        <!-- JDV de l'en-tête -->          
        <let name="jdv_authenticatorSpecialty" value="'../../jeuxDeValeurs/JDV_AuthorSpecialty-CISIS.xml'"/>
        <let name="jdv_authorFunctionCode_1" value="'../../jeuxDeValeurs/TRE_R258-RelationPriseCharge.xml'"/>
        <let name="jdv_authorFunctionCode_2" value="'../../jeuxDeValeurs/TRE_R259-HL7ParticipationFunction.xml'"/>
        <let name="jdv_authorFunctionCode_3" value="'../../jeuxDeValeurs/TRE_R85-RolePriseCharge.xml'"/>
        <let name="jdv_authorSpecialty_1" value="'../../jeuxDeValeurs/TRE_A02-ProfessionSavFaire-CISIS.xml'"/>
        <let name="jdv_authorSpecialty_2" value="'../../jeuxDeValeurs/TRE_A00-ProducteurDocNonPS.xml'"/>
        <let name="jdv_authorSpecialty_3" value="'../../jeuxDeValeurs/TRE_R85-RolePriseCharge.xml'"/>
        <let name="jdv_authorSpecialty_4" value="'../../jeuxDeValeurs/TRE_R94-ProfessionSocial.xml'"/>
        <let name="jdv_authorSpecialty_5" value="'../../jeuxDeValeurs/TRE_R95-UsagerTitre.xml'"/>
        <let name="jdv_authorSpecialty_6" value="'../../jeuxDeValeurs/TRE_R96-AutreProfDomSanitaire.xml'"/>
        <let name="jdv_componentOfResponsibleSpecialty" value="'../../jeuxDeValeurs/JDV_AuthorSpecialty-CISIS.xml'"/>
        <let name="jdv_healthcareFacilityCode_1" value="'../../jeuxDeValeurs/TRE_A00-ProducteurDocNonPS.xml'"/>
        <let name="jdv_healthcareFacilityCode_2" value="'../../jeuxDeValeurs/TRE_R02-SecteurActivite.xml'"/>
        <let name="jdv_informantRelatedEntityCode" value="'../../jeuxDeValeurs/JDV_J11-RelationPatient-CISIS.xml'"/>
        <let name="jdv_informantRelatedEntityCode_1" value="'../../jeuxDeValeurs/TRE_R216-HL7RoleCode.xml'"/>
        <let name="jdv_informantRelatedEntityCode_2" value="'../../jeuxDeValeurs/TRE_R217-ProtectionJuridique.xml'"/>
        <let name="jdv_legalAuthenticatorSpecialty" value="'../../jeuxDeValeurs/JDV_AuthorSpecialty-CISIS.xml'"/>
        <let name="jdv_participantFunctionCode_1" value="'../../jeuxDeValeurs/TRE_R258-RelationPriseCharge.xml'"/>
        <let name="jdv_participantFunctionCode_2" value="'../../jeuxDeValeurs/TRE_R259-HL7ParticipationFunction.xml'"/>
        <let name="jdv_participantFunctionCode_3" value="'../../jeuxDeValeurs/TRE_R85-RolePriseCharge.xml'"/>
        <let name="jdv_participantAssociatedEntityCode_1" value="'../../jeuxDeValeurs/TRE_A02-ProfessionSavFaire-CISIS.xml'"/>
        <let name="jdv_participantAssociatedEntityCode_2" value="'../../jeuxDeValeurs/TRE_A00-ProducteurDocNonPS.xml'"/>
        <let name="jdv_participantAssociatedEntityCode_3" value="'../../jeuxDeValeurs/TRE_R85-RolePriseCharge.xml'"/>
        <let name="jdv_participantAssociatedEntityCode_4" value="'../../jeuxDeValeurs/TRE_R94-ProfessionSocial.xml'"/>
        <let name="jdv_participantAssociatedEntityCode_5" value="'../../jeuxDeValeurs/TRE_R95-UsagerTitre.xml'"/>
        <let name="jdv_participantAssociatedEntityCode_6" value="'../../jeuxDeValeurs/TRE_R96-AutreProfDomSanitaire.xml'"/>
        <let name="jdv_standardIndustryClassCode_1" value="'../../jeuxDeValeurs/TRE_A00-ProducteurDocNonPS.xml'"/>
        <let name="jdv_standardIndustryClassCode_2" value="'../../jeuxDeValeurs/TRE_A01-CadreExercice.xml'"/>
        <let name="jdv_typeCode_1" value="'../../jeuxDeValeurs/TRE_A04-Loinc.xml'"/>
        <let name="jdv_typeCode_2" value="'../../jeuxDeValeurs/TRE_A05-TypeDocComplementaire.xml'"/>
        <!-- <let name="jdv_typeCode" value="'../../jeuxDeValeurs/JDV_J07-XdsTypeCode-CISIS.xml'"/> --> 
        <let name="jdv_confidentialityCode" value="'../../jeuxDeValeurs/TRE_A08-HL7Confidentiality.xml'"/>
        <let name="jdv_encompassingEncounterCode_1" value="'../../jeuxDeValeurs/TRE_R304-HL7v3ActCode.xml'"/>
        <let name="jdv_encompassingEncounterCode_2" value="'../../jeuxDeValeurs/TRE_R305-TypeRencontre.xml'"/>
        
        <!-- JDV génériques -->
        <let name="jdv_actSubstanceAdministrationImmunizationCode" value="'../../jeuxDeValeurs/JDV_HL7_ActSubstanceAdministrationImmunizationCode-CISIS.xml'"/>        
        <let name="jdv_clinicalStatusCodes" value="'../../jeuxDeValeurs/JDV_ClinicalStatusCodes-CISIS.xml'"/>
        <let name="jdv_healthStatusCodes" value="'../../jeuxDeValeurs/JDV_HealthStatusCodes-CISIS.xml'"/>        
        <let name="jdv_observationIntoleranceType" value="'../../jeuxDeValeurs/JDV_HL7_ObservationIntoleranceType-CISIS.xml'"/>
        <let name="jdv_problemCodes" value="'../../jeuxDeValeurs/JDV_ProblemCodes-CISIS.xml'"/>
        <let name="jdv_substanceAdministration_approachSiteCode" value="'../../jeuxDeValeurs/JDV_HL7_HumanSubstanceAdministrationSite-CISIS.xml'"/>
        <let name="jdv_substanceAdministration_ImmunizationRouteCodes" value="'../../jeuxDeValeurs/JDV_HL7_ImmunizationRouteCodes-CISIS.xml'"/>
<!--        <let name="jdv_substanceAdministration_RouteOfAdministration" value="'../../jeuxDeValeurs/JDV_HL7_RouteOfAdministration-CISIS.xml'"/>-->
        <let name="jdv_vitalSignCode" value="'../../jeuxDeValeurs/JDV_SignesVitaux-CISIS.xml'"/>
        <let name="jdv_administrativeGenderCode" value="'../../jeuxDeValeurs/TRE_R303-HL7v3AdministrativeGen.xml'"/>
        
    </pattern>

</schema>
