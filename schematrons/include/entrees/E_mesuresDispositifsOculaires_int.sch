<?xml version="1.0" encoding="UTF-8"?>

<!--                 
    E_mesuresDispositifsOculaires_int
   Teste la conformité de l'entrée FR-Liste-des-mesures-de-dispositifs-oculaires aux spécifications IHE EYE CARE (GEE)
   
   01/06/2021 : Création
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_mesuresDispositifsOculaires_int">
    <title>Vérification de la conformité de l'entrée FR-Liste-des-mesures-de-dispositifs-oculaires aux spécifications IHE EYE CARE (GEE)</title>
    <rule context="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.5']">

        <assert test="self::cda:organizer[@classCode = 'CLUSTER' and @moodCode = 'EVN']">
            [E_mesuresDispositifsOculaires_int] Erreur de conformité : L'élément "organizer"
            doit contenir les attributs @classCode="CLUSTER" et @moodCode="EVN". 
        </assert>
        
        <assert test="cda:templateId[@root = '1.3.6.1.4.1.19376.1.12.1.3.5']">
            [E_mesuresDispositifsOculaires_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires
            doit contenir l'élément "templateId" avec l'attribut @root fixé à
            "1.3.6.1.4.1.19376.1.12.1.3.5". 
        </assert>

        <assert test="count(cda:id)&lt;=1"> [E_mesuresDispositifsOculaires_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires doit contenur un élement "id". 
        </assert>

        <assert
            test="cda:code">
            [E_mesuresDispositifsOculaires_int] Erreur de conformité : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires
            doit contenir un élément "code".
        </assert>

        <assert test="cda:statusCode[@code = 'completed']"> [E_mesuresDispositifsOculaires_int]
            Erreur de conformité IHE EYE CARE (GEE): L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires doit contenir l'élément "statusCode" avec
            l'attribut @code fixé à 'completed'.
        </assert>

        <assert test="cda:effectiveTime[@value]"> [E_mesuresDispositifsOculaires_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires doit contenir un élément "effectiveTime" avec
            l'attribut @value
        </assert>

        <assert test="count(.//cda:observation[cda:templateId/@root = '1.3.6.1.4.1.19376.1.12.1.3.9'])&gt;=1">
            [E_mesuresDispositifsOculaires_int] Erreur de conformité IHE EYE CARE (GEE) : L'entrée FR-Liste-des-mesures-de-dispositifs-oculaires
            doit contenir au minimum une entrée FR-Mesure-dispositif-oculaire (1.3.6.1.4.1.19376.1.12.1.3.9).
        </assert>
        
    </rule>
</pattern>
