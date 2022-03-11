<?xml version="1.0" encoding="UTF-8"?>

<!-- E_referenceItemPlanTraitement_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Reference-item-plan-traitement (IHE-PRE - Reference-to-Medication-Treatment-Plan-Item) à IHE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_referenceItemPlanTraitement_int">
        <title>IHE-PRE - Reference-to-Medication-Treatment-Plan-Item</title>    
        
        <rule context="*[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']]">
            
            <!-- Count nb d'ER "Item-plan-traitement" -->
            <let name="count_ER_itemPlanTraitement" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']]/cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']])"/>
            <!-- Count nb de consumable -->
            <let name="count_consumable" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']]/cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial[@nullFlavor='NA'])"/>
            
            <!-- Test présence et format de l'élément 'id' -->
            <assert test="(count(cda:id)=1)">
                [1] [E_referenceItemPlanTraitement_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Reference-item-plan-traitement doit comporter un élément 'id'.
            </assert>
            
            <!-- Test présence et format de l'élément 'code' -->
            <assert test="(count(cda:code[@code='MTPItem'][@codeSystem='1.3.6.1.4.1.19376.1.9.2.2'])=1) and count(cda:code)=1">
                [2] [E_referenceItemPlanTraitement_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Reference-item-plan-traitement doit comporter un élément 'code' et ses attribut :
                - @code="MTPItem" (cardinalité [1..1])
                - @codeSystem="1.3.6.1.4.1.19376.1.9.2.2" (cardinalité [1..1])
            </assert>
            
            <!-- Test présence de l'élément 'consumable' -->
            <assert test="($count_consumable=1)">
                [3] [E_referenceItemPlanTraitement_int.sch] Erreur de conformité IHE Pharm PRE :  
                L'entrée FR-Reference-item-plan-traitement doit comporter un élément 'consumable/manufacturedProduct/manufacturedMaterial' dont la valeur est fixée à la valeur @nullFlavor="NA".
            </assert>
           
            <!--  Test du templateId de la sous-entrée (optionnelle) FR-Item-plan-traitement -->
            <assert test="(($count_ER_itemPlanTraitement=1) or ($count_ER_itemPlanTraitement=0))">
                [4] [E_referenceItemPlanTraitement_int.sch] Erreur de conformité IHE Pharm PRE : 
                Dans l'entrée FR-Reference-item-plan-traitement, l'entrée optionnelle FR-Item-plan-traitement doit contenir un 'templateId' @root="1.3.6.1.4.1.19376.1.9.1.3.7".
           </assert> 
      
        </rule>
            
    </pattern>
