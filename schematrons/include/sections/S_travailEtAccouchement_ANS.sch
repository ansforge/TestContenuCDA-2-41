<?xml version="1.0" encoding="UTF-8"?>

<!-- S_travailEtAccouchement_ANS.sch
    
     Vérification de la conformité de la section FR-Travail-et-accouchement (1.2.250.1.213.1.1.2.123) créée par l'ANS
    
    Historique :
   31/05/2021 : SBM : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_travailEtAccouchement_ANS">
    
    <title>Vérification de la conformité de la section FR-Travail-et-accouchement (1.2.250.1.213.1.1.2.123)</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.123"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_travailEtAccouchement_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "57074-7"]'>
            [S_travailEtAccouchement_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '57074-7'.
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_travailEtAccouchement_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
    </rule>
    
</pattern>
