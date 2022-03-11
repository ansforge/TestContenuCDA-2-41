<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_surveyObdervation_fr.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "Survey Observation Entry" (1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    05/08/16 : HGH : Création
    02/03/17 : NMA : changer la valeur du statuscode de 'active' à 'completed'
    
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_surveyObservation_fr">
    
    <title>IHE PCC v3.0 Survey observation</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6']">
        <let name="count_id" value="count(cda:id)"/>
        <assert test="$count_id=1">
            [E_surveyObservation_fr] Erreur de conformité CI-SIS : L'élément Survey Observation doit contenir un seul id (cardinalité [1..1])
        </assert>
        <assert test="cda:statusCode[@code='completed']">
            [E_surveyObservation_fr] Erreur de conformité CI-SIS : L'élément Survey Observation doit avoir un statusCode dont la valeur est fixée à @code='completed'
        </assert>
        
    </rule>
</pattern>
