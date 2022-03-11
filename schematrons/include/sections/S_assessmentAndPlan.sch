<?xml version="1.0" encoding="UTF-8"?>


<!--                  -=<<o#%@O[ assessmentAndPlan.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Assessment and Plan" (templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.13.2.5)
    aux spécifications d'IHE PCC v3.0
    
    Note: Cette section propose uniquement une forme narrative d'entrée 
    
    Historique :
    24/06/11 : CRI : Création
    29/06/2017 : LBE : conventions de nommage
    
-->
<!--  IHE PCC v3.0 Assessment and Plan Section: 1.3.6.1.4.1.19376.1.5.3.1.1.13.2.5 -->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_assessmentAndPlan">
    <title>IHE PCC v3.0 Assessment and Plan Section</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.13.2.5"]'> 
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_assessmentAndPlan.sch] Erreur de Conformité volet PCC : 'Assessment and Plan' ne peut être utilisé que comme section. 
        </assert> 
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "51847-2"]'> 
            [S_assessmentAndPlan.sch] Erreur de Conformité volet PCC : Le code de la section 'Assessment and Plan' doit être 51847-2 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_assessmentAndPlan.sch] Erreur de Conformité volet PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert> 
    </rule>   
</pattern>

