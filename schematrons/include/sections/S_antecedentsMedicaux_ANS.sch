<?xml version="1.0" encoding="UTF-8"?>

<!-- S_antecedentsMedicaux_ANS.sch
    
    Vérification de la conformité de la section FR-Antecedents-medicaux-non-code (1.2.250.1.213.1.1.2.2) créée par l'ANS
    
    Historique :
    13/01/2020 : Création
    01/12/2020 : Renommé
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_antecedentsMedicaux_ANS">
    <title>Vérification de la conformité de la section FR-Antecedents-medicaux-non-code (1.2.250.1.213.1.1.2.2) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.2"]'> 
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_antecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section. 
        </assert> 
        <assert test="count(cda:id)">
            [S_antecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS : Cette section doit contenir un id unique.
        </assert>
        <assert test="cda:text">
            [S_antecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS : Cette section doit contenir un élément 'text'.
        </assert>
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "11348-0"]'> 
            [S_antecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS : Le code de cette section doit être '11348-0' 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_antecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS : L'attribut 'codeSystem' du 'code' de la section doit être '2.16.840.1.113883.6.1' (LOINC). 
        </assert>


    </rule>
    
</pattern>