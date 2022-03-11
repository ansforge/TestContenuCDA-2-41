<!--  IHE PCC Coded Functional Status Section: 1.3.6.1.4.1.19376.1.5.3.1.1.12.2.1

S_codedFunctionalStatusAssessment.sch
Vérifie la conformité de la section coded Functional Status Assessment en fontion du profil IHE-PCC Supplément

    03/07/2017 : Création
    30/01/2020 : Suppression du test sur le nombre de templateId
    10/03/2022 : Suppression du test sur la présence obligatoire d'au moins une sous-section
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedFunctionalStatus">
    <title>IHE PCC Coded Functional Status Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.2.1"]'> 
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;2">
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : L'élément coded Functional Status Assessment doit contenir au moins trois templateIds
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test='../cda:section'> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : Ce template ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Verifier la présence du templateId parent. --> 
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.5"]'> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : Le templateiD parent "2.16.840.1.113883.10.20.1.5" est obligatoire. 
        </assert> 
        
        <!-- Verifier la présence du templateId parent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.3.17"]'> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : Le templateiD parent "1.3.6.1.4.1.19376.1.5.3.1.3.17" est obligatoire. 
        </assert> 
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "47420-5"]'> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : Le code de la section 'Progress Note' doit être 47420-5
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 
        
        <!-- Vérifier le title de la section --> 
        <assert test='cda:title'>
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : La section doit avoir un élément "title".
        </assert>        
        
        <!-- Vérifier le text de la section --> 
        <assert test='cda:text'>
            [S_codedFunctionalStatusAssessment.sch] Erreur de conformité PCC : La section doit avoir un élément "text".
        </assert>

    </rule>
    
</pattern>
        
