<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[Hospital Discharge Medication Section ]O@%#o>>=-
    
    Teste la conformité de la section "Hospital Discharge Medication Section" (1.3.6.1.4.1.19376.1.5.3.1.3.22)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_HospitalDischargeMedication">
    
    
    <title>IHE PCC v3.0 Hospital Discharge Medication Section</title>
    
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.22&quot;]">
        
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [S_HospitalDischargeMedication.sch] : Erreur de conformité PCC : 'Hospital Discharge Medication Section' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = &quot;10183-2&quot;]"> 
            [S_HospitalDischargeMedication.sch] : Erreur de conformité PCC : Le code de la section 'Hospital Discharge Medication Section' doit être '10183-2'
        </assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_HospitalDischargeMedication.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Hospital Discharge Medication Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.7"]'> 
            <!-- Vérifier que les entrées sont conformes -->
            [S_HospitalDischargeMedication.sch] : Erreur de Conformité PCC : La section Medications doit contenir des entrées de type Medications Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7).
        </assert>
        
    </rule>
    
</pattern>
