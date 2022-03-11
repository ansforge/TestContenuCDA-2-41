<?xml version="1.0" encoding="UTF-8"?>

<!-- E_healthStatusObservation_int.sch
    
    Vérification de la conformité de l'entrée FR-Statut-clinique-du-patient (IHE PCC health Status Observation - 1.3.6.1.4.1.19376.1.5.3.1.4.1.2)
    aux spécifications d'IHE PCC
    
    Historique :
    09/08/2016 : Création
    22/06/2017 : Ajout des contraintes internationales
    30/01/2020 : Mise à jour du test sur le nombre de templateId
    01/12/2020 : Renommé
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_healthStatusObservation_int">
    <title>IHE PCC health Status Observation</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test='../../cda:entryRelationship[@typeCode="REFR"]'>
            [E_healthStatusObservation_int] Erreur de Conformité PCC: Une entrée FR-Statut-clinique-du-patient est représentée comme une élément de type 'observation' 
            avec un attribut typeCode='REFR'.</assert>
        
        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [E_healthStatusObservation_int] Erreur de conformité PCC : Dans l'entrée FR-Statut-clinique-du-patient, le format de base utilisé pour 
            représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
            signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer que l'événement a déjà eu lieu. </assert>
        
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.51"]'>
            [E_healthStatusObservation_int] Erreur de conformité PCC : Le templateId parent (2.16.840.1.113883.10.20.1.51) doit être présent.
        </assert>
        
        <assert test="$count_templateId&gt;1">
            [E_healthStatusObservation_int] Erreur de conformité PCC : Dans l'entrée FR-Statut-clinique-du-patient, il doit y avoir au minimum deux templateId
        </assert>        
        
        <assert test='cda:code[@code="11323-3" and @codeSystem="2.16.840.1.113883.6.1"]'>
            [E_healthStatusObservation_int] Erreur de Conformité PCC: L'élément 'code' de l'entrée FR-Statut-clinique-du-patient indique la 
            sévérité de l'allergie provoquée.
            L'élément 'code' doit obligatoirement comporter les attributs 'code' et 'codeSystem'.</assert>
        
        <assert test="cda:text/cda:reference[@value]">
            [E_healthStatusObservation_int] Erreur de conformité PCC : L'élément 'text' doit être présent avec un élément reference qui contient une URI dans l'attribut @value
        </assert>
        
        <assert test="cda:statusCode[@code='completed']"> 
            [E_healthStatusObservation_int] Erreur de conformité PCC : Le composant "statutCode" d'une entrée FR-Statut-clinique-du-patien sera toujours fixé à la valeur code='completed'. </assert>
        
        <assert test='cda:value[@xsi:type="CE"]'>
            [E_healthStatusObservation_int] Erreur de conformité PCC : Dans l'entrée FR-Statut-clinique-du-patient, l'élément 'value' signale le statut clinique.
            Il est toujours représenté utilisant le datatype 'CE' (xsi:type='CE') 
        </assert>
        
    </rule>
    
    
</pattern>
