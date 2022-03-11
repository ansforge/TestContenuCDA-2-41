<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_codedReasonForReferral_FRCP.sch ]O@%#o>>=-
    
    S_codedReasonForReferral_FRCP
    
    Teste la conformité de la section "Coded Reason For Referral" (1.3.6.1.4.1.19376.1.5.3.1.3.2)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    30/10/2013 : CRI : Création  
    06/07/2017 : LBE : Ajout du compte du templateId + conventions de nommage
    25/10/2017 : NMA : Renommage du schématron
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedReasonForReferral_FRCP">
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.2"]'> 
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId>2">
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Coded Reason for referral doit contenir au moins deux templateId
        </assert>
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test='../cda:section'> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Ce composant ne peut être utilisé qu'en tant que section. 
        </assert> 
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "42349-1"]'> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Le code de la section doit être 42349-1 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.5"]'> 
            <!-- Verify that all required data elements are present -->
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : La section doit contenir au moins une entrée 
            du type Conditions Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.5).            
        </assert> 
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'> 
            <!-- Verify that all required data elements are present -->
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : La section doit contenir au moins une entrée
            du type Simple Observations  (1.3.6.1.4.1.19376.1.5.3.1.4.13).            
        </assert> 
    </rule> 
</pattern>

