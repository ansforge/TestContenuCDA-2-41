<?xml version="1.0" encoding="UTF-8"?>

<!-- E_referenceItemPlanTraitement_fr
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Reference-item-plan-traitement (IHE-PRE - Reference-to-Medication-Treatment-Plan-Item - 1.3.6.1.4.1.19376.1.9.1.3.10) aux spécifications du CI-SIS.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_referenceItemPlanTraitement_fr">
        <title>CI-SIS Entrée "FR-Reference-item-plan-traitement"</title>
        
        <!-- Test des templateId pour l'entrée "FR-Reference-item-plan-traitement" -->
        <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.10']">
            
            <!-- Test des templateId pour l'entrée "FR-Reference-item-plan-traitement" -->
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.85']">
                [1] [E_referenceItemPlanTraitement_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Reference-item-plan-traitement" doit avoir deux occurrences de 'templateId' :
                - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.10"
                - Un deuxième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.85"
            </assert>
        </rule>
            
    </pattern>
