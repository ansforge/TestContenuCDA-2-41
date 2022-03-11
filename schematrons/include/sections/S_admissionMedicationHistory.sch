<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ admissionMedicationHistory20131030.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "Admission Medication History Section" (1.3.6.1.4.1.19376.1.5.3.1.3.20)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    30/10/2013 : CRI : Création  admissionMedicationHistory20131030.sch
    29/06/2017 : LBE : Ajout compte templateId, conventions de nommage
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_admissionMedicationHistory">
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.20"]'>
   
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test='../cda:section'> 
            [S_admissionMedicationHistory.sch] Erreur de conformité PCC :  Ce composant ne peut être utilisé qu'en tant que section. 
        </assert> 
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "42346-7"]'> 
            [S_admissionMedicationHistory.sch] Erreur de conformité PCC :  Le code de la section doit être 42346-7 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_admissionMedicationHistory.sch] Erreur de conformité PCC :  Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.7"]'> 
            <!-- Verify that all required data elements are present -->
            [S_admissionMedicationHistory.sch] Erreur de conformité PCC :  La section doit contenir des entrées 
            du type Medications Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.7).
            
        </assert> 
    </rule> 
</pattern>

