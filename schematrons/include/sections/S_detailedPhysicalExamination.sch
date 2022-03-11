<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_detailedPhysicalExamination.sch ]O@%#o>>=-

Teste la conformité de la section "Detailed Physical Examination" (1.3.6.1.4.1.19376.1.5.3.1.1.9.15) aux spécifications IHE

Historique :

    13/01/2020 : NMA : Création

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_detailedPhysicalExamination"> 
    <title>Section detailed Physical Examination</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_detailedPhysicalExamination] Erreur de Conformité : Le templateId de 'detailed Physical Examination' ne peut être utilisé que pour une section. 
        </assert> 
        
        <assert test="count(cda:templateId)&gt;1">
            [S_detailedPhysicalExamination] Erreur de Conformité PCC : Deux templateIds au moins doivent être présents pour cette section
        </assert>
        
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.24'">
            [S_detailedPhysicalExamination] Erreur de Conformité PCC : Le template parent 1.3.6.1.4.1.19376.1.5.3.1.3.24 doit être présent pour cette section
        </assert>
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "29545-1"]'> 
            [S_detailedPhysicalExamination] Erreur de Conformité  : Le code de la section detailed Physical Examination doit être '29545-1' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_detailedPhysicalExamination] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
    </rule> 
</pattern>