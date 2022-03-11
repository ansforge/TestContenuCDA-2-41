<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_transfusionHistory.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "transfusion History" (1.3.6.1.4.1.19376.1.5.3.1.1.9.12)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_transfusionHistory">
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.12"]'> 
        
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test='../cda:section'> 
            [S_transfusionHistory] Erreur de conformité CI-SIS: transfusion History ne peut être utilisé qu'en tant que section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "56836-0"]'> 
            [S_transfusionHistory] Erreur de conformité CI-SIS: Le code de la section transfusion History doit être 56836-0 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_transfusionHistory] Erreur de conformité CI-SIS: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        
    </rule> 
    
</pattern>

