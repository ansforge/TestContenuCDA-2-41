<?xml version="1.0" encoding="UTF-8"?>

<!-- E_vitalSignsObservation_fr.sch
    
    Vérification de la conformité de l'entrée FR-Signe-vital-observe (Vital Signs Observation - 1.3.6.1.4.1.19376.1.5.3.1.4.13.2)
    
    Historique :
    20/06/2017 : Création
    29/11/2017 : Mise à jour du test sur le nombre d'id car la bonne cardinalité est 0..1 et non 1..1
    01/12/2020 : Renommé
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_vitalSignsObservation_fr">
    <title>Modèles de contenu CDA  Vital Signs Observation</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.2"]'>
        <let name="count_id" value="count(cda:id)"/>
        <let name="count_interpretationCode" value="count(cda:interpretationCode)"/>
        <let name="count_methodCode" value="count(cda:methodCode)"/>
        <let name="count_targetSiteCode" value="count(cda:targetSiteCode)"/>
        
        <assert test="$count_id&lt;2">
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément 'id' ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
        <assert test="cda:text/cda:reference">
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément 'text' doit être présent et contenir un élément 'reference'
        </assert>
        <assert test="cda:statusCode[@code='completed']">
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément 'statusCode' est obligatoir et l'attribut @code est fixé à 'Completed'
        </assert>
        
        <assert test="$count_interpretationCode &lt;=1">
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément interpretationCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_methodCode &lt;=1">
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément methodCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_targetSiteCode &lt;=1">
            [E_vitalSignsObservation_fr.sch] Erreur de conformité CI-SIS : L'élément targetSiteCode ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
    </rule>
</pattern>
