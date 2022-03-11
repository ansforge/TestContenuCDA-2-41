<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    inFulfillementOf_fr.sch :
    Contenu :
        test la conformité du inFulfillementOf dans l'entête en fonction de la conformité du volet de structuration minimale
    Paramètres d'appel :
        Néant
    Historique :
        19/06/2017 : LBE : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="inFulfillmentOf_fr">
    <rule context="cda:inFulfillmentOf/cda:order">
        <let name="count_id" value="count(cda:id)"/>
        <assert test="$count_id=1">
            [inFulfillementOf_fr.sch] Erreur de conformité CI-SIS : L'élément id ne doit être présent qu'une fois (cardinalité [1..1])
        </assert>
        <assert test="cda:id[@root]">
            [inFulfillementOf_fr.sch] Erreur de conformité CI-SIS : L'élément id doit contenir un attribut @root
        </assert>
    </rule>
</pattern>
