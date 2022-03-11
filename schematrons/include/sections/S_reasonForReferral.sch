<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_ReasonForReferral ]O@%#o>>=-
    
    - Teste la conformité de la section "Reason For Referral" (1.3.6.1.4.1.19376.1.5.3.1.3.1)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    11/10/16 : NMA : Création  ReasonForReferra20161011.sch
    03/07/17 : NMA : Ajout de la contrainte sur le nombre de templateIds et renommage du schématron
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_reasonForReferral">
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.1"]'> 
        
        <!-- Verify that the template id is used on the appropriate type of object -->
        <assert test='../cda:section'> 
            [S_ReasonForReferral] Erreur de Conformité PCC: Ce composant ne peut être utilisé qu'en tant que section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "42349-1"]'> 
            [S_ReasonForReferral] Erreur de Conformité PCC: Le code de la section doit être 42349-1 
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_ReasonForReferral] Erreur de Conformité PCC: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
    </rule>
    
</pattern>

