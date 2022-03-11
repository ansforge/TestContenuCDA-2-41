<?xml version="1.0" encoding="UTF-8"?>

<!-- S_VitalSigns.sch
    
    Teste la conformité de la section "Vital Signs" (1.3.6.1.4.1.19376.1.5.3.1.3.25) aux spécifications d'IHE PCC
    
    Historique :
    13/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_vitalSigns">
    
    <title>IHE PCC v3.0 Vital Signs Section - errors validation phase</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.25"]'>
        
        <!-- Verifier que le templateId est utilisépour une section -->
        <assert test='../cda:section'> 
            [S_VitalSigns] Erreur de Conformité PCC : Ce template ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:templateId)&gt;1">
            [S_VitalSigns] Erreur de Conformité PCC : Deux templateIds au moins doivent être présents pour cette section
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "8716-3"]'> 
            [S_VitalSigns] Erreur de Conformité PCC : Le code de la section Vital signs doit être 8716-3
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_VitalSigns] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <!-- Verifier que le templateId parent est présent. --> 
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.16"]'> 
            [S_VitalSigns] Erreur de Conformité PCC : L'identifiant du template parent pour la section est absent. 
        </assert>
        
    </rule>
    
</pattern>
