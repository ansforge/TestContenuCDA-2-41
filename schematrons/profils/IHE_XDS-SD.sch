<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    IHE_XDS-SD.sch
    ......................................................................................................................................................
    Auteur : ANS
    ......................................................................................................................................................
    Vérification de la conformité sémantique aux spécifications IHE de l'en-tête
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
        01/12/20 : ANS : Mise à jour du texte     
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="xds-sd"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2" xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="IHE_XDS-SD.sch">
    <title>Rapport de conformité du document aux spécifications IHE (en-tête)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    <ns prefix="lab" uri="urn:oid:1.3.6.1.4.1.19376.1.3.2"/>
    
    <!-- en-tête et génériques -->  
    <include href="../include/en-tete/recordTarget_int.sch"/>
    <include href="../include/en-tete/author_int.sch"/>
    <include href="../include/en-tete/legalAuthenticator_int.sch"/>
   
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="xds-sd">
        <active pattern="author_int"/>
        <active pattern="legalAuthenticator_int"/>        
        <active pattern="recordTarget_int"/>
    </phase>
</schema>