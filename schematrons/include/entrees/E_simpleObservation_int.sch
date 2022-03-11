<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ simpleObservation.sch ]O@%#o>>=-
    
    Teste les entrées de la section PCC Simple Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)

    25/07/11 : Création
    19/06/2017 : Ajout de la vérification de l'élément texte et des indications : [E_simpleObservation_int.sch]
                       modification de l'id du pattern (au même nom que le nom du schématorn)
    27/10/2021 : Suppression du test de présence de l'élément value                   
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_simpleObservation_int">
    <title>IHE PCC v3.0 Simple Observation</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
        <assert test="@classCode='OBS' and @moodCode='EVN'">
           [E_simpleObservation_int.sch] Erreur de Conformité PCC:  Ce templateId doit être utilisé comme une observation avec les attributs @classCode et @moodCode fixés respectivement aux valeurs 'OBS' et 'EVN'
        </assert>
        <assert test='cda:id'>
           [E_simpleObservation_int.sch] Erreur de Conformité PCC: "Simple Observation" requiert un élément identifiant &lt;id&gt;.</assert>
        
        <assert test='cda:code'>
            [E_simpleObservation_int.sch] Erreur de Conformité PCC: "Simple Observation" requiert un élément "code" décrivant ce qui est observé.</assert>
        <assert test="cda:text/cda:reference">
            [E_simpleObservation_int.sch] Erreur de conformité PCC : "Simple Observation" doit contenir un élément texte, qui doit contenir un élément référence
        </assert>
        <assert test='cda:statusCode[@code = "completed"]'>
            [E_simpleObservation_int.sch] Erreur de Conformité PCC: L'élément "statusCode" est requis dans "Simple Observations" 
            sont fixés à la valeur "completed".</assert>
        
        <assert test='cda:effectiveTime[@value or @nullFlavor] or cda:effectiveTime/cda:low[@value or @nullFlavor]'>
            [E_simpleObservation_int.sch] Erreur de Conformité PCC: L'élément &lt;effectiveTime&gt; est requis dans "Simple Observations",
            et représentera la date et l'heure de la mesure effectuée. Cet élément devrait être précis au jour. 
            Si la date et l'heure sont inconnues, l'attribut nullFlavor sera utilisé.</assert>
        
<!--        <assert test='cda:value'>
            [E_simpleObservation_int.sch] Erreur de Conformité PCC: L'élément "value" d'un élément "Simple Observation" utilisera un 
            type de donnée approprié à l'observation.</assert>  -->      
        
    </rule>
    
    
</pattern>

