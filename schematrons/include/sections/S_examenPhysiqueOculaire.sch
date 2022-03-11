<!--  S_examenPhysiqueOculaire
    Vérification de la conformité de la section FR-Examen-physique-oculaire aux spécification IHE EYE CARE GEE (Ocular Physical Exam)
    
    27/05/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_examenPhysiqueOculaire">
    
    <title>Vérification de la conformité de la section FR-Examen-physique-oculaire aux spécification IHE EYE CARE GEE (Ocular Physical Exam)</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.12.1.2.5"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test='../cda:section'> 
            [S_examenPhysiqueOculaire] Erreur de conformité IHE Eye Care GEE : Ce template ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "70948-5"]'> 
            [S_examenPhysiqueOculaire] Erreur de conformité IHE Eye Care GEE : Le code de la section FR-Examen-physique-oculaire doit être "70948-5".
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_examenPhysiqueOculaire] Erreur de conformité IHE Eye Care GEE : L'élément 'codeSystem' de la section FR-Examen-physique-oculaire 
            doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='cda:id'>
            [S_examenPhysiqueOculaire] Erreur de conformité IHE Eye Care GEE : La section FR-Examen-physique-oculaire doit avoir un élément "id".
        </assert>
        
    </rule>
    
</pattern>