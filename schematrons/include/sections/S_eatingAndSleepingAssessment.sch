<?xml version="1.0" encoding="UTF-8"?>


<!--                  -=<<o#%@O[ S_EatingAndSleepingAssessment.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Eating And Sleeping Assessment" (1.3.6.1.4.1.19376.1.7.3.1.1.13.5)
    aux spécifications d'IHE PCC v3.0
    

    
    Historique :
    11/10/16 : NMA : Création
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_eatingAndSleepingAssessment">
    <title>IHE PCC v3.0 EatingAndSleepingAssessment Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.5"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test='../cda:section'> 
            [S_EatingAndSleepingAssessment] Erreur de Conformité PCC: Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "47420-5"]'> 
            [S_EatingAndSleepingAssessment] Erreur de Conformité PCC: Le code de la section Eating And Sleeping Assessment doit être 47420-5
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_EatingAndSleepingAssessment] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'> 
            <!-- Alert on any missing required if known elements -->
            [S_EatingAndSleepingAssessment] Erreur de Conformité PCC: la section 'Eating And Sleeping Assessment' doit avoir une 'Simple Observation Entry'
        </assert> 

    </rule>
    
</pattern>

