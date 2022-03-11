<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_socialHistoryObservation_int.sch ]O@%#o>>=-
   
   Teste la conformité de la section " IHE PCC Social History Observation: 1.3.6.1.4.1.19376.1.5.3.1.4.13.4
   aux spécifications d'IHE PCC v3.0
   
   Historique :
   21/08/13 : CRI : Création
   22/06/17 : NMA : Ajout de la contrainte sur le nombre de templateId
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_socialHistoryObservation_int">
   <title>IHE PCC Social History Observation: 1.3.6.1.4.1.19376.1.5.3.1.4.13.4</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]'>
       <let name="count_templateId" value="count(cda:templateId)"/>

       <assert test='cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"'>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : Le templateId du parent (Simple Observation)doit être présent.
       </assert>

       <assert test='cda:templateId/@root="2.16.840.1.113883.10.20.1.33"'>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : Le templateId du parent HL7 CCD Social History doit être présent.
       </assert>
       
       <assert test="$count_templateId&gt;2">
          [E_socialHistoryObservation_int.sch] Erreur de conformité PCC : Dans l'élément "Social History Observation", il doit y avoir au minimum trois templateId
       </assert>
       
       <!-- 
       <assert test='not(cda:value) or cda:value[@xsi:type = "PQ" or @xsi:type="CD" or @xsi:type="ANY"]'>
      [socialHistoryObservation] (Warning) Le type de données des observationdevraient être PQ, CD ou ANY.
   </assert>
 -->
       <assert test='not(cda:repeatNumber)'>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : L'élément &lt;repeatNumber&gt; devrait être omis.
       </assert>

       <assert test='not(cda:interpretationCode)'>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : L'élément &lt;interpretationCode&gt; devrait être omis.
       </assert>

       <assert test='not(cda:methodCode)'>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : L'élément &lt;methodCode&gt; devrait être omis.
       </assert>

       <assert test='not(cda:targetSiteCode)'>
          [E_socialHistoryObservation_int] Erreur de conformité PCC : L'élément &lt;targetSiteCode&gt; devrait être omis.
       </assert>
    </rule>

</pattern>


