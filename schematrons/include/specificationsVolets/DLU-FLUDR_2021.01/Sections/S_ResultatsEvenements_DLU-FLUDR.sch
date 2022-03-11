<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_ResultatsEvenements_DLU-FLUDR.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Resultats-evenements (1.2.250.1.213.1.1.2.163) dans le document DLU-FLUDR 
   Section FR-Resultats-evenements 
   DLU-FLUDR : Fiche de liaison d'urgence
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    27/05/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ResultatsEvenements_DLU-FLUDR">
    <title>CI-SIS DLU-FLUDR Section Résultats d'évènements</title>
    
    <rule context='cda:section[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]/cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
        <!-- Vérifier le code de l'entrée 'FR-Simple observation' -->
        <assert test='cda:code/@code="15515-0"'>
            [S_ResultatsEvenements_DLU-FLUDR] Erreur de conformité : l'entrée FR-Simple observation doit avoir le code '15515-0' pour le motif du tranport.
        </assert>
    </rule>
    
</pattern>

