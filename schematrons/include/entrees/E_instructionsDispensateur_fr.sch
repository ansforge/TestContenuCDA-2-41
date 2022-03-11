<?xml version="1.0" encoding="UTF-8"?>

<!-- Schématron E_instructionsDispensateur_fr
     ......................................................................................................................................................    
     Vérification de la conformité de l'entrée FR-Instructions-au-dispensateur (1.3.6.1.4.1.19376.1.5.3.1.4.3.1) aux spécifications du CI-SIS 
     ......................................................................................................................................................
     Historique :
     12/08/2020 : ANS : Création
     02/09/2020 : ANS : Suppression du contrôle templateId '1.2.250.1.213.1.1.3.34' qui n'est pas obligatoire    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_instructionsDispensateur_fr">
    <title>CI-SIS Entrée "FR-Instructions-au-dispensateur"</title> 
  
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']">
     
        <!-- Test des templateId pour l'entrée "FR-Instructions-au-dispensateur" 
        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.34']">
            [E_instructionsDispensateur_fr.sch] Erreur de conformité CI-SIS : L'entryRelationship "FR-Instructions-au-dispensateur" doit avoir trois occurrences de 'templateId' :
            - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.3.1" (Conformité de l'entrée au parent IHE PCC)
            - Un deuxième 'templateId' dont l'attribut @root="2.16.840.1.113883.10.20.1.43" (Conformité de l'entrée au parent CDA)
            - Un troisième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.34" (Conformité de l'entrée au format CI-SIS)
        </assert> -->
    </rule>
        
</pattern>