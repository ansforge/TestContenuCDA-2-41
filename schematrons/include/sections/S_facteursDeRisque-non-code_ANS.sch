<?xml version="1.0" encoding="UTF-8"?>


<!--  S_facteursDeRisque-non-code_ANS.sch
    
     Vérification de la conformité de la section FR-Facteurs-de-risques-non-code (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1) créée par l'ANS
    
    Historique :
    17/08/2017 : Création
    30/01/2020 : Suppression du test sur le nombre de templateId
    26/05/2021 : Modification du code de la section
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_facteursDeRisque-non-code_ANS">
    <title>Vérification de la conformité de la section FR-Facteurs-de-risques-non-code (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_facteursDeRisque-non-code_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_facteursDeRisque-non-code_ANS.sch] Erreur de conformité CI-SIS : Cette section doit contenir un élément 'id' unique.
        </assert>

        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "10161-8"]'>
            [S_facteursDeRisque-non-code_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '10161-8'
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_facteursDeRisque-non-code_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>

    </rule>

</pattern>
