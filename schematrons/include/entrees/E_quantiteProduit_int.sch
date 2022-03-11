<?xml version="1.0" encoding="UTF-8"?>

<!-- E_quantiteProduit_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Quantite-de-produit (IHE PHARM PRE - Amount-of-units-of-consumable - 1.3.6.1.4.1.19376.1.9.1.3.8) à IHE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_quantiteProduit_int">
        <title>IHE Pharm PRE Entrée "Amount of units of the consumable Content Module"</title>      
        
        <rule context="//cda:entryRelationship[@typeCode='COMP']/cda:supply[@classCode='SPLY'][@moodCode='RQO']">
            
            <!-- Test des templateId pour l'entrée "Amount of units of the consumable Content Module" -->
            <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.8']">
                [1] [E_quantiteProduit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Quantite-de-produit doit avoir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.8".
            </assert>
            
            <!-- Test présence et format de l'élément 'independentInd' -->
            <assert test="(count(cda:independentInd[@value='false'])=1)">
                [2] [E_quantiteProduit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Quantite-de-produit doit comporter un élément 'independentInd' et son attribut @value="false".
            </assert>
            
            <!-- Test présence et format de l'élément 'quantity' -->
            <assert test="(count(cda:quantity[@value])=1)">
                [3] [E_quantiteProduit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Quantite-de-produit doit comporter un élément 'quantity' et son attribut @value. 
            </assert>
    
        </rule>
            
    </pattern>
