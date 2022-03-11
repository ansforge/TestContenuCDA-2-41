<?xml version="1.0" encoding="UTF-8"?>

<!--  S_cancerDiagnosis.sch
    
    Teste la conformité de la section "Cancer Diagnosis" (1.3.6.1.4.1.19376.1.7.3.1.3.14.1) aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/08/2012 : Création
    29/06/2017 : Ajout de la vérification de la présence de l'entrée cancerDiagnosisEntry, compte des templateId, code et conventions de nommage, modification vérification texte
    10/10/2017 : Correction du test sur la présence de l'entrée "cancer diagnosis entry"
    30/01/2020 : Mise à jour du test sur le nombre de templateId
    22/07/2020 : Corection du chemin pour contrôler la présence de l'entrée "Cancer diagnosis"
    13/04/2021 : Correction des contrôles
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_cancerDiagnosis">


    <title>IHE PCC Cancer Diagnosis Section</title>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']">
        
        <assert test="cda:templateId/@root='2.16.840.1.113883.10.20.1.11'">
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir le template parent '2.16.840.1.113883.10.20.1.11'.
        </assert>
        
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6'">
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir le templateId parent '1.3.6.1.4.1.19376.1.5.3.1.3.6'.
        </assert>        
        
        <assert test="cda:templateId/@root='1.2.250.1.213.1.1.2.27'">
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir le templateId '1.2.250.1.213.1.1.2.27'.
        </assert>       
        
        <assert test="../cda:section"> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité : Ce template FR-Diagnostic-du-cancer ne peut être utilisé que comme section.
        </assert>
        
        <assert test="cda:code[@code ='72135-7']"> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité : Le code de la section FR-Diagnostic-du-cancer doit être '72135-7'
        </assert>
        
        <assert test="cda:code[@codeSystem='2.16.840.1.113883.6.1']"> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité : L'élément 'codeSystem' de la section 
            FR-Diagnostic-du-cancer doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
        
        <assert test="cda:text">
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir un élément "text"
        </assert>
        
        <assert test="cda:entry/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']">
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir au moins une entrée FR-Liste-des-problemes (1.3.6.1.4.1.19376.1.5.3.1.4.5.2)
        </assert>
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.7.3.1.4.14.1']">
            [S_cancerDiagnosisSection.sch] Erreur de conformité : La section FR-Diagnostic-du-cancer doit contenir au moins une entrée FR-Diagnostic-du-cancer (1.3.6.1.4.1.19376.1.7.3.1.4.14.1)
        </assert>
    </rule>
</pattern>
