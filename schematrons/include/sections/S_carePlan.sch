<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0  Section: 1.3.6.1.4.1.19376.1.5.3.1.3.31 -->

<!--                  -=<<o#%@O[ carePlan.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Care Plan" (1.3.6.1.4.1.19376.1.5.3.1.3.31)
    aux spécifications d'IHE PCC v3.0
    Aucune des entrées codées ne sont obligatoires pour cette section qui peut n'être
    que narrative.

    
    Historique :
    24/06/11 : CRI : Création
    03/07/2017 : LBE : vérification compte templateId
    04/10/17 : NMA : MAJ de l'assert concernant le nombre de templateIds
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_carePlan">
    <title>IHE PCC v3.0 Care Plan Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.31"]'> 
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_carePlan.sch] Erreur de conformité PCC : 'Care Plan' ne peut être utilisé que comme section. 
        </assert> 
        
        <!-- Vérifier que le templateId parent est bien présent. --> 
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.10"]'> 
            [S_carePlan.sch] Erreur de conformité PCC : L'OID du template parent de la section 'Care Plan' (2.16.840.1.113883.10.20.1.10) est absent. 
        </assert> 
        
        <assert test="$count_templateId&gt;1">
            [S_carePlan.sch] Erreur de conformité PCC : L'élément care plan doit avoir au moins deux templateId
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "18776-5"]'> 
            [S_carePlan.sch] Erreur de conformité PCC : Le code de la section 'Care Plan' doit être '18776-5' 
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_carePlan.sch] Erreur de conformité PCC :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
        </assert> 
        
      
    </rule>
    
</pattern>