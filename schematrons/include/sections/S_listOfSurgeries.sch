<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_ListOfSurgeries.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "List of Surgeries" (1.3.6.1.4.1.19376.1.5.3.1.3.11)
    aux spécifications d'IHE PCC v3.0
    - Vérifie que les entrées sont de type Procedure
    
    Historique :
    13/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_listOfSurgeries">
    <title>IHE PCC v3.0 List of Surgeries Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.11"]'> 
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;1">
            [S_ListOfSurgeries.sch] Erreur de conformité PCC : List of Surgeries doit contenir au moins deux templateId
        </assert>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_ListOfSurgeries.sch] Erreur de conformité PCC : List of Surgeries ne peut être utilisé que dans une section. 
        </assert> 
        
        <!-- Vérifier la présence des templateId parents. -->
        <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.12']"> 
            [S_ListOfSurgeries.sch] Erreur de conformité PCC : Le templateId parent de la section 'List of Surgeries' (2.16.840.1.113883.10.20.1.12) doit être présent
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "47519-4"]'> 
            [S_ListOfSurgeries.sch] Erreur de conformité PCC :  Le code de la section List of Surgeries doit être 47519-4 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_ListOfSurgeries.sch] Erreur de conformité PCC :  L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
    </rule>
    
</pattern>

