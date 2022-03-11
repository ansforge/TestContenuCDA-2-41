<?xml version="1.0" encoding="UTF-8"?>

<!-- S_codedReasonForReferral.sch
    
    Teste la conformité de la section "Coded Reason For Referral" (1.3.6.1.4.1.19376.1.5.3.1.3.2)
    aux spécifications d'IHE PCC    
    
    Auteur : ANS
    
    Historique :
    30/10/2013 : Création  
    06/07/2017 : Ajout du compte du templateId + conventions de nommage
    30/01/2020 : Mise à jour du test sur le nombre de templateId
    16/04/2021 : Mise à jour des messages d'erreur
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedReasonForReferral">
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.2"]'>
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId>1">
            [S_codedReasonForReferral_int.sch] Erreur de conformité : La section FR-Raison-de-la-recommandation doit contenir au moins deux templateId.
        </assert>
        
        <assert test='../cda:section'> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : Ce composant ne peut être utilisé qu'en tant que section. 
        </assert> 
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "42349-1"]'> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : Le code de la section FR-Raison-de-la-recommandation doit être 42349-1. 
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : Le code de la section FR-Raison-de-la-recommandation doit être issu de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.5"]'> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : La section FR-Raison-de-la-recommandation doit contenir au moins une entrée 
            FR-Probleme (1.3.6.1.4.1.19376.1.5.3.1.4.5).            
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'> 
            [S_codedReasonForReferral_int.sch] Erreur de conformité : La section FR-Raison-de-la-recommandation doit contenir au moins une entrée
            FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13).            
        </assert>
        
    </rule> 
</pattern>

