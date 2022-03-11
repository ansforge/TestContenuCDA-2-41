<?xml version="1.0" encoding="UTF-8"?>
<!--  E_observationScoreNIHSS_ANS.sch
    
      Vérification de la conformité de l'entrée FR-Score-NIHSS (1.2.250.1.213.1.1.3.6) créée par l'ANS
    
    Historique : 
    18/08/2017 : LBE :  Création
    20/10/17 : NMA : Correction du nom du schématron sur les messages d'erreur et du test sur le statusCode
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_observationScoreNIHSS_ANS">
    <title>Vérification de la conformité de l'entrée FR-Score-NIHSS (1.2.250.1.213.1.1.3.6) créée par l'ANS</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.6"]'>

        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN' and @negationInd='false']">
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, les attributs @classCode, @moodCode et @negationInd de l'élément observation sont fixés resectivement aux valeurs 'OBS', 'EVN' et 'false'</assert>

        <assert test='count(cda:id)=1'>
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, il doit y avoir un élément id (cardinalité [1..1])
        </assert>
        <assert test="count(cda:templateId)=3">
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, il doit y avoir trois templateId (crdinalité [3..3])
        </assert>
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, il doit y avoir le template Id de la simple observation (’1.3.6.1.4.1.19376.1.5.3.1.4.13’)
        </assert>
        <assert test="cda:templateId/@root='2.16.840.1.113883.10.20.1.31'">
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, Il doit y avoir le templateId/@root='2.16.840.1.113883.10.20.1.31'
        </assert>
        <assert test="cda:statusCode/@code='completed'">
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, le statusCode doit présent et fixé à la valeur @code='completed'
        </assert>
        <assert test="cda:effectiveTime">
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, un élément effectiveTime doit être présent 
        </assert>
        <assert test="count(cda:value)=1">
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, il doit y avoir un élément value (cardinalité [1..1])
        </assert>
        <assert test="not(cda:entryRelationship) or cda:entryRelationship/cda:observation/cda:templateId/@root='1.2.250.1.213.1.1.3.8'">
            [E_observationScoreNIHSS_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Score-NIHSS, il ne peut y avoir que des observations NIHSS Component entry (1.2.250.1.213.1.1.3.8)
        </assert>
    </rule>

</pattern>