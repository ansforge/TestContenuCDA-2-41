<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0 health maintenance care plan Section: 1.3.6.1.4.1.19376.1.5.3.1.1.9.50 -->

<!--                  -=<<o#%@O[ S_healthMaintenanceCarePlan.sch ]O@%#o>>=-
    
    Teste la conformité de la section "health Maintenance Care Plan" (1.3.6.1.4.1.19376.1.5.3.1.1.9.50)
    aux spécifications d'IHE PCC v3.0
    Aucune des entrées codées ne sont obligatoires pour cette section qui peut n'être
    que narrative.

    
    Historique :
    10/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_healthMaintenanceCarePlan">
    
    <title>IHE PCC v3.0 healt Maintenance Care Plan Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.50"]'>
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : 'health Maintenance Care Plan' ne peut être utilisé que comme section. 
        </assert> 
        
        <!-- Vérifier que le templateId parent est bien présent. --> 
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.10"]'> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : L'OID du template parent de la section 'health Maintenance Care Plan' (2.16.840.1.113883.10.20.1.10) est absent. 
        </assert> 
        
        <!-- Vérifier que le templateId parent est bien présent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.3.31"]'> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : L'OID du template parent de la section 'health Maintenance Care Plan' (1.3.6.1.4.1.19376.1.5.3.1.3.31) est absent. 
        </assert> 
        
        <assert test="$count_templateId&gt;2">
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : La section health Maintenance Care Plan doit avoir au moins trois templateId
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "18776-5"]'> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC : Le code de la section 'health Maintenance Care Plan' doit être '18776-5' 
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_healthMaintenanceCarePlan.sch] Erreur de conformité PCC :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
        </assert>
      
    </rule>
    
</pattern>