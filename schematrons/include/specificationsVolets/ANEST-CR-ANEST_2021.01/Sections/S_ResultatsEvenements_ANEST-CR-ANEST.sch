<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_ResultatsEvenements_ANEST-CR-ANEST.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Resultats-evenements (1.2.250.1.213.1.1.2.163) dans le document ANEST-CR-ANEST 
   Section FR-Resultats-evenements : Problème liés à l'ALR, Problème lié aux médicaments, Défaillance matérielle
   ANEST-CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    26/11/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ResultatsEvenements_ANEST-CR-ANEST">
    <title>CI-SIS ANEST-CR-ANEST Section Résultats d'évènements</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]'>
        <!-- Vérifier le title de la section 'FR-Resultats-evenements' -->
        <assert test='.//cda:title/text()="Évènements observés"'>
            [S_ResultatsEvenements_ANEST-CR-ANEST] Erreur de conformité : Si elle existe, une section FR-Resultats-evenements (1.3.6.1.4.1.19376.1.7.3.1.1.13.7) doit obligatoirement contenir le title 'Évènements observés'
        </assert>
    </rule>
    
    <rule context='cda:section[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]/cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5"]'>
        <!-- Vérifier la cardinalité de l'entryRelationship FR-Commentaire-ER dans l'entrée 'FR-Probleme' -->
        <assert test='count(./cda:entryRelationship[cda:act/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.2"]) &lt;= 1'>
            [S_ResultatsEvenements_ANEST-CR-ANEST] Erreur de conformité : Si elle existe, une entrée FR-Probleme doit contenir [0..1] entryRelationship FR-Commentaire-ER '1.3.6.1.4.1.19376.1.5.3.1.4.2'.
        </assert>
        
        <!-- Vérifier la cardinalité de l'entryRelationship FR-Severite dans l'entrée 'FR-Probleme' -->
        <assert test='count(./cda:entryRelationship[cda:act/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.1"]) &lt;= 1'>
            [S_ResultatsEvenements_ANEST-CR-ANEST] Erreur de conformité : Si elle existe, une entrée FR-Probleme doit contenir [0..1] entryRelationship FR-Severite '1.3.6.1.4.1.19376.1.5.3.1.4.1'.
        </assert>
    </rule>
    
    
    <rule context='cda:section[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]/cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
        <!-- Vérifier la cardinalité de l'entryRelationship FR-Commentaire-ER dans l'entrée 'FR-Simple observation' -->
        <assert test='count(./cda:entryRelationship[cda:act/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.2"]) &lt;= 1'>
            [S_ResultatsEvenements_ANEST-CR-ANEST] Erreur de conformité : Si elle existe, une entrée FR-Simple observation doit contenir [0..1] entryRelationship FR-Commentaire-ER '1.3.6.1.4.1.19376.1.5.3.1.4.2'.
        </assert>
    </rule>
    
</pattern>

