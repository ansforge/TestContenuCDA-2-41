<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_codedSocialHistory.sch ]O@%#o>>=-

Teste la conformité de la section "Coded Social History" (1.3.6.1.4.1.19376.1.5.3.1.3.16.1)
aux spécifications d'IHE PCC v3.0
Vérification que les entrées sont du type Social History Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13.4)

Historique :
    24/06/11 : CRI : Création
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedSocialHistory">
   
    <title>IHE PCC v3.0 Coded Social History Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.16.1"]'> 
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_codedSocialHistory] Erreur de Conformité PCC : Le templateId de 'Coded Social History' ne peut être utilisé que pour une section.
        </assert> 
        
        <!-- Vérifier que le templateId parent est bien présent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.3.16"]'> 
            [S_codedSocialHistory] Erreur de Conformité PCC : L'OID du template parent de la section 'Coded Social History' est absent. 
        </assert>
        
        <assert test="count(cda:templateId)&gt;2">
            [S_codedSocialHistory] Erreur de Conformité PCC : Au moins 3 templateIds doivent être présents pour cette section
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "29762-2"]'> 
            [S_codedSocialHistory] Erreur de Conformité PCC : Le code de la section 'Coded Social History' doit être 29762-2
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedSocialHistory] Erreur de Conformité PCC : L'attribut 'codeSystem' de la section 'Coded Social History' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]'> 
            <!-- vérifier que les entrées sont bien du type Social History Observation -->
            [S_codedSocialHistory] Erreur de Conformité PCC : La section "Coded Social History"  doit contenir des éléments d'entrée "Social History Observation".
        </assert> 
    </rule>
</pattern>

