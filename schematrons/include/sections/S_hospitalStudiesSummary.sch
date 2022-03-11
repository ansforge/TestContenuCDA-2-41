<?xml version="1.0" encoding="UTF-8"?>

<!-- S_hospitalStudiesSummary
    
    Teste la conformité de la section "hospital Studies Summary Section" (1.3.6.1.4.1.19376.1.5.3.1.3.29)
    aux spécifications d'IHE PCC
    
    Historique :
    13/01/2020 : Création
    30/01/2020 : Suppression du test sur le nombre de templateId
    01/12/2020 : Renommé
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_hospitalStudiesSummary">
    
    <title>IHE PCC Hospital Studies Summary Section</title>
    
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.29&quot;]">
                
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [S_hospitalStudiesSummary.sch] : Erreur de conformité PCC : 'hospital Studies Summary' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = &quot;11493-4&quot;]"> 
            [S_hospitalStudiesSummary.sch] : Erreur de conformité PCC : Le code de la section 'hospital Studies Summary Section' doit être '11493-4'
        </assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_hospitalStudiesSummary.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Hospital Studies Summary Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
        
    </rule>
    
</pattern>
