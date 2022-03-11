<?xml version="1.0" encoding="UTF-8"?>

<!--                 
    E_vitalSignsOrganizer_int
   Teste la conformité de l'entrée Vital Signs Organizer en fonctionn de la conformité IHE-PCC
   
   20/06/2017 : LBE :Création
   30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_bloodTypeObservation_int">
    <title>IHE PCC v3.0 vital signs Organizer</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.6']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
            [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC :  L'élément blood Type Observation est un fils de l'élément simple Observation, il doit donc avoir son templateId fixé à la valeur @root ='1.3.6.1.4.1.19376.1.5.3.1.4.13'
        </assert>
        <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.31']">
            [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC :  L'élément blood Type Observation doit contenir un templateId avec la l'attribut @root fixé à '2.16.840.1.113883.10.20.1.31'
        </assert>
        <assert test="$count_templateId&gt;2">
            [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC : L'élément blood Type Observation doit contenir au minimum trois éléments templateId
        </assert>
       <assert test="cda:code[@code='882-1' and @codeSystem='2.16.840.1.113883.6.1']">
           [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC : L'élément blood Type Observation doit contenir un élément code avec les attributs suivant : 
            @code='882-1' 
            @displayName='ABO+RH GROUP' 
            @codeSystem='2.16.840.1.113883.6.1' 
            @codeSystemName='LOINC'      
       </assert>
        <assert test="cda:value[@xsi:type='CE']">
            [E_bloodTypeObservation_int.sch] :  Erreur de conformité PCC : L'élément blood Type Observation doit contenir un élément value de type CE (@xsi:type='CE')
        </assert>
    </rule>    
</pattern>

