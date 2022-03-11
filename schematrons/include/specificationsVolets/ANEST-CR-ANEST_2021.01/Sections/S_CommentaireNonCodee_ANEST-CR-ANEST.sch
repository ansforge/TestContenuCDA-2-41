<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_CommentaireNonCodee_ANEST-CR-ANEST.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Commentaire-ER (1.2.250.1.213.1.1.3.32) dans le document ANEST-CR-ANEST qui décrit 
   les observations particulières ou faits marquants / Évènements
   
   ANEST-CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    25/11/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_CommentaireNonCodee_ANEST-CR-ANEST">
    <title>CI-SIS ANEST-CR-ANEST Section Commentaire non codé </title>
    
    
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.4.1.2.16"]'>
        
        <!-- Vérifier le title de la section 'FR-Commentaire-ER' -->
        <assert test=".//cda:title/text()='Observations particulières ou faits marquants / Évènements'">
            [S_CommentaireNonCodee_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Commentaire-ER (1.3.6.1.4.1.19376.1.4.1.2.16) doit obligatoirement contenir le title 'Observations particulières ou faits marquants / Évènements'
        </assert>
        
    </rule>
    
</pattern>