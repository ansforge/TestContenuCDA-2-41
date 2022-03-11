<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_CR-RTN.sch
    Teste la conformité de l'entete du CR-RTN au CI-SIS
    
    Historique :
    02/02/2018 : Création
    22/02/2021 : Renommage
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_CR-RTN">
    
    <rule context='cda:ClinicalDocument'>
        
        <assert test="cda:code[@code='75492-9']">
            [Entete_OPH-CR-RTN] L'élément code doit être présent et égal à 75492-9
        </assert>
        <!-- Volet OPH-CR-RTN : "Le médecin prescripteur est un élément obligatoire" -->
        <assert test="cda:participant[@typeCode='REF']"> 
            [Entete_OPH-CR-RTN] Erreur de conformité : 
            L'élément participant Médecin prescripteur est un élément obligatoire du volet OPH-CR-RTN 
            (attribut typeCode fixé à 'REF')
        </assert>
        
        <!-- Volet OPH-CR-RTN : "L'ophtalmologiste est un élément obligatoire" -->
        <assert test="cda:participant[@typeCode='REFT']"> 
            [Entete_OPH-CR-RTN] Erreur de conformité : 
            L'élément participant ophtalmologiste  est un élément obligatoire du volet OPH-CR-RTN 
            (attribut typeCode fixé à 'REFT')
        </assert>
        
        <assert test="cda:participant[@typeCode='REF']/cda:associatedEntity/cda:telecom"> 
            [Entete_OPH-CR-RTN] Erreur de conformité : 
            L'élément associatedEntity/telecom du participant Médecin prescripteur est un élément obligatoire du volet OPH-CR-RTN 
        </assert>
        
        <assert test="cda:participant[@typeCode='REF']/cda:associatedEntity/cda:addr"> 
            [Entete_OPH-CR-RTN] Erreur de conformité : 
            L'élément associatedEntity/addr du participant Médecin prescripteur est un élément obligatoire du volet OPH-CR-RTN 
        </assert>
        
        <!-- Volet CR-RTN : "Les éléments <telecom> et <addr> sont obligatoires pour l'élément legalAuthenticator" -->
        <assert test="cda:legalAuthenticator/cda:assignedEntity/cda:addr">
            [Entete_OPH-CR-RTN] Erreur de conformité : L'élément "addr" doit être présent sous legalAuthenticator/assignedEntity 
            dans le cadre du volet OPH-CR-RTN
        </assert>
        
        <assert test="cda:legalAuthenticator/cda:assignedEntity/cda:telecom">
            [Entete_OPH-CR-RTN] Erreur de conformité : L'élément "telecom" doit être présent sous legalAuthenticator/assignedEntity
            dans le cadre du volet OPH-CR-RTN
        </assert>
        
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent'>
        
        <assert test="cda:performer/cda:assignedEntity">
            [Entete_OPH-CR-RTN]  L'élément performer et le sous élément assignedEntity sont obligatoires dans le cadre du volet CR-RTN
        </assert>
        <assert test="cda:performer/cda:assignedEntity/cda:representedOrganization">
            [Entete_OPH-CR-RTN]  Le lieu d'exercice est obligatoire dans le cadre du volet CR-RTN
        </assert>
        
    </rule>
</pattern>