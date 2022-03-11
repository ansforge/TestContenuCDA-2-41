<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ childFunctionalStatusAssessment.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Child Functional Status Assessment" (1.3.6.1.4.1.19376.1.7.3.1.1.13.3)
    aux spécifications d'IHE PCC v3.0
    Teste la présence des deux sous-sections
    - Psychomotor development
    - Eating and Sleeping Assessment
     
    
    Historique :
    24/06/11 : CRI : Création
    05/08/16 : TDA : Les sous-sections sont optionnelles
    14/11/16 : NMA : Correction du test des sous-sections
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_childFunctionalStatusAssessment">
    <title>IHE PCC v3.0 Child Functional Status Assessment</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.3"]'> 

        <!-- Verifier que le templateId est utilisé pour une section -->        
        <assert test='../cda:section'> 
            [childFunctionalStatusAssessment] 'Child Functional Status Assessment' ne peut être utilisé que comme section.
        </assert>

        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "47420-5"]'> 
            [childFunctionalStatusAssessment] Le code de la section 'Child Functional Status Assessment' doit être '47420-5'
        </assert> 
        
        <!-- Vérifier que LOINC est utilisé pour coder la section -->
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [childFunctionalStatusAssessment] L'élément 'codeSystem' de la section 'Child Functional Status Assessment' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 

        <assert test='not(cda:component) or cda:component/cda:section/cda:templateId[@root ="1.3.6.1.4.1.19376.1.7.3.1.1.13.5"] or cda:component/cda:section/cda:templateId[@root ="1.3.6.1.4.1.19376.1.7.3.1.1.13.4"]'>
            [childFunctionalStatusAssessment1] La section 'Child Functional Status Assessment' ne contient pas de sous-section'Eating and sleeping Assessment' ou de sous-section 'Psychomotor Development'.        
        </assert>
        

    </rule>
</pattern>