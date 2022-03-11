<?xml version="1.0" encoding="UTF-8"?>
<!--                  ### S_codedAdvanceDirectives.sch ###
    
    Teste la conformité de la section "Coded Advance Directives" (1.3.6.1.4.1.19376.1.5.3.1.3.35)
    aux spécifications d'IHE PCC
    
    Historique :
    01/07/15 : TDA : Création
    03/07/2017 : LBE : Ajout du compte de templateId + conventions de nommage
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->
<pattern  xmlns="http://purl.oclc.org/dsdl/schematron" id='S_codedAdvanceDirectives'> 
    <title>IHE PCC v3.0 Coded Advance Directives Section</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.35"]'> 
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;1">
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : coded Advance Directives section doit contenir au minimum deux templateId
        </assert>
        
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test='../cda:section'> 
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : le templateId de 'Coded Advance Directives' 
            ne peut être utilisé que pour une section.
        </assert> 
        
        <!-- Verify that the parent templateId is also present. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.3.34"]'>
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : le templateId parent n'est pas présent.de 'Coded Advance Directives' 
        </assert> 
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "42348-3"]'> 
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : Le code de la section 'Coded Advance Directives' doit être 42348-3 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : L'attribut 'codeSystem' de la section 'Coded Advance Directives' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.7"]'> 
            <!-- Alert on any missing required if known elements -->
            [S_codedAdvanceDirectives.sch] Erreur de conformité PCC : la section 'Coded Advance Directives' doit avoir une 'Advance Directive Observation Entry'
            http://wiki.ihe.net/index.php?title=1.3.6.1.4.1.19376.1.5.3.1.3.35
        </assert> 
    </rule> 
</pattern>
