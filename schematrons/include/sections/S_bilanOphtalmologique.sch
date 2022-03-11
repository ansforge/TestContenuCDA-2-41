<!-- S_bilanOphtalmologique
     Vérification de la conformité de la section FR-Bilan-ophtalmologique aux spécification IHE EYE CARE GEE (Routine Eye Exam)

    27/05/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_bilanOphtalmologique">
    
    <title>Vérification de la conformité de la section FR-Bilan-ophtalmologique aux spécification IHE EYE CARE GEE (Routine Eye Exam)</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.12.1.2.6"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test='../cda:section'> 
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : Ce template ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "10197-2"]'> 
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : Le code de la section FR-Bilan-ophtalmologique doit être "10197-2".
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : L'élément 'codeSystem' de la section FR-Bilan-ophtalmologique
            doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='cda:id'>
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : La section FR-Bilan-ophtalmologique doit avoir un élément "id".
        </assert>
        
        <!-- sous-section FR-Mesure-de-la-refraction -->
        <assert test='count(.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.12.1.2.6"])&lt;=1'>
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : La section 'FR-Bilan-ophtalmologique' peut contenir [0..1] sous-section 'FR-Mesure-de-la-refraction'.
        </assert>
        
        <!-- sous-section FR-Analyse-des-dispositifs-oculaires -->
        <assert test='count(.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.12.1.2.10"])&lt;=1'>
            [S_bilanOphtalmologique] Erreur de conformité IHE Eye Care GEE : La section 'FR-Bilan-ophtalmologique' peut contenir [0..1] sous-section 'FR-Analyse-des-dispositifs-oculaires'.
        </assert>
        
    </rule>
    
</pattern>