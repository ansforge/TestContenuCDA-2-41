<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_VAC_2021.01.sch
    Teste la conformité de l'entete au modèle Historique de vaccination au CI-SIS
    
    Historique :
    09/04/2021 : Création
    03/09/2021 : Mise à jour du test sur le documentationOf
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_VAC_2021.01">
    
    <rule context='cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient'>
        <assert test="cda:birthTime">
            [Entete_VAC_2021.01] Erreur de conformité : La date de naissance du patient est obligatoirement présente 
        </assert>
    </rule>
    
    <rule context="cda:ClinicalDocument">
        <assert test="cda:documentationOf/cda:serviceEvent/cda:code[@code='11369-6']">
            [Entete_VAC_2021.01] Erreur de conformité : Le code de l'acte principal est codé et est fixé à code="11369-6" 
        </assert>
    </rule>
    
</pattern>