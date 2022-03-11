<?xml version="1.0" encoding="UTF-8"?>
<!--                  ### S_advanceDirectives.sch ###
    
    Teste la conformité de la section "Advance Directives" (1.3.6.1.4.1.19376.1.5.3.1.3.34)
    aux spécifications d'IHE PCC
    
    Historique :
    14/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->
<pattern  xmlns="http://purl.oclc.org/dsdl/schematron" id="S_advanceDirectives"> 
    <title>IHE PCC v3.0 Advance Directives Section</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.34"]'> 
        
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test='../cda:section'> 
            [S_advanceDirectives.sch] Erreur de conformité PCC : le templateId de 'Advance Directives' 
            ne peut être utilisé que pour une section.
        </assert> 
                
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "42348-3"]'> 
            [S_advanceDirectives.sch] Erreur de conformité PCC : Le code de la section 'Advance Directives' doit être 42348-3 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_advanceDirectives.sch] Erreur de conformité PCC : L'attribut 'codeSystem' de la section 'Advance Directives' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 
       
    </rule> 
</pattern>
