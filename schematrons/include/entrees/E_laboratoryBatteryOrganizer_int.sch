<?xml version="1.0" encoding="UTF-8"?>

<!--                   
    E_laboratoryBatteryOrganizer_int.sch
    Vérifie la conformité de l'entrée laboratory battery organizer en fonction du profil PALM 
    Paramètres d'appel :
        Néant
    27/06/2017 : LBE : Création
   30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_laboratoryBatteryOrganizer_int">

    <title>IHE PaLM laboratory Battery Organizer</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.3.1.4"]'>
        
        <let name="count_id" value="count(cda:id)"/>
        
        <assert test="@classCode='BATTERY' and @moodCode='EVN'">
            [E_laboratoryBatteryOrganizer_int.sch] Erreur de conformité PaLM : L'élément organizer de laboratory battery organizer doit avoir les attributs @classCode et @moodCode fixés respectivement aux valeurs suivante 'BATTERY' et 'EVN'
        </assert>
        
        <assert test="$count_id &lt;=1">
            [E_laboratoryBatteryOrganizer_int.sch] Erreur de conformité PaLM : L'élément laboratory battery organizer ne peut pas contenir plus d'un seul id (cardinalité [0..1])
        </assert>
        
        <assert test="cda:statusCode[@code='completed' or @code='aborted']">
            [E_laboratoryBatteryOrganizer_int.sch] Erreur de conformité PaLM : L'élément laboratory battery organizer doit contenir un statusCode avec l'attribut @code quqi prend les valeurs 'completed' ou 'aborted'
        </assert>
    </rule>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1']/cda:act/cda:subject">
        
        <let name="count_adresse" value="count(cda:relatedSubject/cda:addr)"/>
        
        <assert test="@typeCode='SBJ'">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un attribut @typêCode fixé à la valeur 'SBJ' s'il est présent
        </assert>
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.1.2.1']">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un templateId ayant la valeur @root = '1.3.6.1.4.1.19376.1.3.3.1.2.1'
        </assert>
        <assert test="cda:relatedSubject">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un relatedSubject
        </assert>
        <assert test="cda:relatedSubject/cda:code">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément relatedSubject doit contenir un code
        </assert>
        <assert test="$count_adresse=1">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément relatedSubject doit contenir une adresse (cardinalité [1..1])
        </assert>
        
    </rule>
</pattern>
