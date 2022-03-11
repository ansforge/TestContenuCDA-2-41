<?xml version="1.0" encoding="UTF-8"?>

<!-- S_traitementsSortie-non-code_ANS.sch
    
     Vérification de la conformité de la section FR-Traitements-a-la-sortie-non-codé (1.2.250.1.213.1.1.2.4) créée par l'ANS

    Historique :
    13/01/2020 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_traitementsSortie-non-code_ANS">
    
    <title>Vérification de la conformité de la section FR-Traitements-a-la-sortie-non-codé (1.2.250.1.213.1.1.2.4) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.4"]'> 
        
        <assert test='../cda:section'> 
            [S_traitementsSortie-non-code_ANS] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que pour une section. 
        </assert> 
        
        <assert test='cda:code[@code = "10183-2"]'> 
            [S_traitementsSortie-non-code_ANS] Erreur de conformité CI-SIS : Le code de cette section doit être '10183-2' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_traitementsSortie-non-code_ANS] Erreur de conformité CI-SIS : Le code de la section doit être un code LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        
    </rule>
    
</pattern>