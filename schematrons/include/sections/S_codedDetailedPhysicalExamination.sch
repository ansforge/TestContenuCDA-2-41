<?xml version="1.0" encoding="UTF-8"?>



<!--                  -=<<o#%@O[ S_codedDeatailedPhysicalExamination.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Coded Detailed Physical Examination" (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1)
    aux spécifications d'IHE PCC v3.0
    Aucune des sous-sections décrites dans PCC ne sont obligatoires pour cette section.
    
    
    
    Historique :
    25/07/11 : CRI : Création
    14/11/16 : NMA : Suppression du test de conformité CSE et changement du message d'erreur de ' Erreur de Conformité au volet CSE' à ' Erreur de Conformité PCC'
    03/07/2017 : LBE : Ajout du compte des templateId + conventions de nommage
    27/07/17 : NMA : Correction du compte des templateId
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedDetailedPhysicalExamination">
    <title>IHE PCC v3.0 Physical Exam Section - errors validation phase</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1"]'> 
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;2">
            [S_codedDetailedPhysicalExamination.sch] Erreur de conformité PCC : Coded Detailed Physical Examination doit contenir au minimum les trois templateId suivants: 1.3.6.1.4.1.19376.1.5.3.1.3.24, 1.3.6.1.4.1.19376.1.5.3.1.1.9.15 et 1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1
        </assert>
        
        <!-- Verifier que le templateId est utilisé à bon escient -->        
        <assert test='../cda:section'> 
            Erreur de Conformité PCC: 'Coded physical Exam' ne peut être utilisé que comme section.
        </assert> 
        <!-- Vérifier que le templateId parent est bien présent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15"]'> 
            Erreur de Conformité PCC: L'OID du template parent de la section 'Coded physical Exam' est absent. 
        </assert> 
      
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "29545-1"]'> 
            Erreur de Conformité PCC: Le code de la section 'Coded physical Exam' doit être '29545-1'
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            Erreur de Conformité PCC: L'élément 'codeSystem' de la section 'Coded physical exam' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 
        
       
        
    </rule>
</pattern>