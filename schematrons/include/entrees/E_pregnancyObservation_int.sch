<?xml version="1.0" encoding="UTF-8"?>

<!-- E_pregnancyObservation_int.sch
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Observation-sur-la-grossesse (IHE PCC - Pregnancy Observation - 1.3.6.1.4.1.19376.1.5.3.1.4.13.5) à IHE.
     ......................................................................................................................................................
     Historique :
     21/08/13 : CRI : Création
     26/06/17 : NMA : Ajout de contraite sur les templateIds, sur le code et sur la value
     30/11/20 : correction quotes dans ligne <rule 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_pregnancyObservation_int">
   <title>IHE PCC Pregnancy Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)</title>
   <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']">
      <let name="count_templateId" value="count(cda:templateId)"/>
      
      <assert test="$count_templateId&gt;1">
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse doit comporter au minimum deux templateIds
      </assert>
      
    <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
       [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse doit comporter le templateId parent (1.3.6.1.4.1.19376.1.5.3.1.4.13).
    </assert>
      
      <assert test='cda:code'>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse comporte obligatoirement un élément "code".</assert>

      <report test='cda:repeatNumber'>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse ne doit pas comporter d'élément &lt;repeatNumber&gt;.
      </report>
      
      <assert test='cda:value'>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse comporte obligatoirement un élément "value".</assert>

      <report test='cda:interpretationCode or cda:methodCode or cda:targetSiteCode'>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'entrée FR-Observation-sur-la-grossesse ne doit pas comporter les éléments &lt;interpretationCode&gt;, 
         &lt;methodCode&gt;, and &lt;targetSiteCode&gt;.
      </report>
    </rule>


  </pattern>
