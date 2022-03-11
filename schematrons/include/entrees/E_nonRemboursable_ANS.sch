<?xml version="1.0" encoding="UTF-8"?>

<!-- E_nonRemboursable_ANS
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Non-remboursable (1.2.250.1.213.1.1.3.48.15) créée par l'ANS
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_nonRemboursable_ANS">
    <title>Vérification de la conformité de l'entrée FR-Non-remboursable (1.2.250.1.213.1.1.3.48.15) créée par l'ANS</title>
      
        <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.3.48.15']">
            
            <let name="count_valueTrue" value="(count(cda:value[@value='true']))"/>
            <let name="count_valueFalse" value="(count(cda:value[@value='false']))"/>        
            
            <!-- Test des templateId pour l'entrée "FR-Non-remboursable" -->
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.48'] and cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
                [1] [E_nonRemboursable_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Non-remboursable" doit avoir trois occurrences de 'templateId' :
                - Un premier 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.13"
                - Un deuxième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48"
                - Un troisième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.48.15"
            </assert>
            
            <!-- Test présence et nombre max de l'élément 'id' -->
            <assert test="(count(cda:id)=1)">
                [2] [E_nonRemboursable_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Non-remboursable" doit comporter un élément 'id'.
            </assert>        
     
            <!-- Test présence et format de l'élément 'code' -->
            <assert test="(count(cda:code[@code='GEN-181'][@codeSystem='1.2.250.1.213.1.1.4.322'][@codeSystemName='TA_ASIP'][@displayName='Non remboursable'])=1)">
                [3] [E_nonRemboursable_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Non-remboursable" doit comporter un élément 'code' avec les attributs :
                - @code="GEN-181" (cardinalité [1..1])
                - @displayName="Non remboursable" (cardinalité [1..1]) 
                - @codeSystem="1.2.250.1.213.1.1.4.322" (cardinalité [1..1])
                - @codeSystemName="TA_ASIP" (cardinalité [1..1])
            </assert>
            
            <!-- Test de la présence de l'élément fils 'reference' -->
            <assert test="(count(cda:text/cda:reference)=1)">
                [4] [E_nonRemboursable_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Non-remboursable" doit comporter un élément 'text/reference'. 
            </assert>
            
            <!-- Test de la présence de l'élément 'statusCode' -->
            <assert test="(count(cda:statusCode[@code='completed'])=1)">
                [5] [E_nonRemboursable_ANS.sch] Erreur de conformité CI-SIS :  
                L'entrée "FR-Non-remboursable" doit comporter un élément 'statusCode' avec un attribut @code="completed". 
            </assert>
            
            <!-- Test présence et format de l'élément 'effectiveTime' -->
            <assert test="(count(cda:effectiveTime)=1)">
                [6] [E_nonRemboursable_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Non-remboursable" doit comporter un élément 'effectiveTime'.
            </assert>
    
            <!-- Test présence de l'élément 'value' -->
            <assert test="(($count_valueTrue=1) or ($count_valueFalse=1)) and count(cda:value)=1">
                [7] [E_nonRemboursable_ANS.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Non-remboursable" doit comporter un élément 'value'. L'attribut @value ne peut prendre qu'une des valeurs suivantes :
                - @value="true" : le traitement prescrit n'est pas remboursable
                - @value="false" : le traitement prescrit est remboursable
            </assert>
    
        </rule>
            
    </pattern>
