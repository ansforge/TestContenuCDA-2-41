<?xml version="1.0" encoding="UTF-8"?>

<!-- S_Results.sch
    
    Teste la conformité de la section " Results" (1.3.6.1.4.1.19376.1.5.3.1.3.27) aux spécifications d'IHE PCC 
    
    Historique :
    27/09/19 : NMA : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_results">

    <title>IHE PCC Results Section</title>
    
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.27&quot;]">
        
        <!-- Verifier que le templateId est utilisé correctement --> 
        <assert test="../cda:section"> 
            [S_Results] Erreur de Conformité PCC :  'Results' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = '30954-2']"> 
            [S_Results] Erreur de Conformité PCC : Le code de la section 'Results' doit être '30954-2'
        </assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_Results] Erreur de Conformité PCC : L'élément 'codeSystem' de la section 
            'Results' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <assert test='not(cda:entry) or cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.3.28"]'>
            [S_Results] Erreur de Conformité PCC : La section Results est non codée et ne doit contenir aucune entrée
        </assert>

    </rule>
    
</pattern>
