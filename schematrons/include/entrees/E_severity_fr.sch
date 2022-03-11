<?xml version="1.0" encoding="UTF-8"?>

<!-- E_severity_fr.sch
    
    Teste la conformité de l'entrée FR-Severite (severity - 1.3.6.1.4.1.19376.1.5.3.1.4.1)      
    
    Historique :
    27/06/2017 : Création
    01/12/2020 : Renommé
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_severity_fr">

    <title>CI-SIS Severity</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.1"]'>
          <assert test='cda:code[@code="SEV"]'>
            [ER_severity_fr] Erreur de Conformité CI-SIS: L'élément 'code' de l'entrée 'severity' indique la 
            sévérité de l'allergie provoquée.
            L'attribut code de l'élément 'code' est fixé à 'SEV'.</assert>
        
    </rule>
</pattern>
