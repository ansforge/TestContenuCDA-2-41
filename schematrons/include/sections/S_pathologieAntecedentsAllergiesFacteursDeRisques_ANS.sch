<?xml version="1.0" encoding="UTF-8"?>

<!-- S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS.sch
    
     Vérification de la conformité de la section FR-Pathologies-antecedents-allergies-facteurs-de-risques (1.2.250.1.213.1.1.2.29) créée par l'ANS
        
    Historique :
    17/08/2017 : LBE : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    03/09/2020 : Suppression de la vérification que la section contient un élément text    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS">
    
    <title>Vérification de la conformité de la section FR-Pathologies-antecedents-allergies-facteurs-de-risques (1.2.250.1.213.1.1.2.29) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.29"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <!-- Verifier que la section contient un id de cardinalité [1..1] -->
        <assert test="count(cda:id)=1">
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <!-- 03/09/2020 : Suppression de la vérification que la section contient un élément text  
        <assert test="cda:text">
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément text
        </assert> -->
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "46612-8"]'>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '46612-8'
        </assert>
        
        <!-- Verifier le codeSystem -->
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des sous-sections obligatoires -->
        <assert test="cda:component/cda:section/cda:templateId/@root='1.2.250.1.213.1.1.2.30' and cda:component/cda:section/cda:templateId/@root='1.2.250.1.213.1.1.2.31'">
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ANS.sch] Erreur de conformité CI-SIS : Cette section contient obligatoirement les sous sections 'Pathologie en cours, antécédents et allergies'
            (1.2.250.1.213.1.1.2.30) et 'Facteurs de risque' (1.2.250.1.213.1.1.2.31)           
        </assert>

    </rule>

</pattern>
