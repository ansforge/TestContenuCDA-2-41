<?xml version="1.0" encoding="UTF-8"?>

<!-- E_ObservationRequest_int.sch
    
    Teste la conformité de l'entrée "Observation Request Entry" (1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1) aux spécifications d'IHE PCC
    
    Historique :
    06/01/2016 : Création
    23/06/2017 : Ajout de contraintes sur le nombre de templateId
    23/08/2021 : Modification du message d'erreur sur l'élément text
   
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_observationRequest_int">
    
    <title>IHE PCC v3.0 Observation Request</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test="@classCode='OBS'"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'attribut "classCode" sera fixé à la valeur "OBS". </assert>
        
        <assert test="@moodCode = 'INT' or @moodCode = 'PRP' or @moodCode = 'GOL'"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "moodCode" 
            sera fixé à la valeur "INT" s'il s'agit d'une observation qui fait partie d'un plan de soins à accomplir,
            et il sera fixé à la valeur "PRP" quand l'observation est une proposition faite sur la base d'éléments
            cliniques.
            Dans le cas où l'observation est le but du plan de soins, l'élément "moodCode" sera fixé à la valeur "GOL".
        </assert>
        
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.25"]'>
            [E_ObservationRequest_int] : Erreur de Conformité PCC: Cette entrée se conforme au template 2.16.840.1.113883.10.20.1.25 </assert>
        
        <assert test="$count_templateId&gt;1">
            [E_ObservationRequest_int] Erreur de conformité PCC : Il doit y avoir au minimum deux templateIds
        </assert>
        
        <assert test="cda:id"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "id" est obligatoire. </assert>
        
        <assert test="cda:code"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "code" est obligatoire. </assert>
        
        <assert test="cda:text/cda:reference[@value]"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "text" contiendra
            une référence à la partie narrative. </assert>
        
        <assert test='cda:statusCode[@code="active"] or 
            cda:statusCode[@code="suspended"] or
            cda:statusCode[@code="aborted"] or
            cda:statusCode[@code="completed"] or
            cda:statusCode[@code="cancelled"] or
            cda:statusCode[@code="normal"] or
            cda:statusCode[@code="new"] or
            cda:statusCode[@code="held"]'>
            [E_ObservationRequest_int] :  L'élément "statusCode" associé à tout élément "observation request" doit prendre l'une des valeurs suivantes: 
            "active", "suspended", "aborted" ou "completed" ou "cancelled" ou "normal" ou "new" ou "held".</assert>
        
        <assert test="cda:effectiveTime" > 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "effectiveTime" est obligatoire. </assert>
        
    </rule>
    
</pattern>

