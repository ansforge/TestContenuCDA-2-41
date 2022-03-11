<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_dischargeDiagnosis.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "Discharge Diagnosis" (1.3.6.1.4.1.19376.1.5.3.1.3.7)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    30/10/2013 : CRI : Création  dischargeDiagnosisSection20131030.sch
    07/05/2015 : JDS : Correction texte affiché pour le code de la section
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_dischargeDiagnosis">
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.7"]'>
        
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test='../cda:section'> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Ce composant ne peut être utilisé qu'en tant que section. 
        </assert> 

        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "11535-2"]'> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Le code de la section doit être 11535-2
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.5.2"]'> 
            <!-- Verify that all required data elements are present -->
            [S_dischargeDiagnosis] Erreur de Conformité PCC: La section doit contenir des entrées 
            du type Problem Concern Entry   (1.3.6.1.4.1.19376.1.5.3.1.4.5.2).
        </assert>
        
    </rule> 
</pattern>

