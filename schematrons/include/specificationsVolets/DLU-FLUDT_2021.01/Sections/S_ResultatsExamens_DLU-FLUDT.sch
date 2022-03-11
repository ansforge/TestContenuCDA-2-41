<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_ResultatsExamens_DLU-FLUDT.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28) dans le document DLU-FLUDT
   Section FR-Resultats-examens 
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    27/05/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ResultatsExamens_DLU-FLUDT">
    <title>CI-SIS DLU-FLUDT Section Résultats d'examens</title>
    
    <rule context='cda:section[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.28"]'>
        <!-- Vérifier le code de l'entrée 'FR-Simple observation' -->
        <assert test='./cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13" and not(cda:code/@code="R52.9")]/cda:code/@code="DLU_002" or 
            ./cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13" and not(cda:code/@code="R52.9")]/cda:code/@code="DLU_003" or
            ./cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13" and not(cda:code/@code="R52.9")]/cda:code/@code="DLU_004"'>
            [S_ResultatsExamens_DLU-FLUDT] Erreur de conformité : l'entrée FR-Simple observation doit avoir le code 'DLU_002' ou 'DLU_003' ou  'DLU_004'.
        </assert>
    </rule>
    
</pattern>

