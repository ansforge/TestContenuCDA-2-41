<?xml version="1.0" encoding="UTF-8"?>

<!-- E_instructionsDispensateur_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Instructions-au-dispensateur (IHE-PCC - Medication-Fulfillment-Instruction - 1.3.6.1.4.1.19376.1.5.3.1.4.3.1)à IHE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_instructionsDispensateur_int">
        <title>IHE PCC Entrée FR-Instructions-au-dispensateur (Medication-Fulfillment-Instruction)</title>     
      
        <!-- Test des templateId pour l'entrée "FR-Instructions-au-dispensateur" -->
        <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']">            
            
            <let name="count_code" value="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]/cda:code[@code='FINSTRUCT'][@codeSystem='1.3.6.1.4.1.19376.1.5.3.2'])"/>
            <let name="count_text" value="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]/cda:text)"/>
            <let name="count_reference" value="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]/cda:text/cda:reference)"/>
            <let name="count_statusCode" value="count(//cda:entryRelationship/cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]/cda:statusCode[@code='completed'])"/> 
            
            <let name="count_ER_InstructDispensateur" value="count(//self::cda:entryRelationship[cda:act[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']]])"/>
            
            <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.43']">
                [1] [E_instructionsDispensateur_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-dispensateur doit avoir deux 'templateId' :
                - Un premier 'templateId' @root="1.3.6.1.4.1.19376.1.5.3.1.4.3.1"
                - Un deuxième 'templateId' @root="2.16.840.1.113883.10.20.1.43"
            </assert>
            
            <!-- Test présence et format de l'élément 'code' -->
            <assert test="($count_code=$count_ER_InstructDispensateur)">
                [2] [E_instructionsDispensateur_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-dispensateur doit comporter un élément 'code' et ses attribut @code="PINSTRUCT" et @codeSystem="1.3.6.1.4.1.19376.1.5.3.2".
            </assert>            
            
            <!-- Test de la présence de l'élément 'text' -->
            <assert test="(($count_text=$count_ER_InstructDispensateur) and ($count_reference=$count_ER_InstructDispensateur))">
                [3] [E_instructionsDispensateur_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Instructions-au-dispensateur doit comporter un élément 'text/reference'.
            </assert>            
            
            <!-- Test de la présence de l'élément 'statusCode' -->
            <assert test="($count_statusCode=$count_ER_InstructDispensateur)">
                [4] [E_instructionsDispensateur_int.sch] Erreur de conformité IHE PCC :  
                L'entrée FR-Instructions-au-dispensateur doit comporter un élément 'statusCode' et son attribut @code="completed". 
            </assert>
            
        </rule>
            
    </pattern>
