<?xml version="1.0" encoding="UTF-8"?>

<!-- E_periodeRenouvellement_fr
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Periode-de-renouvellement aux spécifications du CI-SIS.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_periodeRenouvellement_fr">
        <title>CI-SIS Entrée "FR-Periode-de-renouvellement"</title>         
      
        <!-- Test des templateId pour l'entrée "FR-Periode-de-renouvellement" -->
        <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.15']">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.88']">
                [1] [E_periodeRenouvellement_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Periode-de-renouvellement" doit avoir deux occurrences de 'templateId' :
                - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.15"
                - Un deuxième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.88"
            </assert>
        </rule>
            
    </pattern>
