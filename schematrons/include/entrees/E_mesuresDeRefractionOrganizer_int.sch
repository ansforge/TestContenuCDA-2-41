<?xml version="1.0" encoding="UTF-8"?>

<!--                 
    E_mesuresDeRefractionOrganizer_int
   Teste la conformité de l'entrée FR-Liste-des-mesures-de-refraction aux spécifications IHE EYE CARE GEE
   
   27/05/2021 : Création
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_mesuresDeRefractionOrganizer_int">
    <title>Vérification de la conformité de l'entrée FR-Liste-des-mesures-de-refraction aux
        spécifications IHE EYE CARE GEE</title>
    <rule context="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.3']">

        <assert test="self::cda:organizer[@classCode = 'CLUSTER' and @moodCode = 'EVN']">
            [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'élément "organizer" doit
            contenir les attributs @classCode="CLUSTER" et @moodCode="EVN". </assert>
        
        <assert test="cda:templateId[@root = '1.3.6.1.4.1.19376.1.12.1.3.3']">
            [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée
            FR-Liste-des-mesures-de-refraction doit contenir l'élément "templateId" avec l'attribut
            @root fixé à "1.3.6.1.4.1.19376.1.12.1.3.3". </assert>

        <assert test="cda:code[@code = '70938-6' and @codeSystem = '2.16.840.1.113883.6.1']">
            [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée
            FR-Liste-des-mesures-de-refraction doit contenir l'élément "code" avec les attributs
            @code="70938-6" et @codeSystem="2.16.840.1.113883.6.1".</assert>

        <assert test="cda:statusCode[@code = 'completed']"> [E_mesuresDeRefractionOrganizer_int]
            Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-refraction doit contenir
            l'élément "statusCode" avec l'attribut @code fixé à "completed".</assert>

        <assert test="cda:effectiveTime[@value] or cda:effectiveTime[@nullFlavor]">
            [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée
            FR-Liste-des-mesures-de-refraction doit contenir un élément "effectiveTime" avec
            l'attribut @value.</assert>

        <assert
            test="count(.//cda:observation[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.7']) &gt;= 1"
            > [E_mesuresDeRefractionOrganizer_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée
            FR-Liste-des-mesures-de-refraction doit contenir au minimum une entrée FR-Mesure-de-refraction (1.3.6.1.4.1.19376.1.12.1.3.7).</assert>

    </rule>
</pattern>
