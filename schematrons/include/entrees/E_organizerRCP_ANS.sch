<?xml version="1.0" encoding="UTF-8"?>

<!-- E_organizerRCP_ANS.sch
    
     Vérification de la conformité de l'entrée FR-Statut-du-dossier-presente-en-RCP (1.2.250.1.213.1.1.3.7) créée par l'ANS
       
    Historique : 
    18/08/2017 : LBE :  Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_organizerRCP_ANS">
    <title>Vérification de la conformité de l'entrée FR-Statut-du-dossier-presente-en-RCP (1.2.250.1.213.1.1.3.7) créée par l'ANS</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.7"]'>

        <assert
            test="self::cda:organizer[@classCode='CLUSTER' and @moodCode='EVN']">
            [E_organizerRCP_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Statut-du-dossier-presente-en-RCP, les attributs @classCode et @moodCode de l'élément observation sont fixés resectivement aux valeurs 'CLUSTER' et 'EVN'</assert>
        <assert test="cda:code">
            [E_organizerRCP_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Statut-du-dossier-presente-en-RCP, l'élément code doit être présent
        </assert>
       
        <assert test="cda:statusCode/@code='completed'">
            [E_organizerRCP_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Statut-du-dossier-presente-en-RCP, le statusCode doit présent et fixé à la valeur @code='completed'
        </assert>
        <assert test="cda:component/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_organizerRCP_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée FR-Statut-du-dossier-presente-en-RCP, il doit y avoir au moins une simple observation (templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13')
       </assert>
    </rule>

</pattern>