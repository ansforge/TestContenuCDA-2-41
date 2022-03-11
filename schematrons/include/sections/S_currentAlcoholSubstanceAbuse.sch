<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_S_currentAlcoholSubstanceAbuse.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "Current Alcohol / Substance Abuse" (1.3.6.1.4.1.19376.1.5.3.1.1.9.10)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    24/06/11 : CRI : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_currentAlcoholSubstanceAbuse">
    <title>IHE PCC v3.0 Current Alcohol / Substance Abuse Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.10"]'>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_currentAlcoholSubstanceAbuse] La section "Current Alcohol/Substance Abuse" ne peut être utilisée que dans une section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "18663-5"]'> 
            [S_currentAlcoholSubstanceAbuse] Le code de la section history Of Tobacco Use doit être 18663-5
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_currentAlcoholSubstanceAbuse] L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert> 
       </rule> 
</pattern>

