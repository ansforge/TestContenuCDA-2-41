<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_SurveyObservation_int.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "Survey Observation Entry" (1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    05/08/16 : HGH : Création
    02/03/17 : NMA : changer la valeur du statuscode de 'active' à 'completed'
    26/07/2017 : LBE : Suppression du controle de la valeur LOINC car pas explicitement indiqué dans IHE-PCC
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_surveyObservation_int">
    
    <title>IHE PCC v3.0 Survey observation</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test="@classCode='OBS'"> 
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation, l'attribut "classCode" sera fixé à la valeur "OBS". 
        </assert>
        
        <assert test="@moodCode = 'EVN'"> 
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation", l'élément "moodCode" 
            sera fixé à la valeur "EVN".
        </assert>
        
        <assert test="$count_templateId&gt;2">
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation", il doit y avoir au minimum trois éléments templateId
        </assert>
        
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
            [E_surveyObservation_int] Erreur de Conformité PCC : L'entrée "Survey Observation" est un fils de l'entrée simple Observation, elle doit donc avoir son templateId fixé à la valeur @root='1.3.6.1.4.1.19376.1.53.1.4.13'
        </assert>
        
        <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.31']">
            [E_surveyObservation_int] Erreur de Conformité PCC : L'entrée "Survey Observation" doit avoir une templateId fixé à la valeur @root='2.16.840.1.113883.10.20.1.31' pour respecter la conformité CCD
        </assert>
        
      
        
        <assert test="cda:value"> 
            [E_surveyObservation_int] Erreur de Conformité PCC :
            Dans une entrée "Survey Observation", un 'élément "value" est obligatoire (cardinalité [1..*]).
        </assert>
        
        <report test="cda:methodCode">
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation" l'élément methodCode ne doit pas être présent
        </report>
        
        <report test="cda:targetSiteCode">
            [E_surveyObservation_int] Erreur de Conformité PCC : Dans une entrée "Survey Observation", l'élément targetSiteCode ne doit pas être présent
        </report>
    </rule>
</pattern>
