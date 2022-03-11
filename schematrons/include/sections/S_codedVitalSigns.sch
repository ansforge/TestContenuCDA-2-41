<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_codedVitalSigns.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Coded Vital Signs" (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2)
    aux spécifications d'IHE PCC v3.0
    Teste la présence d'un élément Vital Sign Organizer comme unique entrée de cette section
    
    Historique :
    27/06/11 : CRI : Création
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->



<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedVitalSigns">
    <title>IHE PCC v3.0 Coded Vital Signs Section - errors validation phase</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2"]'>
        
<!-- Verifier que le templateId est utilisépour une section -->
        <assert test='../cda:section'> 
            [S_codedVitalSigns] Erreur de Conformité PCC : Ce template ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:templateId)&gt;2">
            [S_codedVitalSigns] Erreur de Conformité PCC : Trois templateIds au moins doivent être présents pour cette section
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "8716-3"]'> 
            [S_codedVitalSigns] Erreur de Conformité PCC : Le code de la section Coded Vital signs doit être 8716-3
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedVitalSigns] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <!-- Verifier que le templateId parent est présent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.3.25"]'> 
            [S_codedVitalSigns] Erreur de Conformité PCC : L'identifiant du template parent pour la section est absent. 
        </assert>
        
        <!-- Verifier la présence d'un vital signs organizer comme élément d'entrée -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.1"]'>
            [S_codedVitalSigns] Erreur de Conformité PCC : Une section 'Coded Vital Signs' doit contenir un élément 'Vital Signs Organizer'.
        </assert> 
    </rule>
</pattern>
