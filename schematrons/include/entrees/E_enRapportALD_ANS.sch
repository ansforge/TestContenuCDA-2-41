<?xml version="1.0" encoding="UTF-8"?>

<!-- E_enRapportALD_ANS
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-En-rapport-avec-ALD (1.2.250.1.213.1.1.3.48.13) créée par l'ANS
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_enRapportALD_ANS">
        <title>Vérification de la conformité de l'entrée FR-En-rapport-avec-ALD (1.2.250.1.213.1.1.3.48.13) créée par l'ANS</title>     
      
        <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.3.48.13']">
            
            <let name="count_valueTrue" value="(count(cda:value[@value='true']))"/>
            <let name="count_valueFalse" value="(count(cda:value[@value='false']))"/>
            
            <!-- Test des templateId pour l'entrée "FR-En-rapport-avec-ALD" -->
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.48'] and cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
                [1] [E_enRapportALD_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-En-rapport-avec-ALD" doit avoir trois 'templateId' :
                - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.13" (Conformité de l'entrée au parent IHE PCC)
                - Un deuxième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48" (Conformité de l'entrée au parent CI-SIS)
                - Un troisième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48.13" (Conformité de l'entrée au format CI-SIS)
            </assert>
            
            <!-- Test présence et nombre max de l'élément 'id' -->
            <assert test="count(cda:id)=1">
                [2] [E_enRapportALD_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-En-rapport-avec-ALD" doit comporter un élément 'id'.
            </assert>        
     
            <!-- Test présence et format de l'élément 'code' -->
            <assert test="(count(cda:code[@code='MED-574'][@codeSystem='1.2.250.1.213.1.1.4.322'][@codeSystemName='TA_ASIP'][@displayName='En rapport avec une ALD'])=1)">
                [3] [E_enRapportALD_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-En-rapport-avec-ALD" doit comporter un élément 'code' avec les attributs :
                - @code="MED-574" (cardinalité [1..1])
                - @displayName="En rapport avec une ALD" (cardinalité [1..1]) 
                - @codeSystem="1.2.250.1.213.1.1.4.322" (cardinalité [1..1])
                - @codeSystemName="TA_ASIP" (cardinalité [1..1])
            </assert>            
                       
            <!-- Test de la présence de l'élément fils 'reference' -->
            <assert test="count(cda:text/cda:reference)=1">
                [4] [E_enRapportALD_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-En-rapport-avec-ALD" doit comporter un élément 'text/reference'. 
            </assert>
            
            <!-- Test de la présence de l'élément 'statusCode' -->
            <assert test="(count(cda:statusCode[@code='completed'])=1)">
                [5] [E_enRapportALD_ANS.sch] Erreur de conformité CI-SIS :  
                L'entrée "FR-En-rapport-avec-ALD" doit comporter un élément 'statusCode' et son attribut @code="completed". 
            </assert>
            
            <!-- Test présence et format de l'élément 'effectiveTime' -->
            <assert test="count(cda:effectiveTime)=1">
                [6] [E_enRapportALD_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-En-rapport-avec-ALD" doit comporter un élément 'effectiveTime'.
            </assert>
    
            <!-- Test présence de l'élément 'value' -->
            <assert test="(($count_valueTrue=1) or ($count_valueFalse=1)) and count(cda:value)=1">
                [7] [E_enRapportALD_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-En-rapport-avec-ALD" doit comporter un élément 'value' qui ne peut prendre qu'une des valeurs suivantes :
                - @value="true" : le traitement est prescrit dans le cadre d'une affection longue durée (ALD)
                - @value="false" : le traitement n'est pas prescrit dans le cadre d'une affection longue durée (ALD)
            </assert>
    
        </rule>
            
    </pattern>
