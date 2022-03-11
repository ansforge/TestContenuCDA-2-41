<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_medicationAdministered.sch ]O@%#o>>=-

Teste la conformité de la section "medication Administered" (1.3.6.1.4.1.19376.1.5.3.1.3.21)
aux spécifications d'IHE PCC v3.0

Historique :
    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_medicationAdministered"> 
    
    <title>IHE PCC v3.0 medication Administered Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.21"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_medicationAdministered] Erreur de Conformité PCC : Le templateId de 'medication Administered' ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "18610-6"]'> 
            [S_medicationAdministered] Erreur de Conformité PCC : Le code de la section 'medication Administered' doit être '18610-6' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_medicationAdministered] Erreur de Conformité PCC : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.7"]'> 
            <!-- Vérifier que les entrées sont conformes -->
            [S_medicationAdministered] Erreur de Conformité PCC : La section 'medication Administered' doit contenir des entrées de type Medications Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7).
        </assert> 
        
    </rule>
    
</pattern>