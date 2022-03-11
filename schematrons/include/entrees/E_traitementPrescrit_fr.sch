<?xml version="1.0" encoding="UTF-8"?>

<!-- E_traitementPrescrit_fr
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Traitement-prescrit aux spécifications du CI-SIS.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_traitementPrescrit_fr">
        <title>CI-SIS Entrée "FR-Traitement-prescrit"</title>
        
        <rule context="//cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.171']]/cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]">
            
            <!-- Formule count des templateId -->
            <let name="count_templateId" value="count(//cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.171']]/cda:entry/cda:substanceAdministration/cda:templateId)"/>
    
<!--            <let name="count_ER_HorsAMM" value="count(cda:entryRelationship/cda:observation[cda:templateId[@root='1.2.250.1.213.1.1.3.48.12']])"/>
            <let name="count_ER_EnRapportAT" value="count(cda:entryRelationship/cda:observation[cda:templateId[@root='1.2.250.1.213.1.1.3.48.14']])"/>
            <let name="count_ER_NonRemboursable" value="count(cda:entryRelationship/cda:observation[cda:templateId[@root='1.2.250.1.213.1.1.3.48.15']])"/>-->
            <let name="count_ER_EnRapportALD" value="count(cda:entryRelationship/cda:observation[cda:templateId[@root='1.2.250.1.213.1.1.3.48.13']])"/>
     
            <!-- Vérification conformité CI-SIS -->
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.83']">
                [1] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit" doit avoir un templateId dont l'attribut @root="1.2.250.1.213.1.1.3.83" (Conformité de l'entrée aux spécifications CI-SIS)
            </assert>
            
            <assert test="$count_templateId&gt;4">
                [2] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : Il doit y avoir au minimum 5 occurences de l'élément 'templateId' dans cette entrée :
                - La première pour la déclaration de conformité de l'entrée aux spécifications IHE Pharm PRE @root="1.3.6.1.4.1.19376.1.9.1.3.2"
                - La deuxième pour la déclaration de conformité de l'entrée aux spécifications CCD @root="2.16.840.1.113883.10.20.1.24"
                - La troisème pour la déclaration de conformité de l'entrée aux spécifications IHE PCC @root="1.3.6.1.4.1.19376.1.5.3.1.4.7"
                - La quatrième pour la déclaration de conformité de l'entrée aux spécifications CI-SIS @root="1.2.250.1.213.1.1.3.83"
                - La cinquième pour la déclaration du mode d'administration du traitement prescrit (à choisir parmi la liste des modes d'administration)
            </assert>     
<!--             
            <!-\- Test, si présente, de l'entryRelationship "FR-Hors-AMM" (cardinalité [0..1]) -\->
            <assert test="(($count_ER_HorsAMM=1) or ($count_ER_HorsAMM=0))">
                [3] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : 
                - L'entryRelationship optionnelle "FR-Hors-AMM" ne peut être présente qu'une fois (cardinalité [0..1]). 
                - Si présente, elle doit contenir un 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48.12" (Conformité de l'entrée au format CI-SIS) 
            </assert> -->     
            
            <!-- Test, si présente, de l'entryRelationship "FR-En-rapport-avec-ALD" (cardinalité [0..1]) -->
            <assert test="(($count_ER_EnRapportALD=1) or ($count_ER_EnRapportALD=0))">
                [4] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : 
                - L'entryRelationship optionnelle "FR-En-rapport-avec-ALD" ne peut être présente qu'une fois (cardinalité [0..1]). 
                - Si présente, elle doit contenir un 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48.13" (Conformité de l'entrée au format CI-SIS) 
            </assert>  
<!--            
            <!-\- Test, si présente, de l'entryRelationship "FR-En-rapport-avec-accident-travail" (cardinalité [0..1]) -\->
            <assert test="(($count_ER_EnRapportAT=1) or ($count_ER_EnRapportAT=0))">
                [5] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : 
                - L'entryRelationship optionnelle "FR-En-rapport-avec-accident-travail" ne peut être présente qu'une fois (cardinalité [0..1]). 
                - Si présente, elle doit contenir un 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48.14" (Conformité de l'entrée au format CI-SIS) 
            </assert>  
            
            <!-\- Test, si présente, de l'entryRelationship "FR-Non-remboursable" (cardinalité [0..1]) -\->
            <assert test="(($count_ER_NonRemboursable=1) or ($count_ER_NonRemboursable=0))">
                [6] [E_traitementPrescrit_fr.sch] Erreur de conformité CI-SIS : 
                - L'entryRelationship optionnelle "FR-Non-remboursable" ne peut être présente qu'une fois (cardinalité [0..1]). 
                - Si présente, elle doit contenir un 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48.15" (Conformité de l'entrée au format CI-SIS)  
            </assert>  
-->    
        </rule>
        
    </pattern>
