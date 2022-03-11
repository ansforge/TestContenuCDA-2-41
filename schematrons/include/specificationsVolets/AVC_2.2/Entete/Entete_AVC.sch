<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_AVC.sch
    Teste la conformité de l'entete du volet AVC au CI-SIS
    
    Historique :
    01/02/2018 :  NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_AVC">
    
    <rule context='cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent'>
         
        <!-- Teste la présence de la representedOrganisation -->
        <assert test="cda:performer/cda:assignedEntity/cda:representedOrganization">
            [Entete_AVC] L'organisation représentée est obligatoirement présente 
        </assert>
    </rule>
    
    
</pattern>