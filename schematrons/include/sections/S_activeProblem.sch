<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ activeProblemSection.sch ]O@%#o>>=-
    
    Teste la conformité de la section " Active Problems Section" (1.3.6.1.4.1.19376.1.5.3.1.3.6)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/07/11 : CRI : Création
    20/06/2017 : LBE : Modification des conventions de nommage, ajout du compte de templateId
    09/01/2020 : NMA : Correction du test sur le code de la section
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_activeProblem">


    <title>IHE PCC v3.0 Active Problems Section</title>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt;1">
            [S_ActiveProblem.sch] Erreur de Conformité PCC: 'Active Problems' doit contenir au moins deux templateId
        </assert>
        
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
         [S_ActiveProblem.sch] Erreur de Conformité PCC: 'Active Problems' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier la présence des templateId parents. -->
        <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.11']"> 
            [S_ActiveProblem.sch] Erreur de Conformité PCC: Le templateId parent de la section 'Active Problems' (2.16.840.1.113883.10.20.1.11) doit être présent
        </assert>
        
        <assert test="cda:code[@code = '11450-4'] or ($count_templateId &gt;=2 and not(cda:code[@code = '11450-4']))"> 
            [S_ActiveProblem.sch] Erreur de Conformité PCC: Le code de la section 'Active Problems' doit être '11450-4'
        </assert>
        
        <assert test="cda:code[@codeSystem = '2.16.840.1.113883.6.1']">
            [S_ActiveProblem.sch] Erreur de Conformité PCC: L'élément 'codeSystem' de la section 
            'Active Problems' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
        
        <!-- Vérifier que la section contient des éléments Problem Concern Entry -->
        <assert test=".//cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.4.5.2']">
            [S_ActiveProblem.sch] Erreur de Conformité PCC: Une section "Active Problems" doit contenir des entrées de type "Problem Concern Entry"
        </assert>
    </rule>
</pattern>
