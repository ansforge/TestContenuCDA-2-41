<?xml version="1.0" encoding="UTF-8"?>

<!-- E_traitementPrescrit_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Traitement-prescrit (IHE-PRE - Prescription-Item - 1.3.6.1.4.1.19376.1.9.1.3.2) à IHE.
     ......................................................................................................................................................
     Historique :
        - 09/06/2020 : Création
        - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_traitementPrescrit_int">
        <title>IHE PRE Prescription Item Entry (1.3.6.1.4.1.19376.1.9.1.3.2)</title>
        <!--
        <rule context="//cda:entry/cda:substanceAdministration[@classCode='SBADM' and @moodCode='INT']/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']">-->
            <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.2']">
            
            <let name="count_id" value="count(cda:id) "/>  
            <let name="count_code" value="count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'])"/>
            <let name="count_code_1" value="count(cda:code)"/>
            <let name="count_statusCode" value="count(cda:statusCode[@code='completed'])"/>
            <let name="count_statusCode_1" value="count(cda:statusCode)"/>
            <let name="count_text" value="count(cda:text)"/>
            <let name="count_routeCode" value="count(cda:routeCode)"/>
            <let name="count_approachSiteCode_1" value="count(cda:approachSiteCode)"/> 
            <let name="count_approachSiteCode" value="count(cda:approachSiteCode[@codeSystem='2.16.840.1.113883.1.11.19724'])"/>
            <let name="count_doseQuantity" value="count(cda:doseQuantity)"/>  
            <let name="count_rateQuantity" value="count(cda:rateQuantity)"/>  
            <let name="count_rateQuantity_low" value="count(cda:rateQuantity/cda:low)"/>  
            <let name="count_rateQuantity_high" value="count(cda:rateQuantity/cda:high)"/>  
            <let name="count_maxDoseQuantity" value="count(cda:maxDoseQuantity)"/>  
            <let name="count_maxDoseQuantity_numerator" value="count(cda:maxDoseQuantity/cda:numerator)"/>  
            <let name="count_maxDoseQuantity_denominator" value="count(cda:maxDoseQuantity/cda:denominator)"/>  
            <let name="count_author" value="count(cda:author)"/>  
            <let name="count_reference" value="count(cda:reference)"/>
            
            <let name="count_effectiveTime" value="count(cda:effectiveTime)"/>
            
            <let name="count_MA_normales" value="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.1'])"/>
            <let name="count_MA_progressives" value="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.8'])"/>   
            <let name="count_MA_fractionnees" value="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.9'])"/>         
            <let name="count_MA_conditionnees" value="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.10'])"/> 
            <let name="count_MA_combinees" value="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.11'])"/> 
            <let name="count_MA_debutDiff" value="count(cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.21'])"/> 
            
            <let name="count_consumable" value="count(cda:consumable/cda:manufacturedProduct[@classCode='MANU']/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2'])"/> 
            <let name="count_ER_MotifTraitement" value="count(cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1']])"/>
            <let name="count_ER_TraitementPrescritSub" value="count(cda:entryRelationship[cda:sequenceNumber])"/>
            <let name="count_ER_RefItemPlanTrait" value="count(cda:entryRelationship[cda:substanceAdministration/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']])"/>
            <let name="count_ER_InstrucPatient" value="count(cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']])"/>
            <let name="count_ER_InstructDispensateur" value="count(cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']])"/>
            <let name="count_ER_QuantiteProduit" value="count(cda:entryRelationship[cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.8']])"/>
            <let name="count_ER_AutorisationSubstitution" value="count(cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']])"/>
            <let name="count_ER_PeriodeRenouvellement" value="count(cda:entryRelationship[cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.15']])"/>
            <let name="count_E_traitementPrescrit" value="count(cda:entryRelationship/cda:substanceAdministration/cda:templateId[@root='1.2.250.1.213.1.1.3.83.1'])"/>
            
            <!-- Conformité du mode d'administration -->
            <assert test="
                (($count_MA_normales&gt;=1) and ($count_ER_TraitementPrescritSub=0) and ($count_E_traitementPrescrit=0)) or
                (($count_MA_progressives&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_E_traitementPrescrit&gt;0)) or
                (($count_MA_fractionnees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_E_traitementPrescrit&gt;0)) or
                (($count_MA_conditionnees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_E_traitementPrescrit&gt;0)) or
                (($count_MA_combinees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_E_traitementPrescrit&gt;0)) or
                (($count_MA_debutDiff&gt;=1) and ($count_ER_TraitementPrescritSub=0) and ($count_E_traitementPrescrit=0))
                ">
                
                [3] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                Le dernier 'templateId' indique le mode d'administration choisi pour le traitement prescrit. Il doit être choisi parmi la liste suivante :
                                               
                1.3.6.1.4.1.19376.1.5.3.1.4.7.1  (Mode d'administration : doses normales). De ce fait : 
                                                  - il ne peut pas y avoir d'entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                                                                   
                1.3.6.1.4.1.19376.1.5.3.1.4.8    (Mode d'administration : doses progressives). De ce fait :
                                                  - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                 
                1.3.6.1.4.1.19376.1.5.3.1.4.9    (Mode d'administration : doses fractionnées). De ce fait : 
                                                  - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                  
                1.3.6.1.4.1.19376.1.5.3.1.4.10   (Mode d'administration : doses conditionnelles). De ce fait : 
                                                  - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                  
                1.3.6.1.4.1.19376.1.5.3.1.4.11   (Mode d'administration : doses combinées). De ce fait :
                                                  - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                                                  
                1.3.6.1.4.1.19376.1.5.3.1.4.21   (Mode d'administration : doses à début différé). De ce fait : 
                                                  - il ne peut pas y avoir d'entryRelationship de type "Prescription Item Entry Content Module" subordonnée
            </assert>
    
            <!-- Test du nombre d'id --> 
            <assert test="$count_id&gt;=1">
                [4] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                Il faut obligatoirement au moins un élément 'id' pour l'entrée (cardinalité [1..*]).
            </assert>
            
            <!-- Test du code (non obligatoire mais si présent, doit respecter un format spécifique) -->
            <assert test="($count_code=1 and $count_code_1=1) or ($count_code_1=0)">
                [5] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - L'élément optionnel 'code' ne peut être présent plus d'une fois (cardinalité [0..1]), 
                - si présent, ses attributs doivent être @code="DRUG" et @codeSystem="2.16.840.1.113883.5.4".
            </assert>
            
            <!-- Test de la présence d'un élémént <text> -->
            <assert test="($count_text=1)">
                [6] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée doit comporter obligatoirement un élément 'text' (cardinalité [1..1]).
            </assert>
            
            <!-- Test de la présence d'un élémént <statusCode> -->
            <assert test="($count_statusCode=1 and $count_statusCode_1=1)">
                [7] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée doit comporter obligatoirement un élément 'statusCode', dont l'attribut @code est fixé à la valeur 'completed'(cardinalité [1..1]).
            </assert>       
            
            <!-- Test du repeatNumber : si pas de renouvellement autorisé, value=0 ; si pas limité (période renouvellement fournie), alors @nullFlavor=NI -->
            <assert test="(//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:repeatNumber[@value&gt;=0]) 
                or (//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:repeatNumber[@nullFlavor='NI'])">
                
                [8] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'repeatNumber' est obligatoire pour l'entrée "Prescription Item Entry Content Module" et doit avoir une valeur d'attribut. Selon la situation :
                - Si aucun renouvellement autorisé (dispensation unique) : @value="0"
                - Si x renouvellement(s) autorisé(s) : @value="x"
                - Si le renouvellement n’est pas limité (par ex : si une période de renouvellement est définie), la valeur est fixée à @nullFlavor="NI".
                Note : le nombre total de dispensations est égal au repeatNumber + 1
                
            </assert>
            
            <!-- Test du routeCode (non obligatoire mais si présent, doit respecter un format spécifique)-->
            <assert test="$count_routeCode&lt;2">
                [9] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'routeCode' ne peut être présent plus d'une fois (cardinalité [0..1])
            </assert>
            
            <!-- Test du approachSiteCode (non obligatoire mais si présent, doit respecter un format spécifique)-->
                <assert test="($count_approachSiteCode&gt;0 and $count_approachSiteCode_1&gt;0) or ($count_approachSiteCode_1=0) or (cda:approachSiteCode[@nullFlavor])">
                [10] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - L'élément optionnel 'approachSiteCode' ne peut être présent plus d'une fois (cardinalité [0..1]), 
                - si présent, les valeurs de ses attributs doivent provenir du jeu de valeurs JDV_HL7_HumanSubstanceAdministrationSite-CISIS (2.16.840.1.113883.1.11.19724).
            </assert>
            
            
            <!-- Test, si présent, du format de 'doseQuantity' (non obligatoire)-->
            <assert test="(($count_doseQuantity=1) and (
                (cda:doseQuantity/cda:low) and
                (cda:doseQuantity/cda:high)
                )) or not(cda:doseQuantity)">
                [11] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - L'élément optionnel 'doseQuantity' ne peut être présent plus d'une fois (cardinalité [0..1]).
                - Si présent, alors il doit comporter obligatoirement un 'low' [1..1] et un 'high' [1..1]
            </assert>
            
            <!-- Test, si présent, du format de 'rateQuantity' (non obligatoire)-->
            <assert test="($count_rateQuantity=1) and (
                ($count_rateQuantity_low=1) and
                ($count_rateQuantity_high=1)
                ) or ($count_rateQuantity=0)">
                
                [12] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - L'élément optionnel 'rateQuantity' ne peut être présent plus d'une fois (cardinalité [0..1]).
                - Si présent, alors il doit comporter obligatoirement un 'low' [1..1] et un 'high' [1..1]
            </assert>     
            
            <!--Test, si présent, du format de 'maxDoseQuantity' (cardinalité [0..*]) -->
            <assert test="($count_maxDoseQuantity&gt;=1) and (
                ($count_maxDoseQuantity_numerator=$count_maxDoseQuantity) and
                ($count_maxDoseQuantity_denominator=$count_maxDoseQuantity)
                ) or ($count_maxDoseQuantity=0)">
                
                [13] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'maxDoseQuantity' (cardinalité [0..*]), si présent, doit comporter obligatoirement un 'numerator [1..1] et un 'denominator' [1..1]
            </assert>  
            
            <!-- Test présence et format du consumable (obligatoire) -->
            <assert test="$count_consumable =1">
                [14] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'consumable' est obligatoire pour l'entrée "Prescription Item Entry Content Module" de type 'manufacturedProduct'(cardinalité [1..1]), 
                et ne peut contenir qu'une entrée "FR-Produit-de-santé-prescrit" dont :
                - l'attribut du 'manufacturedProduct' @classcode="MANU"
                - le premier 'templateId' @root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2" (Conformité de l'entrée au volet IHE Pharm PRE)
            </assert>
            
            <!-- Test de non-présence de l'élément 'author' (car le document est une prescription) -->
            <assert test="$count_author=0">
                [15] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                Le document étant une prescription, l'élément 'author' est interdit ici.
            </assert>
            
            <!-- Test conformité de  l'entryRelationship optionnelle "IHE Internal Reference Entry" (Reason for treatment) (cardinalité [0..*])-->        
            <assert test="($count_ER_MotifTraitement&gt;=1) or ($count_ER_MotifTraitement=0)">
                [16] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle de type 'act' "IHE Internal Reference Entry" (Motif du traitement) (cardinalité [0..*]),
                si présente, doit avoir un templateId dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.4.1" (Conformité de l'entrée au parent IHE Pharm PRE)
            </assert>
             
                    
            <!-- Test, si présente, du format de l'entryRelationship "Reference to Medication Treatment Plan Item Entry" (cardinalité [0..1]) -->
            <assert test="($count_ER_RefItemPlanTrait=1) or ($count_ER_RefItemPlanTrait=0)">
                [17] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "Reference to Medication Treatment Plan Item Entry" de type substanceAdministration (cardinalité [0..1]), 
                si présente, doit contenir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.10" (Conformité de l'entrée au volet IHE Pharm PRE)
            </assert>
            
            
            <!-- Test, si présente, du format de l'entryRelationship "IHE Patient Medication Instructions" (cardinalité [0..1]) -->
            <assert test="($count_ER_InstrucPatient=1) or ($count_ER_InstrucPatient=0)">
                [18] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "IHE Patient Medication Instructions" de type act (cardinalité [0..1]), 
                si présente, doit contenir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.3" (Conformité de l'entrée au volet IHE PCC)
    
            </assert>
            
            
            <!-- Test, si présente, du format de l'entryRelationship "IHE Medication FulFillment Instructions" (cardinalité [0..1]) -->
            <assert test="($count_ER_InstructDispensateur=1) or ($count_ER_InstructDispensateur=0)">
                [19] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "IHE Medication FulFillment Instructions" de type act (cardinalité [0..1]), si présente, doit contenir :
                - un premier 'templateId' dont l'attribut @root="2.16.840.1.113883.10.20.1.43" (Conformité de l'entrée au parent CCD)
                - un deuxième 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.3.1" (Conformité de l'entrée au volet IHE PCC)
            </assert>
            
            
            <!-- Test, si présente, de l'entryRelationship "Amount of units of the consumable Content Module" (cardinalité [0..1]) -->
            <assert test="($count_ER_QuantiteProduit=1) or ($count_ER_QuantiteProduit=0)">
                [20] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "Amount of units of the consumable Content Module" de type supply (cardinalité [0..1]), si présente, doit contenir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.8" (Conformité de l'entrée au parent IHE Pharm PRE)
            </assert>
                  
            <!-- Test, si présente, de l'entryRelationship "Substitution Permission Content Module" (cardinalité [0..*]) -->
            <assert test="($count_ER_AutorisationSubstitution&gt;=1) or ($count_ER_AutorisationSubstitution=0)">
                [21] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                Si présente, l'entryRelationship de type 'act' "Substitution Permission Content Module" (cardinalité [0..*]) doit avoir un templateId dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.9.1" (Conformité de l'entrée au volet IHE Pharm PRE)
            </assert> 
            
            <!-- Test, si présente, de l'entryRelationship "Renewal Period General Specification" (cardinalité [0..1]) -->
            <assert test="($count_ER_PeriodeRenouvellement=1) or ($count_ER_PeriodeRenouvellement=0)">
                [22] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entryRelationship optionnelle "Renewal Period General Specification" de type supply (cardinalité [0..1]), si présente, doit contenir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.15" (Conformité de l'entrée au volet IHE Pharm PRE)
            </assert>
    
            <assert test="$count_reference=0">
                [23] [E_traitementPrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'reference' n'est pas utilisé dans le cas d'une prescription.
            </assert>
            
        </rule>
        
    </pattern>
