<!-- S_mesureDeLaRefraction
    Vérification de la conformité de la section FR-Mesure-de-la-refraction aux spécification IHE EYE CARE GEE (Refractive Measurements)

    27/05/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_mesureDeLaRefraction">
    
    <title>Vérification de la conformité de la section FR-Mesure-de-la-refraction aux spécification IHE EYE CARE GEE (Refractive Measurements)</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.12.1.2.9"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test='../cda:section'> 
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : Ce template ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "70938-6"]'> 
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : Le code de la section FR-Mesure-de-la-refraction doit être "70938-6".
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : L'élément 'codeSystem' de la section FR-Mesure-de-la-refraction 
            doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <!-- entrée FR-Liste-des-mesures-de-refraction -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.12.1.3.3"]'>
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : La section 'FR-Mesure-de-la-refraction' doit contenir une entrée 'FR-Liste-des-mesures-de-refraction'.
        </assert>
        
        <!-- entrée FR-Liste-des-mesures-acuite-visuelle -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.12.1.3.2"]'>
            [S_mesureDeLaRefraction] Erreur de conformité IHE Eye Care GEE : La section 'FR-Mesure-de-la-refraction' doit contenir une entrée 'FR-Liste-des-mesures-acuite-visuelle'.
        </assert>
        
        
    </rule>
    
</pattern>