<?xml version="1.0" encoding="UTF-8"?>

<!--  S_allergiesIntolerances_ANS
    
    Vérification de la conformité de la section FR-Allergies-et-intolerances-non-code (1.2.250.1.213.1.1.2.8) créée par l'ANS
    
    Historique :
    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_allergiesIntolerances_ANS">
    <title>Vérification de la conformité de la section FR-Allergies-et-intolerances-non-code (1.2.250.1.213.1.1.2.8) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.8"]'> 

        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_allergiesIntolerances_ANS] Erreur de conformité CI-SIS : Cet élément FR-Allergies-et-intolerances-non-code ne peut être utilisé que comme section. 
        </assert> 
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "48765-2"]'> 
            [S_allergiesIntolerances_ANS] Erreur de conformité CI-SIS : Le code de la section FR-Allergies-et-intolerances-non-code doit être 48765-2
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_allergiesIntolerances_ANS] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert> 
    </rule> 
</pattern>

