<?xml version="1.0" encoding="UTF-8"?>
<!--                  -=<<o#%@O[ E_familyHistoryObservation_fr.sch ]O@%#o>>=-
    
    Teste la conformité de l'élément "Family History Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.13.3)
    aux spécifications du CI-SIS
    
    Historique :
    30/06/17 : NMA : Création
    24/01/18 : NMA : Suppression du test sur le codeSystem de la value
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_familyHistoryObservation_fr">
    <title>CI-SIS Family History Observation</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.3"]'>

        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [E_familyHistoryObservation_fr] Erreur de conformité CI-SIS : Dans l'élément "Family History Observation", 
            les attributs de l'élément CDA 'observation' sont classCode='OBS' et moodCode='EVN'</assert>

        <assert test='count(cda:id)=1'>
            [E_familyHistoryObservation_fr] : Erreur de conformité CI-SIS : L'élément id est obligatoirement présent une fois.
        </assert>

        <assert test='count(cda:code)=1'>
            [E_familyHistoryObservation_fr] : Erreur de conformité CI-SIS : L'élément code doit être présent une fois.
        </assert>

        <assert test="cda:statusCode[@code='completed']"> 
            [E_familyHistoryObservation_fr] : Erreur de conformité CI-SIS : Le composant "statutCode" d'une "Family History Observation"
            est toujours fixé à la valeur code='completed'. </assert>

        <assert test='count(cda:effectiveTime)=1'>
            [E_familyHistoryObservation_fr] : Erreur de conformité CI-SIS : L'élément effectiveTime doit être présent une fois.
        </assert>

<!--        <assert test='cda:value[@xsi:type="CD" and @codeSystem="2.16.840.1.113883.6.3"]'>
            [E_familyHistoryObservation_fr] : L'élément value doit être de type xsi:type="CD" et doit être codé en CIM-10.
        </assert>-->

        <assert test="count(cda:interpretationCode)&lt;2">
            [E_familyHistoryObservation_fr] : L'élément interpretationCode ne doit pas être présent plus d'une fois.
        </assert>

        <assert test="count(cda:methodCode)&lt;2">
            [E_familyHistoryObservation_fr] : L'élément methodCode ne doit pas être présent plus d'une fois.
        </assert>

        <assert test="count(cda:targetSiteCode)&lt;2">
            [E_familyHistoryObservation_fr] : L'élément targetSiteCode ne doit pas être présent plus d'une fois.
        </assert>

        <assert test="count(cda:author)&lt;2">
            [E_familyHistoryObservation_fr] : L'élément author ne doit pas être présent plus d'une fois.
        </assert>

    </rule>

</pattern>