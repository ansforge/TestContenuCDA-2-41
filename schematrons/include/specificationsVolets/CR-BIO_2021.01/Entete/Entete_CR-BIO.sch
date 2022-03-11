<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_CR-BIO.sch
    Teste la conformité de l'entete du CR-BIO au CI-SIS
    
    Historique :
    12/01/2021 : Création    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_CR-BIO">
    
    <rule context='cda:ClinicalDocument'>         
        <assert test="cda:setId">
            [Entete_CR-BIO] L'élément setId est obligatoire.
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:authenticator'>
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.1.5']">
            [Entete_CR-BIO] Le templateId "1.3.6.1.4.1.19376.1.3.3.1.5" de l'élément authenticator est obligatoire.
        </assert>
        
        <assert test="cda:assignedEntity/cda:addr">
            [Entete_CR-BIO] L'adresse du biologiste ayant validé des résultats est obligatoire dans l'élément authenticator.
        </assert>
        
        <assert test="cda:assignedEntity/cda:telecom">
            [Entete_CR-BIO] Les coordonnées telecom du biologiste ayant validé des résultats sont obligatoires dans l'élément authenticator.
        </assert>
        
        <assert test="(cda:assignedEntity/cda:representedOrganization/cda:id) or not (cda:assignedEntity/cda:representedOrganization)">
            [Entete_CR-BIO] L'identifiant du laboratoire est obligatoire dans l'élément authenticator/assignedEntity/representedOrganization/id.
        </assert>
        
        <assert test="(cda:assignedEntity/cda:representedOrganization/cda:name) or not (cda:assignedEntity/cda:representedOrganization)">
            [Entete_CR-BIO] Le nom du laboratoire est obligatoire dans l'élément authenticator/assignedEntity/representedOrganization/name.
        </assert>
        
        <assert test="(cda:assignedEntity/cda:representedOrganization/cda:telecom) or not (cda:assignedEntity/cda:representedOrganization)">
            [Entete_CR-BIO] Les coordonnées telecom du laboratoire sont obligatoires dans l'élément authenticator/assignedEntity/representedOrganization/telecom.
        </assert>
        
        <assert test="(cda:assignedEntity/cda:representedOrganization/cda:addr) or not (cda:assignedEntity/cda:representedOrganization)">
            [Entete_CR-BIO] L'adresse du laboratoire est obligatoire dans l'élément authenticator/assignedEntity/representedOrganization/addr.
        </assert>
    </rule> 
    
    <rule context='cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent'>
        <assert test="cda:code">
            [Entete_CR-BIO] Le code de l'acte documenté est obligatoire dans l'élément documentationOf/serviceEvent/code.
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/cda:performer'>
        <assert test="cda:time">
            [Entete_CR-BIO] La date d'exécution de l'acte documenté est obligatoire.
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:id">
            [Entete_CR-BIO] L'identifiant du laboratoire est obligatoire.
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:name">
            [Entete_CR-BIO] Le nom du laboratoire est obligatoire.
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:telecom">
            [Entete_CR-BIO] Les coordonnées telecom du laboratoire sont obligatoires.
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:addr">
            [Entete_CR-BIO] L'adresse du laboratoire est obligatoire.
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:standardIndustryClassCode">
            [Entete_CR-BIO] Le cadre d'exercice du laboratoire est obligatoire.
        </assert>
        
    </rule>

    <rule context='cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter'>
        <assert test="cda:responsibleParty/cda:assignedEntity/cda:id">
            [Entete_CR-BIO] L'identifiant du biologiste responsable doit être présent (responsibleParty/assignedEntity/id)
        </assert>
        <assert test="cda:responsibleParty/cda:assignedEntity/cda:code">
            [Entete_CR-BIO] La profession/spécialité du biologiste responsable doit être présente (responsibleParty/assignedEntity/code)
        </assert>
        <assert test="cda:responsibleParty/cda:assignedEntity/cda:assignedPerson/cda:name/cda:family">
            [Entete_CR-BIO] L'identité du biologiste responsable doit être présente (responsibleParty/assignedEntity/assignedPerson/name/family)
        </assert>

    </rule>
    
</pattern>