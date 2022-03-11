<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_SDMMR.sch
    Teste la conformité de l'entete du volet SDMMR au CI-SIS
    
    Historique :
    07/02/2018 :  NMA : Création
    11/02/2019 : APE : Ajout du contrôle du nom de famille obligatoire
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_SDMMR">
    
    <rule context='cda:ClinicalDocument'>
         
        <assert test="cda:recordTarget/cda:patientRole/cda:patient/cda:birthTime">
            [Entete_SDMMR] La date de naissance du patient est obligatoirement présente 
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:code[@code='P2-00130']">
            [Entete_SDMMR] L'attribut code de l'élément documentationOf/serviceEvent/Code est fixé à 'P2-00130'
        </assert>
        
        <assert test="cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:family[@qualifier='BR']">
            [Entete_SDMMR] Le nom de famille du patient (élément family) est obligatoire et son attribut qualifier doit être fixé à 'BR'
        </assert>        
    </rule>
    
</pattern>