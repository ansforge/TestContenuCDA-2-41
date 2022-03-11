<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0 hospital Course Section: 1.3.6.1.4.1.19376.1.5.3.1.3.5 -->

<!--                  -=<<o#%@O[ S_hospitalCourse.sch ]O@%#o>>=-
    
    Teste la conformité de la section "hospital Course" (1.3.6.1.4.1.19376.1.5.3.1.3.5)
    aux spécifications d'IHE PCC v3.0
    Aucune des entrées codées ne sont obligatoires pour cette section qui peut n'être
    que narrative.

    Historique :
    10/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_hospitalCourse">
    <title>IHE hospital Course Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.5"]'>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_hospitalCourse.sch] Erreur de conformité PCC : 'hospital Course' ne peut être utilisé que comme section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "8648-8"]'> 
            [S_hospitalCourse.sch] Erreur de conformité PCC : Le code de la section 'hospital Course' doit être '8648-8' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_hospitalCourse.sch] Erreur de conformité PCC :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
        </assert> 
        
    </rule>
    
</pattern>