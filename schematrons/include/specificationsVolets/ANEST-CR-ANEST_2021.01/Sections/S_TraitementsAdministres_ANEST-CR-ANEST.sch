<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_TraitementsAdministres_ANEST-CR-ANEST.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Traitements-administres (1.3.6.1.4.1.19376.1.5.3.1.3.21) dans le document ANEST-CR-ANEST 
   Section FR-Traitements-administres : Antibiothérapie, Autres médicaments, Gaz administrés
   ANEST-CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    24/11/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_TraitementsAdministres_ANEST-CR-ANEST">
    <title>CI-SIS ANEST-CR-ANEST Section Traitements administrés </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.21"]'>
        
        <!-- Vérifier le templateId 1.3.6.1.4.1.19376.1.5.3.1.3.21 de la section 'FR-Traitements-administres' -->
        <assert test='not(../cda:section) or ( ../cda:section and count(./cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.21")=1)'>
            [S_TraitementsAdministres_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Traitements-administres (1.3.6.1.4.1.19376.1.5.3.1.3.21) doit obligatoirement contenir un seul templateId '1.3.6.1.4.1.19376.1.5.3.1.3.21'
        </assert>
        
        <!-- Vérifier le title de la section 'FR-Traitements-administres' -->
        <assert test='.//cda:title/text()="Médicaments et gaz administrés"'>
            [S_TraitementsAdministres_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Une section FR-Traitements-administres (1.3.6.1.4.1.19376.1.5.3.1.3.21) doit obligatoirement contenir le title 'Médicaments et gaz administrés'
        </assert>
        
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]'>
        <!-- Vérifier que les entrées FR-Traitement (1.3.6.1.4.1.19376.1.5.3.1.4.7) contient les codes @code='DRUG'  -->
        <assert test='.//cda:code[@code="DRUG"]'>
            [S_TraitementsAdministres_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Traitements-administres (1.3.6.1.4.1.19376.1.5.3.1.3.21) contient[0..*] entrées de type FR-Traitement (1.3.6.1.4.1.19376.1.5.3.1.4.7)  avec un élément code dont l'attribut @code='DRUG'.
        </assert>
    </rule>
</pattern>

