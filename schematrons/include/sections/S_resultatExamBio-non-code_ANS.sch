<?xml version="1.0" encoding="UTF-8"?>


<!-- S_resultatExamBio-non-code_ANS.sch
    
     Vérification de la conformité de la section FR-Resultats-examens-biologiques-non-code (1.2.250.1.213.1.1.2.10) créée par l'ANS
    
    Historique :
    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_resultatExamBio-non-code_ANS">
    
    <title>Vérification de la conformité de la section FR-Resultats-examens-biologiques-non-code (1.2.250.1.213.1.1.2.10) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.10"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_resultatExamBio-non-code_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_resultatExamBio-non-code_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_resultatExamBio-non-code_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément text
        </assert>
        
    </rule>

</pattern>
