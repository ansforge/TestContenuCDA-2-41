<?xml version="1.0" encoding="UTF-8"?>

<!-- E_itemPlanTraitement_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Item-plan-traitement (IHE-MTP Medication Treatment Plan Item - 1.3.6.1.4.1.19376.1.9.1.3.7) à IHE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_itemPlanTraitement_int">
        <title>IHE MTP "Medication Treatment Plan Item Entry" (FR-Item-plan-traitement)</title>
        
        <!-- Test des éléments de l'entrée "FR-Item-plan-traitement" -->
        <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.7']">
            
            <let name="count_id" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:id)"/>  
            <let name="count_routeCode" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:routeCode[@codeSystem='2.16.840.1.113883.5.112'])"/> 
            <let name="count_approachSiteCode" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:approachSiteCode[@codeSystem='2.16.840.1.113883.1.11.19724'])"/>
            <let name="count_doseQuantity" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:doseQuantity)"/>  
            <let name="count_rateQuantity" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:rateQuantity)"/>
            <let name="count_maxDoseQuantity" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:maxDoseQuantity)"/>
            <let name="count_maxDoseQuantityNum" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:maxDoseQuantity/cda:numerator)"/>
            <let name="count_maxDoseQuantityDenom" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:maxDoseQuantity/cda:denominator)"/>
            
            <let name="count_effectiveTime" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.7']]/cda:effectiveTime)"/>
            
            <let name="count_MA_normales" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.1']])"/>
            <let name="count_MA_progressives" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.8']])"/>   
            <let name="count_MA_fractionnees" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.9']])"/>         
            <let name="count_MA_conditionnees" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.10']])"/> 
            <let name="count_MA_combinees" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.11']])"/> 
            <let name="count_MA_debutDiff" value="count(//cda:entryRelationship/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.21']])"/> 
            
            <let name="count_consumable" value="count(//cda:entryRelationship/cda:substanceAdministration/cda:consumable/cda:manufacturedProduct[@classCode='MANU']/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2'])"/> 
            <let name="count_ER_MotifTraitement" value="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1']])"/>
            <let name="count_ER_TraitementPrescritSub" value="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:sequenceNumber])"/>
            <let name="count_ER_InstrucPatient" value="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']])"/>
            <let name="count_ER_InstructDispensateur" value="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']])"/>
            <let name="count_ER_QuantiteProduit" value="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.8']])"/>
            <let name="count_ER_AutorisationSubstitution" value="count(//cda:entryRelationship/cda:substanceAdministration/cda:entryRelationship[cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']])"/>
            
            <let name="count_E_traitementPrescrit" value="count(//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']])"/>
            
            <!-- Vérification conformité CCD -->
            <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.24']">
                [1] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un templateId @root="2.16.840.1.113883.10.20.1.24".
            </assert>
            
            <!-- Vérification conformité IHE PCC --> 
            <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7']">
                [2] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter templateId @root="1.3.6.1.4.1.19376.1.5.3.1.4.7".
            </assert>
    
            <!-- Conformité du mode d'administration -->
            <assert test="
                (($count_MA_normales&gt;=1) and ($count_ER_TraitementPrescritSub=0) and ($count_effectiveTime=2*$count_E_traitementPrescrit)) or
                (($count_MA_progressives&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_effectiveTime=$count_E_traitementPrescrit)) or
                (($count_MA_fractionnees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_effectiveTime=$count_E_traitementPrescrit)) or
                (($count_MA_conditionnees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_effectiveTime=$count_E_traitementPrescrit)) or
                (($count_MA_combinees&gt;=1) and ($count_ER_TraitementPrescritSub&gt;=1) and ($count_effectiveTime=$count_E_traitementPrescrit)) or
                (($count_MA_debutDiff&gt;=1) and ($count_ER_TraitementPrescritSub=0) and ($count_effectiveTime=2*$count_E_traitementPrescrit))
                ">
                
                [3] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un 'templateId' indiquant le mode d'administration choisi pour le traitement prescrit. Il doit être choisi parmi la liste suivante :
                
                1.3.6.1.4.1.19376.1.5.3.1.4.7.1  (Mode d'administration : doses normales). De ce fait : 
                - il ne peut pas y avoir d'entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une deuxième occurence de l'élément 'effectiveTime' est obligatoire dans l'entrée (pour décrire la fréquence d'administration).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.8    (Mode d'administration : doses progressives). De ce fait :
                - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une seule occurence de l'élément 'effectiveTime' dans l'entrée (la fréquence d'administration sera décrite dans la subordonnée).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.9    (Mode d'administration : doses fractionnées). De ce fait : 
                - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une seule occurence de l'élément 'effectiveTime' dans l'entrée (la fréquence d'administration sera décrite dans la subordonnée).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.10   (Mode d'administration : doses conditionnelles). De ce fait : 
                - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une seule occurence de l'élément 'effectiveTime' dans l'entrée (la fréquence d'administration sera décrite dans la subordonnée).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.11   (Mode d'administration : doses combinées). De ce fait :
                - il doit y avoir une entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une seule occurence de l'élément 'effectiveTime' dans l'entrée (la fréquence d'administration sera décrite dans la subordonnée).
                
                1.3.6.1.4.1.19376.1.5.3.1.4.21   (Mode d'administration : doses à début différé). De ce fait : 
                - il ne peut pas y avoir d'entryRelationship de type "Prescription Item Entry Content Module" subordonnée
                - une deuxième occurence de l'élément 'effectiveTime' est obligatoire dans l'entrée (pour décrire la fréquence d'administration).
            </assert>
            
            <!-- Test présence et format de l'élément 'id' -->
            <assert test="($count_id=1)">
                [4] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un élément 'id'.
            </assert>
            
            <!-- Test présence et format de l'élément 'code' -->
            <assert test="(count(cda:code)=1 and (
                            (
                               (count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'])=1 and not(cda:code[@displayName]) and not(cda:code[@codeSystemName]))
                            or (count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'][@displayName='Médicament'])=1 and not(cda:code[@codeSystemName]))
                            or (count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'][@codeSystemName='HL7:ActCode'])=1 and not(cda:code[@displayName]))
                             )
                            or count(cda:code[@code='DRUG'][@codeSystem='2.16.840.1.113883.5.4'][@displayName='Médicament'][@codeSystemName='HL7:ActCode'])=1)
                                                 ) or not(cda:code)">
                [5] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement peut comporter un élément 'code', optionnel, qui doit avoir les attribut :
                - @code="DRUG" (cardinalité [1..1])
                - @codeSystem="2.16.840.1.113883.5.4" (cardinalité [1..1])
                - @displayName="Médicament" (cardinalité [0..1])
                - @codeSystemName="HL7:ActCode" (cardinalité [0..1])             
            </assert>
            
            <!-- Test présence de l'élément 'text/reference' -->
            <assert test="(count(cda:text/cda:reference)=1)">
                [6] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un élément 'test/reference'.
            </assert>
            
            <!-- Test présence et format de l'élément 'statusCode' -->
            <assert test="cda:statusCode[@code='completed'] and count(cda:statusCode)=1">
                [7] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un élément 'statusCode', dont l'attribut @code est fixé à la valeur 'completed'.
            </assert> 
            
            <!-- Test du routeCode (non obligatoire mais si présent, doit respecter un format spécifique)-->
            <assert test="($count_routeCode=1) or not(cda:routeCode)">
                [8] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                - L'élément optionnel 'routeCode' ne peut être présent plus d'une fois (cardinalité [0..1]), 
                - si présent, les valeurs de ses attributs doivent provenir du jeu de valeurs JDV_HL7_RouteOfAdministration-CISIS (2.16.840.1.113883.5.112).
            </assert>
            
            <!-- Test du approachSiteCode (non obligatoire mais si présent, doit respecter un format spécifique)-->
            <assert test="($count_approachSiteCode&gt;=1) or not(cda:approachSiteCode)">
                [9] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                - L'élément optionnel 'approachSiteCode' ne peut être présent plus d'une fois (cardinalité [0..*]), 
                - si présent, les valeurs de ses attributs doivent provenir du jeu de valeurs JDV_HL7_HumanSubstanceAdministrationSite-CISIS (2.16.840.1.113883.1.11.19724).
            </assert>
            
            <!-- Test du 'doseQuantity' (optionnel)-->
            <assert test="($count_doseQuantity=1) or not(cda:doseQuantity)">
                [10] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'élément optionnel 'doseQuantity' ne peut être présent plus d'une fois (cardinalité [0..1]).
            </assert>
            
            <!-- Test du  'rateQuantity' (optionnel)-->
            <assert test="($count_rateQuantity=1) or not(cda:rateQuantity)">
                [11] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'élément optionnel 'rateQuantity' ne peut être présent plus d'une fois (cardinalité [0..1]).
            </assert>
            
            <!-- Test du 'rateQuantity' (optionnel)-->
            <assert test="(($count_maxDoseQuantity&gt;=1) and ($count_maxDoseQuantityNum=$count_maxDoseQuantity) and ($count_maxDoseQuantityDenom=$count_maxDoseQuantity)) or ($count_maxDoseQuantity=0)">
                [12] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                - L'élément optionnel 'maxDoseQuantity' optionnel, peut être présent plusieurs fois (cardinalité [0..*])
                - Si présent, il doit comporter obligatoirement un élément fils 'numerator' [1..1] et un élément fils 'denominator' [1..1].
            </assert>
            
            <!-- Test présence de l'élément 'consumable' -->
            <assert test="($count_consumable=1)">
                [13] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée FR-Item-plan-traitement doit comporter un élément 'consumable' avec l'attribut @classCode="MANU".
                Il doit contenir une entrée de type 'manufacturedProduct' (Medicine entry" - 1.3.6.1.4.1.19376.1.5.3.1.4.7.2).
            </assert>
            
            <!-- Test conformité de  l'entrée optionnelle "IHE Internal Reference Entry" (Reason for treatment) (cardinalité [0..*])-->        
            <assert test="($count_ER_MotifTraitement&gt;=1) or ($count_ER_MotifTraitement=0)">
                [14] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée optionnelle de type 'act' "IHE Internal Reference Entry" (Motif du traitement), si présente, doit avoir un templateId @root="1.3.6.1.4.1.19376.1.5.3.1.4.4.1".
            </assert>            
            
            <!-- Test, si présente, du format de l'entrée "IHE Patient Medication Instructions" (cardinalité [0..1]) -->
            <assert test="($count_ER_InstrucPatient=1) or ($count_ER_InstrucPatient=0)">
                [15] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée optionnelle "IHE Patient Medication Instructions" de type act, si présente, doit contenir un 'templateId' @root="1.3.6.1.4.1.19376.1.5.3.1.4.3".                
            </assert>            
            
            <!-- Test, si présente, du format de l'entryRelationship "IHE Medication FulFillment Instructions" (cardinalité [0..1]) -->
            <assert test="($count_ER_InstructDispensateur=1) or ($count_ER_InstructDispensateur=0)">
                [16] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée optionnelle "IHE Medication FulFillment Instructions" de type act, si présente, doit contenir :
                - un MTPmier 'templateId' dont l'attribut @root="2.16.840.1.113883.10.20.1.43" et
                - un deuxième 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.3.1".
            </assert>            
            
            <!-- Test, si présente, de l'entryRelationship "Amount of units of the consumable Content Module" (cardinalité [0..1]) -->
            <assert test="($count_ER_QuantiteProduit=1) or ($count_ER_QuantiteProduit=0)">
                [17] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                L'entrée optionnelle "Amount of units of the consumable Content Module" de type supply, si présente, doit contenir un 'templateId' @root="1.3.6.1.4.1.19376.1.9.1.3.8".
            </assert>
            
            <!-- Test, si présente, de l'entryRelationship "Substitution Permission Content Module" (cardinalité [0..*]) -->
            <assert test="($count_ER_AutorisationSubstitution&gt;=1) or ($count_ER_AutorisationSubstitution=0)">
                [18] [E_itemPlanTraitement_int.sch] Erreur de conformité IHE Pharm MTP : 
                Si présente, l'entrée de type 'act' "Substitution Permission Content Module" doit avoir un templateId @root="1.3.6.1.4.1.19376.1.9.1.3.9.1".
            </assert> 
    
        </rule>   
    </pattern>
