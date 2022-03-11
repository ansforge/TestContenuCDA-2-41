<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    E_mesuresDispositifsOculairesObservation_int
   Teste la conformité de l'entrée mesures de dispositifs oculaires Observation en fonctionn de la conformité IHE-IHE EYE CARE (GEE)
    
    Historique :
    31/05/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_mesuresDispositifsOculairesObservation_int">
    
    <title>IHE IHE EYE CARE (GEE) v3.0 Lensometry Measurement Observations</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.12.1.3.9"]'>
        
        <assert test="self::cda:observation[@classCode = 'OBS' and @moodCode = 'EVN']">
            [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) : l'élément "mesures de dispositifs oculaires Observation"
            doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs
            'OBS' et 'EVN'
        </assert>
        
        <assert test="count(cda:id)&lt;=1"> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement Id 
        </assert>
        
        <assert test="cda:statusCode[@code = 'completed']"> [E_mesuresDispositifsOculairesObservation_int]
            Erreur de Conformité IHE EYE CARE (GEE) : l'élément "mesures de dispositifs oculaires Observation" doit contenir l'élément statusCode avec
            l'attribut @code fixé à 'completed'
        </assert>
        
        <assert test="cda:effectiveTime[@value] or cda:effectiveTime[@nullFlavor]">
            [E_mesuresDispositifsOculairesObservation_int] Erreur de conformité IHE EYE CARE (GEE) : l'élément 'effectiveTime' doit être présent.
        </assert>
        
        <assert test="cda:value"> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement value 
        </assert>
        
        <assert test="cda:targetSiteCode[@nullFlavor or @code='MED-976']"> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement targetSiteCode avec l'attribut @nullFlavor ou @code 'MED-976' 
        </assert>
        
        <assert test="cda:methodCode"> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement methodCode 
        </assert>
        
        <assert test="count(cda:author)&lt;=1"> [E_mesuresDispositifsOculairesObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesures de dispositifs oculaires Observation" doit contenir un élement author 
        </assert>
        
    </rule>
    
</pattern>
