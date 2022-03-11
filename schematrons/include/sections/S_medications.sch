<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_medications.sch ]O@%#o>>=-

Teste la conformité de la section "Medications" (1.3.6.1.4.1.19376.1.5.3.1.3.19)
aux spécifications d'IHE PCC v3.0

Historique :
    24/06/11 : CRI : Création
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_medications">
    
    <title>IHE PCC v3.0 Medications Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.19"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_medications] Erreur de Conformité PCC : Le templateId de 'Medications' ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Vérifier que le template parent est présent. --> 
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.8"]'> 
            [S_medications] Erreur de Conformité PCC : Le templateId parent de Medications est absent. 
        </assert>
        
        <assert test="count(cda:templateId)&gt;1">
            [S_medications] Erreur de Conformité PCC : Au minimum deux templateIds doivent être présents pour cette section
        </assert>
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "10160-0"]'> 
            [S_medications] Erreur de Conformité PCC : Le code de la section 'Medications doit être '10160-0' 
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_medications] Erreur de Conformité PCC : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.7"]'> 
            <!-- Vérifier que les entrées sont conformes -->
            [S_medications] Erreur de Conformité PCC : La section Medications doit contenir des entrées de type Medications Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7).
        </assert>
        
    </rule>
    
</pattern>