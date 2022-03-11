<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_ResultatsEvenements_LDL-SES.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Resultats-evenements (1.2.250.1.213.1.1.2.163) dans le document LDL-SES 
   Section FR-Resultats-evenements 
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    27/05/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ResultatsEvenements_LDL-SES">
    <title>CI-SIS LDL-SES Section Résultats d'évènements</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]/cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13" 
        and not(cda:templateId/@root="1.2.250.1.213.1.1.3.48.1") and not(cda:templateId/@root="1.2.250.1.213.1.1.3.48.3") and not(cda:templateId/@root="1.2.250.1.213.1.1.3.48.4")
        and not(cda:templateId/@root="1.2.250.1.213.1.1.3.48.5")]'>
        <!-- Vérifier le code de l'entrée 'FR-Simple observation' -->
        <assert test='cda:code[@code="ORG-070" or @code="ORG-074" or @code="MED-142" or @code="MED-309" or @code="MED-145" or @code="MED-147"]'>
            [S_ResultatsEvenements_LDL-SES] Erreur de conformité : l'entrée FR-Simple observation doit avoir le code '57277-6' pour le motif du transfert vers le service des urgences.
        </assert>
    </rule>
</pattern>

