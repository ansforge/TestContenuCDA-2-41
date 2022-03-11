<?xml version="1.0" encoding="UTF-8"?>

<!-- E_dispositifMedicalComplement_ANS.sch
    
     Vérification de la conformité de l'entrée Entrée Dispositif Médical – complément (1.2.250.1.213.1.1.3.1) créée par l'ANS
     (Ancienne version, ne plus utiliser cette entrée)
    
    Historique :
    03/07/17 : NMA : Création
        
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_dispositifMedicalComplement_ANS">
   <title>Vérification de la conformité de l'entrée Entrée Dispositif Médical – complément (1.2.250.1.213.1.1.3.1) créée par l'ANS</title>
   <rule context="*[cda:templateId/@root=&quot;1.2.250.1.213.1.1.3.1&quot;]">
      
      <assert test='@classCode="OBS" and @moodCode="EVN"'>
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : L'élément organizer doit avoir ses attributs fixés ainsi: classCode="OBS" et moodCode="EVN"
      </assert>
      
      <assert test='count(cda:templateId[@root="1.2.250.1.213.1.1.3.1"])=1'>
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : L'élément organizer doit avoir un élément templateId avec un attribut root='1.2.250.1.213.1.1.3.1'
      </assert>
      
      <assert test='count(cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"])=1'>
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : L'élément organizer doit avoir un élément templateId avec un attribut root='1.3.6.1.4.1.19376.1.5.3.1.4.13'
      </assert>
      
      <assert test='count(cda:id)=1'>
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical - Complément" comporte obligatoirement un élément "id".</assert>

      <assert test='count(cda:code)=1'>
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical - Complément" ne doit comporter qu'un seul élément "code"</assert>
      
      <assert test='count(cda:text/cda:reference)=1'>
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical - Complément" doit comporter un élément "text" avec une référence</assert>
      
      <assert test='count(cda:effectiveTime)=1'>
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical - Complément" doit comporter un élément "effectiveTime" pour horodater l'observation</assert>
      
      <assert test="count(cda:statusCode)=1"> 
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un élément "statutCode" </assert>
      
      <assert test="count(cda:value)=1"> 
         [E_dispositifMedicalComplement_ANS]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un élément "value" pour donner une valeur à l'élément observé </assert>
      
     
    </rule>
</pattern>