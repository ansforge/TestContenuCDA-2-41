<?xml version="1.0" encoding="UTF-8"?>

<!-- S_physicalFunction.sch

Teste la conformité de la section "Physical Function" (1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5) aux spécifications IHE

Historique :

    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId

-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_physicalFunction">
    
    <title>Section Physical Function</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_PhysicalFunction] Erreur de Conformité : Le templateId de 'Physical Function' ne peut être utilisé que pour une section. 
        </assert> 
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "46006-3"]'> 
            [S_PhysicalFunction] Erreur de Conformité  : Le code de la section Physical Function doit être '46006-3' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_PhysicalFunction] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
    </rule>
    
</pattern>