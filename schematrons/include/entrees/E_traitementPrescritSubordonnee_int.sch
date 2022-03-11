<?xml version="1.0" encoding="UTF-8"?>

<!-- E_traitementPrescritSubordonne_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Traitement-prescrit-subordonnee (IHE PHARM PRE - Prescription Item) à IHE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_traitementPrescritSubordonne_int">
        <title>IHE Pharm PRE subordinate "Prescription Item"</title>
        
        <rule context="//cda:entry/cda:substanceAdministration/cda:entryRelationship[@typeCode='COMP']/cda:sequenceNumber">
            
            <let name="count_id" value="count(//cda:id)"/>
            <!-- Formule count des subordinate ER -->
            <let name="count_ER_subordonnees" value="count(//cda:entry/cda:substanceAdministration/cda:entryRelationship[@typeCode='COMP'][cda:sequenceNumber])"/>
            <!-- Formule count des doseQuantity-->
            <let name="count_doseQuantity" value="count(//cda:doseQuantity)"/>  
            <!-- Formule count des doseQuantity/low-->
            <let name="count_doseQuantityLow" value="count(//cda:doseQuantity/cda:low)"/>  
            <!-- Formule count des doseQuantity/high-->
            <let name="count_doseQuantityHigh" value="count(//cda:doseQuantity/cda:high)"/>  
            <!-- Formule count des consumable -->
            <let name="count_consumable" value="count(//cda:consumable/cda:manufacturedProduct[cda:manufacturedMaterial[@nullFlavor='NA']])"/> 
    
            <!-- Test du nombre d'id --> 
            <assert test="$count_id&gt;=$count_ER_subordonnees">
                [1] [E_traitementPrescritSubordonne_int.sch] Erreur de conformité IHE Pharm PRE : 
                Il faut obligatoirement au moins un élément 'id' pour l'entryRelationship subordinate "Prescription Item Entry Content Module" (cardinalité [1..*]).
            </assert>
            
        </rule>
        
    </pattern>
