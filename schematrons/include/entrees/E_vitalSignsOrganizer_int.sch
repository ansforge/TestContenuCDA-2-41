<?xml version="1.0" encoding="UTF-8"?>

<!--                 
    E_vitalSignsOrganizer_int
   Teste la conformité de l'entrée Vital Signs Organizer en fonctionn de la conformité IHE-PCC
   
   20/06/2017 : LBE :Création
   27/07/2017 : Suppression du test sur le code
   16/08/2017 : LBE : Ajout du nullFlavor pour l'effectiveTime
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_vitalSignsOrganizer_int">
    <title>IHE PCC v3.0 vital signs Organizer</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.1']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="self::cda:organizer[@classCode='CLUSTER' and @moodCode='EVN']">
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs 'CLUSTER' et 'EVN'
        </assert>
        <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.32']">
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir l'élément templateId avec l'attribut @root fixé à '2.16.840.1.113883.10.20.1.32' 
        </assert>
        <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.35']">
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir l'élément templateId avec l'attribut @root fixé à '2.16.840.1.113883.10.20.1.35' 
        </assert>
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.1']">
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir l'élément templateId avec l'attribut @root fixé à '1.3.6.1.4.1.19376.1.5.3.1.4.13.1' 
        </assert>
        <assert test="$count_templateId&gt;2">
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir au minimum trois éléments templateId
        </assert>
        <assert test='cda:id'>
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : vitalSignsOrganizer doit contenur un élement Id
        </assert>
       
       <!--<assert test="cda:code[@code='46680005'] and cda:code[@displayName='Vital signs'] and cda:code[@codeSystem ='2.16.840.1.113883.6.96'] and cda:code[@codeSystemName='SNOMED CT']">
           [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : L'élément code doit être constitué comme suit : 
               '&lt;code code='46680005' displayName='Vital signs' 
               codeSystem='2.16.840.1.113883.6.96'
               codeSystemName='SNOMED CT'/&gt;'
       </assert>-->
      <assert test="cda:effectiveTime[@value] or cda:effectiveTime[@nullFlavor]">
          [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir un élément "effectiveTime" avec l'attribut @value
      </assert>
        
        <assert test="cda:component[@typeCode='COMP']/cda:observation[@classCode='OBS' and @moodCode='EVN']/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.2']">
            [E_vitalSignsOrganizer_int] Erreur de Conformité PCC : l'élément "organizer" doit contenir une ou plusieurs vital signs obseration (templateId : 1.3.6.1.4.1.19376.1.5.3.1.4.13.2) : 
            &lt;component typeCode='COMP'&gt; 
                &lt;observation classCode='OBS' moodCode='EVN'&gt;
                    &lt;templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.13.2'/&gt;
                   
               &lt;/observation&gt;
           &lt;/component&gt;
             
        </assert>
       
    </rule>    
</pattern>

