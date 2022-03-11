<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_encounterHistories.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Encounter Histories Section" (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.3)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/07/11 : CRI : Création
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_encounterHistories">
    <title>IHE PCC v3.0 Encounter Histories Section</title>
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.1.5.3.3&quot;]">
        
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [S_encounterHistories] Erreur de Conformité PCC: 'Encounter Histories' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier la présence des templateId parents. -->
        <assert test="cda:templateId[@root=&quot;2.16.840.1.113883.10.20.1.3&quot;]"> 
            [S_encounterHistories] Erreur de Conformité PCC: Les templateId des parents doivent être présents.
        </assert>
        
        <assert test="count(cda:templateId)&gt;1">
            [S_encounterHistories] Erreur de Conformité PCC : Au minimum deux templateIds doivent être présents pour cette section
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = &quot;46240-8&quot;]"> 
            [S_encounterHistories] Erreur de Conformité PCC: Le code de la section 'Encounter Histories' doit être '46240-8'
        </assert>
        
        <assert test="cda:code[@codeSystem = '2.16.840.1.113883.6.1']"> 
            [S_encounterHistories] Erreur de Conformité PCC: L'élément 'codeSystem' de la section 
            'Encounter Histories' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérifier que la section contient des éléments Encounters -->
        <assert test=".//cda:templateId[@root = &quot;1.3.6.1.4.1.19376.1.5.3.1.4.14&quot;]">
            [S_encounterHistories] Erreur de Conformité PCC: Une section "Encounter Histories" doit contenir des entrée de type "Encounters".
        </assert>

    </rule>
</pattern>
