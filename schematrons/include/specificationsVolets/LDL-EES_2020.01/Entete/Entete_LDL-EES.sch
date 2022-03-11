<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_LDL-EES.sch
    Teste la conformité de l'entete du volet LDL-EES au CI-SIS
    
    Historique :
    07/02/2018 : Création    
    03/05/2021 : Modification des msg d'erreur
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_LDL-EES">
    
    <rule context='cda:ClinicalDocument'>
        
        <assert test="cda:code[@code='18761-7']">
            [Entete_LDL-EES] Erreur de conformité : L'élément
            "code" de la LDL-SES doit avoir les attributs @code="18761-7" et
            @codeSystem="2.16.840.1.113883.6.1".
        </assert>
        
        <assert test="cda:recordTarget/cda:patientRole/cda:patient/cda:birthTime">
            [Entete_LDL-EES] Erreur de conformité : La date de naissance du patient est obligatoire.
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:code[@code='IMP']">
            [Entete_LDL-EES] Erreur de conformité : L'attribut code de l'élément documentationOf/serviceEvent/code est fixé à 'IMP'
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime">
            [Entete_LDL-EES] Erreur de conformité : La date du début d'exécution de l'acte est obligatoire.
        </assert>
        
    </rule>
</pattern>