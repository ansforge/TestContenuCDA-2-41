<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_CSE.sch
    Teste la conformité de l'entete du volet CSE au CI-SIS
    
    Historique :
    02/02/2018 :  NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_CSE">
    
    <rule context='cda:ClinicalDocument/cda:recordTarget/cda:patientRole'>
         
        <!-- Teste la présence de la representedOrganisation -->
        <assert test="cda:patient/cda:birthTime and cda:patient/cda:birthplace">
            [Entete_CSE] La date et lieu de naissance du patient sont oblgatoirement présents dans le volet CSE
        </assert>
        <assert test="not(cda:patient/cda:guardian/cda:guardianPerson) or cda:patient/cda:guardian/cda:guardianPerson/cda:name/cda:family">
            [Entete_CSE] Le nom de famille du représentant est obligatoirement présent
        </assert>
    </rule>
    
    
</pattern>