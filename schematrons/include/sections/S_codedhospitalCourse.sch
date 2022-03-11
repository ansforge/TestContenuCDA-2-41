<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE coded hospital Course Section: 1.3.6.1.4.1.19376.1.7.3.1.3.23.1 -->

<!--                  -=<<o#%@O[ S_codedHospitalCourse.sch ]O@%#o>>=-
    
    Teste la conformité de la section "coded hospital Course" (1.3.6.1.4.1.19376.1.7.3.1.3.23.1)
    aux spécifications d'IHE
    Aucune des entrées codées ne sont obligatoires pour cette section qui peut n'être
    que narrative.

    Historique :
    10/01/2020 : NMA : Création
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedHospitalCourse">
    <title>IHE Coded hospital Course Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.3.23.1"]'>
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_codedHospitalCourse.sch] Erreur de conformité IHE : 'coded hospital Course' ne peut être utilisé que comme section. 
        </assert> 
        
        <assert test="$count_templateId&gt;1">
            [S_codedHospitalCourse.sch] Erreur de conformité IHE : L'élément hospital Course doit avoir au moins deux templateIds
        </assert>
        
        <!-- Vérifier que le templateId parent est bien présent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.3.5"]'> 
            [S_codedHospitalCourse.sch] Erreur de conformité PCC : L'OID du template parent de la section 'coded Hospital Course' (1.3.6.1.4.1.19376.1.5.3.1.3.5) est absent. 
        </assert> 
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "8648-8"]'> 
            [S_codedHospitalCourse.sch] Erreur de conformité IHE : Le code de la section 'hospital Course' doit être '8648-8' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedHospitalCourse.sch] Erreur de conformité IHE :  L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC)  
            system (). 
        </assert> 
        
      
    </rule>
    
</pattern>