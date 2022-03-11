<?xml version="1.0" encoding="UTF-8"?>

<!--                   
    E_specimentCollection_int.sch
    Vérifie la conformité de l'entrée specimen collection en fonction du profil PALM 
    Paramètres d'appel :
        Néant
    27/06/2017 : LBE : Création
    24/07/2017 : LBE : Ajout de la vérification du compte des entryRelationShip act (1.3.6.1.4.1.19376.1.3.1.3)
    02/07/2018 : NMA : Suppression du test sur le code de l'entrée
    12/07/2018 : NMA : Suppression du test sur la présence du code de la playingEntity
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_specimenCollection_int">

    <title>IHE PaLM specimen Collection</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.3.1.2"]'>
        
        <let name="count_targetSiteCode" value="count(cda:targetSiteCode)"/>
        <let name="count_performer" value="count(cda:performer)"/>
        <let name="count_participant" value="count(cda:participant)"/>
        <let name="count_participant_id" value="count(cda:participant/cda:participantRole/cda:id)"/>
        <let name="count_entryRelationShip_act" value="count(cda:entryRelationship/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1.3'])"/>
        
        <assert test="@classCode='PROC' and @moodCode='EVN'">
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément procedure de specimen collection doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs 'PROC' and 'EVN'
        </assert>
        <assert test="cda:effectiveTime">
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément effectiveTime doit être présent dans specimen Collection
        </assert>
        <assert test="$count_targetSiteCode &lt;=1">
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément targetSite code ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
        <assert test="$count_performer &lt;=1">
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément perfermer ne peut être présent q'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_participant =1">
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément particpant doit être présent, et une seule fois (cardinalité [1..1])
        </assert>
        <assert test="$count_participant_id=1">
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément id de participantRole doit être présent, masi qu'une seule fois (cardinalité [1..1])
        </assert>
        <!--<assert test="cda:participant/cda:participantRole/cda:playingEntity/cda:code">
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'élément participantRole/playingEntity/code doit être présent
        </assert>-->
        <assert test="$count_entryRelationShip_act &lt;=1">
            [E_specimenCollection_int.sch] Erreur de conformité PaLM : L'entryRelationShip act de templateId '1.3.6.1.4.1.19376.1.3.1.3' ne peut être présente qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
    </rule>
</pattern>
