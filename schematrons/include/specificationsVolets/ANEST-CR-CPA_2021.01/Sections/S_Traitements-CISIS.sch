<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_Traitements-CISIS.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Traitements(1.3.6.1.4.1.19376.1.5.3.1.3.19) dans le document ANEST-CR-CPA 
   Section FR-Traitements : Antibiothérapie, Autres médicaments, Gaz administrés
   ANEST-CR-CPA : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    24/11/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_Traitements-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Traitements administrés </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.19"]'>
        
        <!-- Vérifier le templateId 1.3.6.1.4.1.19376.1.5.3.1.3.19 de la section 'FR-Traitements' -->
        <assert test='not(../cda:section) or ( ../cda:section and count(./cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.19")=1)'>
            [S_Traitements-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) doit obligatoirement contenir un seul templateId '1.3.6.1.4.1.19376.1.5.3.1.3.19'
        </assert>
        
        <!-- Vérifier le title de la section 'FR-Traitements' -->
        <assert test='.//cda:title/text()="Traitements"'>
            [S_Traitements-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) doit obligatoirement contenir le title 'Traitements'
        </assert>
        
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]'>
        <!-- Vérifier que les entrées FR-Traitement (1.3.6.1.4.1.19376.1.5.3.1.4.7) contient les codes @code='DRUG'  -->
        <assert test='.//cda:code[@code="DRUG"]'>
            [S_Traitements-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) contient[0..*] entrées de type FR-Traitement (1.3.6.1.4.1.19376.1.5.3.1.4.7)  avec un élément code dont l'attribut @code='DRUG'.
        </assert>
    </rule>
</pattern>

