<?xml version="1.0" encoding="UTF-8"?>

<!--             
    
    E_simpleObservation_fr.sch :
    Contenu :
       Contrôle la conformité des éléments simple observation conformément au volet Modèles de contenu CDA.
    Paramètres d'appel :
        Néant
    Historique :
    19/06/2017 : Création
    27/10/2021 : Suppression du test de présence de l'élément value     
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_simpleObservation_fr">
    <title>IHE PCC v3.0 Simple Observation</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
        <let name="count_value" value="count(cda:value)"/>
        <let name="count_interpretationCode" value="count(cda:interpretationCode)"/>
        <let name="count_methodCode" value="count(cda:methodCode)"/>
        <let name="count_targetSiteCode" value="count(cda:targetSiteCode)"/>
        <let name="count_author" value="count(cda:author)"/>
        
        <!--<assert test="$count_value=1">
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément value doit être présent une seule fois (cardinalité [1..1])
        </assert>-->
        <assert test="$count_interpretationCode &lt;=1">
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément interpretationCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_methodCode &lt;=1">
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément methodCode ne peut être présent qu'une seule foix au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_targetSiteCode &lt;=1">
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément targetSiteCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_author &lt;=1">
            [E_simpleObservation_fr.sch] Erreur de conformité CI-SIS : L'élément author ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        
        
    </rule>
    
    
</pattern>

