<?xml version="1.0" encoding="UTF-8"?>

<!--   E_observationNIHSSComponent_ANS.sch
    
       Vérification de la conformité de l'entrée FR-Composant-score-NIHSS (1.2.250.1.213.1.1.3.8) créée par l'ANS
    
    Historique : 
    18/08/2017 : LBE :  Création
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_observationNIHSSComponent_ANS">
    <title>Vérification de la conformité de l'entrée FR-Composant-score-NIHSS (1.2.250.1.213.1.1.3.8) créée par l'ANS</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.8"]'>

        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, les attributs @classCode, @moodCode de l'élément observation sont fixés resectivement aux valeurs 'OBS', 'EVN' </assert>

        <assert test='count(cda:id)=1'>
            [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, il doit y avoir un élément id (cardinalité [1..1])
        </assert>
        <assert test="count(cda:templateId)&gt;2">
            [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, il doit y avoir au minimum trois templateId
        </assert>
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, il doit y avoir le template Id de la simple observation (’1.3.6.1.4.1.19376.1.5.3.1.4.13’)
        </assert>
        <assert test="cda:templateId/@root='2.16.840.1.113883.10.20.1.31'">
            [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, Il doit y avoir le templateId/@root='2.16.840.1.113883.10.20.1.31'
        </assert>
        <assert test="cda:statusCode/@code='completed'">
            [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, le statusCode doit présent et fixé à la valeur @code='completed'
        </assert>
        <assert test="cda:effectiveTime">
            [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, un élément effectiveTime doit être présent 
        </assert>
        <assert test="count(cda:value)=1">
            [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, il doit y avoir un élément value (cardinalité [1..1])
        </assert>
       <assert test="count(cda:interpretationCode)&lt;=1">
           [E_observationNIHSSComponent_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Composant-score-NIHSS, il peut y avoir un interpretationCode (cardinalité [0..1])
       </assert>
    </rule>

</pattern>