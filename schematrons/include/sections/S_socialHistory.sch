<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_socialHistory.sch ]O@%#o>>=-

Teste la conformité de la section "Social History" (1.3.6.1.4.1.19376.1.5.3.1.3.16)
aux spécifications d'IHE PCC v3.0

Historique :
    22/03/2018 : NMA : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_socialHistory">
   
    <title>IHE PCC v3.0 Social History Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.16"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_socialHistory] Erreur de Conformité PCC : Le templateId de 'Social History' ne peut être utilisé que pour une section.
        </assert> 
        
        <!-- Vérifier que le templateId parent est bien présent. --> 
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.15"]'> 
            [S_socialHistory] Erreur de Conformité PCC : Le templateId 2.16.840.1.113883.10.20.1.15 parent obligatoire de la section est absent. 
        </assert>         
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "29762-2"]'> 
            [S_socialHistory] Erreur de Conformité PCC : Le code de la section 'Social History' doit être 29762-2
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_socialHistory] Erreur de Conformité PCC : L'attribut 'codeSystem' de la section 'Social History' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 
        
    </rule>
    
</pattern>

