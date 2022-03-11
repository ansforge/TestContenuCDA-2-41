<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_historyOfTobaccoUse.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "History of Tobacco Use" (1.3.6.1.4.1.19376.1.5.3.1.1.9.8)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    24/06/11 : CRI : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_historyOfTobaccoUse">
    
    <title>IHE PCC v3.0 History of Tobacco Use Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.8"]'>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_historyOfTobaccoUse] Erreur de conformité PCC :  history Of Tobacco Use ne peut être utilisé que dans une section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "11366-2"]'> 
            [S_historyOfTobaccoUse] Erreur de conformité PCC :  Le code de la section history Of Tobacco Use doit être 11366-2 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_historyOfTobaccoUse] Erreur de conformité PCC :  L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
    </rule>
    
</pattern>

