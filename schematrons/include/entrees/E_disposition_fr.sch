<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_disposition_fr.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "FR-Disposition (1.3.6.1.4.1.19376.1.5.3.1.1.10.4.2)" aux spécifications françaises. 

    Historique :
    26/05/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_disposition_fr">
    <title>CI-SIS Entrée FR-Disposition</title>
    
    <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.3.97']">
        
        <assert test='count(cda:id)=1'>
            [E_disposition_fr] Erreur de Conformité CI-SIS : 
            Une entrée 'FR_Disposition' ne peut avoir qu'un seul identifiant (id).
        </assert>
        
        <assert test='count(cda:statusCode)=1'>
            [E_disposition_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR_Disposition' doit comporter un (et un seul) élément statusCode.
        </assert>
        
        <assert test="count(cda:text/cda:reference[@value])=1">
            [E_disposition_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR_Disposition' doit comporter un (et un seul) élément 'text' avec une 'reference'.
        </assert>
        
        <assert test="count(cda:code)=1">
            [E_disposition_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR_Disposition' doit comporter un (et un seul) élément 'code'.
        </assert>
        <assert test="cda:code/@code='11302-7'">
            [E_disposition_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR_Disposition' doit comporter le code 11302-7.
        </assert>
        
    </rule>
    
</pattern>
