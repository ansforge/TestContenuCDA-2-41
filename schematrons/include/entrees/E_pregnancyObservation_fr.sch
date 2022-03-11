<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_pregnancyObservation_int.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Pregnancy Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)
    aux spécifications du CI-SIS
    
    Historique :
    03/07/17 : NMA : Création
    
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_pregnancyObservation_fr">
   <title>CI-SIS Pregnancy Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)</title>
   <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.4.13.5&quot;]">
      
      <assert test='count(cda:id)=1'>
         [E_pregnancyObservation_fr]: Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" comporte obligatoirement un élément "id" (cardinalité [1..1])</assert>

      <assert test='count(cda:code)=1'>
         [E_pregnancyObservation_fr]: Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" doit comporter un élément "code" (cardinalité [1..1])</assert>
      
      <assert test='count(cda:text/cda:reference)=1'>
         [E_pregnancyObservation_fr]: Erreur de conformité CI-SIS : Un élément "Pregnancy Observation"  doit comporter un élément "text" avec une référence (cardinalité [1..1])</assert>
      
      <assert test="cda:statusCode[@code='completed']"> 
         [E_pregnancyObservation_fr] Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" contient un "statutCode" qui sera toujours fixé à la valeur code='completed'. </assert>

      <assert test="cda:effectiveTime"> 
         [E_pregnancyObservation_fr] Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" contient un seul "effectiveTime"</assert>
      
      <assert test='count(cda:value)=1'>
         [E_pregnancyObservation_fr] Erreur de conformité CI-SIS : Un élément "Pregnancy Observation" ne doit comporter qu'un seul élément "value"</assert>

    </rule>


  </pattern>
