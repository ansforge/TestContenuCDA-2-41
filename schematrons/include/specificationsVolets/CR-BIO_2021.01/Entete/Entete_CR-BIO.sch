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
        <assert test='cda:title = "Compte rendu d&apos;examens biologiques"'>
            [Entete_CR-BIO] L'élément title est obligatoire et doit être fixé à "Compte rendu d'examens biologiques".
        </assert>
        <assert test='cda:code[@code="11502-2" and @displayName="CR d&apos;examens biologiques" and @codeSystem="2.16.840.1.113883.6.1"]'>
            [Entete_CR-BIO] L'élément code est obligatoire et doit être fixé à @code="11502-2" @displayName="CR d'examens biologiques" @codeSystem="2.16.840.1.113883.6.1".
        </assert>
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.3.3"]'>
            [Entete_CR-BIO] L'élément templateId fixé à @root="1.3.6.1.4.1.19376.1.3.3" est obligatoire
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:recordTarget/cda:patientRole'>         
        <assert test='not(cda:addr[@nullFlavor]) or cda:addr[@nullFlavor="UNK"]'>
            [Entete_CR-BIO] Si aucune adresse n’est connue, utiliser la valeur nullFlavor='UNK'.
        </assert>
        <assert test='not(cda:telecom[@nullFlavor]) or cda:telecom[@nullFlavor="UNK"]'>
            [Entete_CR-BIO] Si aucune coordonnée n’est connue, utiliser la valeur nullFlavor='UNK'.
        </assert>
        <assert test='not(cda:patient/cda:administrativeGenderCode[@nullFlavor]) or cda:patient/cda:administrativeGenderCode[@nullFlavor="UNK"]'>
            [Entete_CR-BIO] Si le sexe n’est pas connu, utiliser la valeur nullFlavor='UNK'.
        </assert>
        <assert test='not(cda:patient/cda:birthTime[@nullFlavor]) or cda:patient/cda:birthTime[@nullFlavor="UNK"]'>
            [Entete_CR-BIO] Si la date de naissance n’est pas connue, utiliser la valeur nullFlavor='UNK'.
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:authenticator'>
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.1.5']">
            [Entete_CR-BIO] Le templateId "1.3.6.1.4.1.19376.1.3.3.1.5" de l'élément authenticator est obligatoire.
        </assert>
        
        <assert test="cda:time">
            [Entete_CR-BIO] La date de la dernière validation effectuée par le biologiste médical est obligatoire.
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
        <assert test="cda:assignedEntity/cda:addr">
            [Entete_CR-BIO] L'Adresse du directeur du laboratoire est obligatoire.
        </assert>
        <assert test="cda:assignedEntity/cda:telecom">
            [Entete_CR-BIO] Les Coordonnées télécom du directeur du laboratoire sont obligatoires.
        </assert>
        <assert test="cda:assignedEntity/cda:assignedPerson/cda:name">
            [Entete_CR-BIO] Le nom du directeur de laboratoire est obligatoire.
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