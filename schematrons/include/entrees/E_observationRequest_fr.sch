<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_observationRequest_fr.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "Observation Request Entry" (1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1)
    aux spécifications du CI-SIS
    
    Historique :
    30/06/17 : NMA : Création
    23/05/19 : APE : l'élément <value> n'est pas obligatoire
   
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_observationRequest_fr">
    
    <title>CI-SIS Observation Request</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1']">
        <!-- <assert test="count(cda:value)&gt;0" > 
            [E_ObservationRequest_fr] : Erreur de Conformité CI-SIS: 
            Dans une entrée "Observation Request", l'élément "value" est obligatoire, il doit être présent au moins une fois. </assert> -->
        
        <assert test="count(cda:interpretationCode)&lt;2" > 
            [E_ObservationRequest_fr] : Erreur de Conformité CI-SIS: 
            Dans une entrée "Observation Request", l'élément "interpretationCode" ne peut être présent qu'une seule fois au maximum</assert>
        
        <assert test="count(cda:methodCode)&lt;2" > 
            [E_ObservationRequest_fr] : Erreur de Conformité CI-SIS: 
            Dans une entrée "Observation Request", l'élément "methodCode" ne peut être présent qu'une seule fois au maximum</assert>
        
        <assert test="count(cda:targetSiteCode)&lt;2" > 
            [E_ObservationRequest_fr] : Erreur de Conformité CI-SIS: 
            Dans une entrée "Observation Request", l'élément "targetSiteCode" ne peut être présent qu'une seule fois au maximum</assert>
        
    </rule>
    
</pattern>

