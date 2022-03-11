<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_immunizationRecommendations.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "immunization Recommendations Section" (1.3.6.1.4.1.19376.1.5.3.1.1.18.3.1)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_immunizationRecommendations">
    <title>IHE PCC v3.0 Immunizations Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.18.3.1"]'>
        
        <!-- Verifier que le templateId n'est utilisé que pour une section --> 
        <assert test='../cda:section'> 
            [S_immunizationRecommendations] Erreur de Conformité PCC : immunization Recommendations ne peut être utilisé que comme section.
        </assert> 
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "18776-5"]'> 
            [S_immunizationRecommendations] Erreur de Conformité PCC : Le code de la section doit être 18776-5
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_immunizationRecommendations] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        
        <!-- Verifier que les entrées sont de type Immunization -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.12.2"]'> 
            [S_immunizationRecommendations] Erreur de Conformité PCC : Une section immunization Recommendations doit contenir au moins une entrée Immunization recommendation.           
        </assert>
        
    </rule>
    
</pattern>

