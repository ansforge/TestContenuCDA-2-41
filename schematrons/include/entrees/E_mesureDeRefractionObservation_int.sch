<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    E_mesureDeRefractionObservation_int
   Teste la conformité de l'entrée mesure de refraction Observation en fonctionn de la conformité IHE-PCC
    
    Historique :
    31/05/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_mesureDeRefractionObservation_int">
    
    <title>IHE PCC v3.0 Refractive Measurement Observations</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.12.1.3.7"]'>
        
        <!-- Verifier que le templateId parent de l'observation est présent. --> 
        <assert test='cda:templateId[@root = "1.3.6.1.4.1.19376.1.12.1.3.7"]'> 
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'identifiant du template parent (1.3.6.1.4.1.19376.1.12.1.3.7) doit être présent. 
        </assert>
        
        <assert test="self::cda:observation[@classCode = 'OBS' and @moodCode = 'EVN']">
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :l'élément "mesure de refraction Observation"
            doit contenir les attributs @classCode et @moodCode fixés respectivement aux valeurs
            'OBS' et 'EVN'
        </assert>
        
        <assert test="count(cda:id)&lt;=1">
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir un élement Id 
        </assert>
        
        <assert test="cda:statusCode[@code = 'completed']">
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir l'élément statusCode avec l'attribut @code fixé à 'completed'
        </assert>
            
        <assert test="cda:effectiveTime">
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément 'effectiveTime' doit être présent.
        </assert>
        
        <assert test="cda:value">
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir un élement value 
        </assert>
        
        <assert test="cda:targetSiteCode">
            [E_mesureDeRefractionObservation_int]  Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir un élement targetSiteCode 
        </assert>
        
        <assert test="cda:methodCode">
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" doit contenir un élement methodCode 
        </assert>
        
        <assert test="count(cda:author)&lt;=1">
            [E_mesureDeRefractionObservation_int] Erreur de Conformité IHE EYE CARE (GEE) :
            l'élément "mesure de refraction Observation" peut contenir un élement author [0..1].
        </assert>
        
    </rule>
    
</pattern>
