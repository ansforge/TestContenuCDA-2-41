<?xml version="1.0" encoding="UTF-8"?>

 

<!--                   S_ProcedureCarePlan.sch  
    
    Teste la conformité de la section "Procedure Care Plan" (1.3.6.1.4.1.19376.1.5.3.1.1.9.40)
    aux spécifications d'IHE PCC v3.0
     
    
    Historique :
    04/08/2016 : CRI : Création
    03/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_procedureCarePlan">
    
    <title>IHE PCC v3.0 Procedure Care Plan Section</title>
    
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.1.9.40&quot;]">
        
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [S_ProcedureCarePlan] Erreur de conformité PCC : 'Coded Care Plan' ne peut être utilisé que comme section.
        </assert>
        
        <assert test='count(cda:templateId)&gt;2'> 
            [S_ProcedureCarePlan] Erreur de conformité PCC: Deux templateIds au moins doivent être présents pour cette section
        </assert>
        
        <!-- Vérifier la présence des templateId parents. -->
        <assert test="cda:templateId[@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.31&quot;]"> 
            [S_ProcedureCarePlan] Erreur de conformité PCC : Le templateId parent de la section 'Procedure Care Plan' (1.3.6.1.4.1.19376.1.5.3.1.1.9.40) doit être présent
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = &quot;18776-5&quot;]"> 
            [S_ProcedureCarePlan] Erreur de conformité PCC : Le code de la section 'Procedure Care Plan' doit être '18776-5'
        </assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_ProcedureCarePlan] Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'ProcedureCarePlan' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
        
    </rule>
    
</pattern>