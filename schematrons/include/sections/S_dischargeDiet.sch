<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0 Discharge Diet Section: 1.3.6.1.4.1.19376.1.5.3.1.3.33 -->

<!--                  -=<<o#%@O[ S_dischargeDiet.sch ]O@%#o>>=-
    
    Teste la conformité de la section "discharge Diet" (1.3.6.1.4.1.19376.1.5.3.1.3.33)
    aux spécifications d'IHE PCC v3.0
    Aucune des entrées codées ne sont obligatoires pour cette section qui peut n'être
    que narrative.

    Historique :
    10/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_dischargeDiet">
    <title>IHE PCC v3.0 discharge Diet Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.33"]'>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_dischargeDiet.sch] Erreur de conformité PCC : 'discharge Diet' ne peut être utilisé que comme section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "42344-2"]'> 
            [S_dischargeDiet.sch] Erreur de conformité PCC : Le code de la section 'discharge Diet' doit être '42344-2' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_dischargeDiet.sch] Erreur de conformité PCC :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
        </assert> 
      
    </rule>
    
</pattern>