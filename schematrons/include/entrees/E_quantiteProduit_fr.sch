<?xml version="1.0" encoding="UTF-8"?>

<!-- E_quantiteProduit_fr
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Quantite-de-produit aux spécifications du CI-SIS.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_quantiteProduit_fr">
        <title>CI-SIS Entrée "FR-Quantite-de-produit"</title>         
      
        <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.8']">
            
            <!-- Test des templateId pour l'entrée "FR-Quantite-de-produit" -->
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.86']">
                [1] [E_quantiteProduit_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Quantite-de-produit" doit avoir deux occurrences de 'templateId' :
                - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.8"
                - Un deuxième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.86"
            </assert>
    
        </rule>
            
    </pattern>
