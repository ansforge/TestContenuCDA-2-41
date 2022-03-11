<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_socialHistoryObservation_fr.sch ]O@%#o>>=-
   
   Teste la conformité de l'entrée "Social History Observation: 1.3.6.1.4.1.19376.1.5.3.1.4.13.4
   aux spécifications du CI-SIS
   
   Historique :
   29/06/17 : NMA : Création
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_socialHistoryObservation_fr">
   <title>CI-SIS Social History Observation: 1.3.6.1.4.1.19376.1.5.3.1.4.13.4</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]'>
       <let name="count_id" value="count(cda:id)"/>

       <assert test='@moodCode="EVN" and @classCode="OBS"'>
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : Les attributs de l’élément "observation" sont fixés aux valeurs :
          classCode=’OBS’ et moodCode=’EVN’
       </assert>
       
       <assert test="not(cda:id) or $count_id=1">
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'indentifiant ne peut être présent qu'une seule fois au maximum
       </assert>
       
       <assert test="count(cda:code)=1">
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'élément code est obligatoirement présent une seule fois
       </assert>
       
       <assert test="count(cda:statusCode)=1">
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'élément statusCode est obligatoirement présent une seule fois
       </assert>
       
       <assert test="count(cda:effectiveTime)=1">
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'élément effectiveTime est obligatoirement présent une seule fois
       </assert>
       
       <assert test="cda:value">
          [E_socialHistoryObservation_fr]: Erreur de conformité au CI-SIS : L'élément value est obligatoirement présent au moins une fois
       </assert>
       
    </rule>

  </pattern>


