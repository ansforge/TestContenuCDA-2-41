<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_ResultatsEvenements_DLU-FLUDT.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Resultats-evenements (1.2.250.1.213.1.1.2.163) dans le document DLU-FLUDR 
   Section FR-Resultats-evenements 
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    27/05/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ResultatsEvenements_DLU-FLUDT">
    <title>CI-SIS DLU-FLUDT Section Résultats d'évènements</title>
    
    <rule context='cda:section[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]/cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
        <!-- Vérifier le code de l'entrée 'FR-Simple observation' -->
        <assert test='cda:code/@code="57277-6"'>
            [S_ResultatsEvenements_DLU-FLUDT] Erreur de conformité : l'entrée FR-Simple observation doit avoir le code '57277-6' pour le motif du transfert vers le service des urgences.
        </assert>
    </rule>
    
</pattern>

