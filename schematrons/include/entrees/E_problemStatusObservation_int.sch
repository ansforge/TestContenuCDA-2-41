<?xml version="1.0" encoding="UTF-8"?>

<!-- E_problemStatusObservation_int.sch
    
    Vérification de la conformité de l'entrée FR-Statut-du-probleme (PCC Problem Status Observation - 1.3.6.1.4.1.19376.1.5.3.1.4.1.1)
    
    03/08/2011 : Création
    08/10/2012 : Remplacement des codes SNOMED CT par les codes SNOMED 3.5 pour observation/value
               basé sur le contenu des fiches de patients à risque cardio
    22/06/2017 : Ajout de contraintes internationales et du test sur le nombre de templateId
    30/01/2020 : Mise à jour du test sur le nombre de templateId
    01/12/2020 : Renommé
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_problemStatusObservation_int">
        <title>IHE PCC Problem Status Observation</title>
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.1.1"]'>
           
            <let name="count_templateId" value="count(cda:templateId)"/>
            
            <assert test='../../cda:entryRelationship[@typeCode="REFR" and @inversionInd="false"]'>
                [E_problemStatusObservation_int]Erreur de Conformité PCC: Une entrée 'Problem Status Observation' sera représentée comme un élément de type 'observation' 
                avec un attribut typeCode='SUBJ' et un inversionIND='false'.</assert>
            
            <assert
                test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
                [E_problemStatusObservation_int] Erreur de conformité PCC : Dans l'élément 'Problem Status Observation', le format de base utilisé pour 
                représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
                signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer 
                que l'événement a déjà eu lieu. </assert>
            
            
            <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.57"] and 
                cda:templateId[@root="2.16.840.1.113883.10.20.1.50"]'>
                [E_problemStatusObservation_int]: Les templates Id CCD 'Problem Status Observation' (2.16.840.1.113883.10.20.1.50)
                et 'Status Observation' (2.16.840.1.113883.10.20.1.57) parents de l'entrée 'Problem Status Observation' seront présents.</assert>
            
            <assert test="$count_templateId&gt;2">
                [E_problemStatusObservation_int] Erreur de conformité PCC : Dans l'élément "Severity", il doit y avoir au minimum trois templateIds
            </assert>
            
            <assert test='cda:code[@code = "33999-4" and @codeSystem = "2.16.840.1.113883.6.1"]'>
                [E_problemStatusObservation_int]: Erreur de Conformité PCC : l'élément 'code' d'une entrée 'Problem Status Observation' est obligatoire
                et signale qu'il s'agit d'une observation du statut clinique. L'attribut 'code' est fixé à la valeur '33999-4' 
                et l'attribut 'codeSystem' à la valeur '2.16.840.1.113883.6.1' (LOINC).</assert>
            
            <assert test="cda:text/cda:reference[@value]">
                [E_problemStatusObservation_int] Erreur de Conformité PCC : l'élément 'observation' d'une entrée 'Problem Status Observation' comporte 
                une composante 'text' contenant un élément 'reference/@value' pointant sur la partie narrative où la sévérité 
                de l'observation est signalée.</assert>
            
            <assert test='cda:statusCode[@code = "completed"]'>
                [E_problemStatusObservation_int] Erreur de Conformité PCC : L'attribut 'code' de l'élément 'statusCode' pour tous les éléments 'Problem Status
                observations' sera nécessarement fixé à la valeur 'completed' dans ce contexte.</assert>
 
            <assert test='cda:value[@xsi:type="CE"]'>
                [E_problemStatusObservation_int] Erreur de Conformité PCC : Pour tout élément de type 'Problem Status', l'élément 'value' signale le statut clinique.
                Il est toujours représenté utilisant le datatype 'CE' (xsi:type='CE') 
            </assert>

            <assert test='cda:text/cda:reference'>
                [E_problemStatusObservation_int] Erreur de Conformité PCC : L'élément 'observation' d'une entrée 'Problem Status Observation' comporte 
                une composante 'text' contenant un élément 'reference' pointant sur la partie narrative où la sévérité 
                de l'observation est signalée.
            </assert>
            
        </rule>
        
        
    </pattern>
    
        
