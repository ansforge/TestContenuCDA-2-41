<?xml version="1.0" encoding="UTF-8"?>

<!-- E_itemPlanTraitement_fr
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Item-plan-traitement aux spécifications du CI-SIS.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_itemPlanTraitement_fr">
        <title>CI-SIS Entrée "FR-Item-plan-traitement"</title>    
            
        <!-- Test des éléments de l'entrée "FR-Item-plan-traitement" -->
        <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.7']">
            
            <!-- Formule count des templateId -->
            <let name="count_templateId" value="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[@typeCode='REFR']/cda:substanceAdministration[@classCode='SBADM'][@moodCode='INT']/cda:templateId)"/>
            
            <!-- Vérification conformité CI-SIS -->
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.96']">
                [1] [E_itemPlanTraitement_fr.sch] Erreur de conformité CI-SIS : 
                Le quatrième templateId doit avoir un @root="" (Conformité aux spécifications CI-SIS)
            </assert>
            
            <assert test="$count_templateId=5">
                [2] [E_itemPlanTraitement_fr.sch] Erreur de conformité CI-SIS : 
                Il doit y avoir 5 occurences de l'élément 'templateId' dans cette entrée(cardinalité [5..5]) :
                - La première pour la déclaration de conformité de l'entrée aux spécifications IHE Pharm suppl. MTP @root="1.3.6.1.4.1.19376.1.9.1.3.2"
                - La deuxième pour la déclaration de conformité de l'entrée aux spécifications CCD @root="2.16.840.1.113883.10.20.1.24"
                - La troisème pour la déclaration de conformité de l'entrée aux spécifications IHE PCC @root="1.3.6.1.4.1.19376.1.5.3.1.4.7"
                - La quatrième pour la déclaration de conformité de l'entrée aux spécifications CI-SIS @root="1.2.250.1.213.1.1.3.96"
                - La cinquième pour la déclaration du mode d'administration du traitement prescrit (à choisir parmi la liste des modes d'administration)
            </assert>            
            
        </rule>  
    </pattern>
