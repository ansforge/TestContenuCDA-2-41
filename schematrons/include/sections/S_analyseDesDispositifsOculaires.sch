<!-- S_analyseDesDispositifsOculaires
    Vérification de la conformité de la section FR-Analyse-des-dispositifs-oculaires aux spécification IHE EYE CARE GEE (Lensometry Measurements)
   
    27/05/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_analyseDesDispositifsOculaires">
    
    <title>Vérification de la conformité de la section FR-Analyse-des-dispositifs-oculaires aux spécification IHE EYE CARE GEE (Lensometry Measurements)</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.12.1.2.10"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test='../cda:section'> 
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : Ce template ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "70939-4"]'> 
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : Le code de la section FR-Analyse-des-dispositifs-oculaires doit être "70939-4".
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : L'élément 'codeSystem' de la section FR-Analyse-des-dispositifs-oculaires 
            doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='cda:id'>
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : La section FR-Analyse-des-dispositifs-oculaires doit avoir un élément "id".
        </assert>
        
        <!-- Entrée FR-Liste-des-mesures-de-dispositifs-oculaires  -->
        <assert test='count(./cda:entry/cda:organizer/cda:templateId[@root ="1.3.6.1.4.1.19376.1.12.1.3.5"])&gt;=1'>
            [S_analyseDesDispositifsOculaires] Erreur de conformité IHE Eye Care GEE : La section 'FR-Analyse-des-dispositifs-oculaires' doit avoir au minimum une entrée FR-Liste-des-mesures-de-dispositifs-oculaires.
        </assert>
    </rule>
    
</pattern>