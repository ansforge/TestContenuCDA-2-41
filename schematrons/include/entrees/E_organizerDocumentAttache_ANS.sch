<?xml version="1.0" encoding="UTF-8"?>

<!--  E_organizerDocumentAttache_ANS.sch
    
      Vérification de la conformité de l'entrée FR-Document-attache (1.2.250.1.213.1.1.3.18) créée par l'ANS
    
    Historique : 
    18/08/2017 : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_organizerDocumentAttache_ANS">
    <title>ASIP Santé organizer RCP </title>
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.3.18"]'>

        <assert test="self::cda:organizer[@classCode = 'CLUSTER' and @moodCode = 'EVN']">
            [E_organizerDocumentAttache_ANS.sch] Erreur de conformité CI-SIS : Dansl'entrée FR-Document-attache, les attributs @classCode et @moodCode de l'élément
            observation sont fixés resectivement aux valeurs 'CLUSTER' et 'EVN'
        </assert>
        <assert test="count(cda:id) = 1">
            [E_organizerDocumentAttache_ANS.sch] Erreur de conformité CI-SIS : Dansl'entrée FR-Document-attache, il doit y avoir un élément 'id' (cardinalité [1..1])
        </assert>
        <assert test="cda:code">
            [[E_organizerDocumentAttache_ANS.sch] Erreur de conformité CI-SIS : Dansl'entrée FR-Document-attache, l'élément code doit être présent.
        </assert>

        <assert test="cda:statusCode/@code = 'completed'">
            [E_organizerDocumentAttache_ANS.sch] Erreur de conformité CI-SIS : Dansl'entrée FR-Document-attache, le 'statusCode' doit présent et fixé à la valeur @code='Completed'
        </assert>

        <assert
            test="cda:component/cda:observation/cda:templateId/@root = '1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_organizerDocumentAttache_ANS.sch] Erreur de conformité CI-SIS : Dansl'entrée FR-Document-attache,il doit y avoir au moins une simple observation
            (templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13')
        </assert>
        <assert test="cda:component/cda:observationMedia[@classCode = 'OBS' and @moodCode = 'EVN']/cda:value[@mediaType and @representation = 'B64']">
            [E_organizerDocumentAttache_ANS.sch] Erreur de conformité CI-SIS : Dansl'entrée FR-Document-attache, il doit y avoir au moins un observation media, contenant
            une value dont le XPath est le suivant :
            cda:component/cda:observationMedia[@classCode='OBS' and
            @moodCode='EVN']/cda:value[@mediaType='text/xml' and @representation='B64']
        </assert>
    </rule>

</pattern>
