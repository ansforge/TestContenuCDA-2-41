<?xml version="1.0" encoding="UTF-8"?>

<!--                 
    E_vitalSignsOrganizer_int
   Teste la conformité de l'entrée Vital Signs Organizer en fonctionn de la conformité IHE-PCC
   
   20/06/2017 : LBE :Création
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_bloodTypeObservation_fr">
    <title>IHE PCC v3.0 vital signs Organizer</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.6']">
        <let name="count_id" value="count(cda:id)"/>
        <let name="count_value" value="count(cda:value)"/>
        <assert test="$count_id=1">
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un seul élément id (cardinalité [1..1])
        </assert>
        <assert test="cda:code[@displayName='ABO+RH' and @codeSystemName='LOINC']">
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un élément code avec les attributs @displayName ='ABO+RH' et @codeSystemName='LOINC'
        </assert>
        <assert test="cda:text/cda:reference">
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un élément text, lui même contenant un élément référence
        </assert>
        <assert test="cda:statusCode[@code='completed']">
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un élément statusCode fixé à la valeur @code='completed'
        </assert>
        <!-- Pas besoin de tester l'effectiveTime car cela est déja testé dans le schématron de Simple Observation -->
        <assert test="$count_value=1">
            [E_bloodTypeObservation_fr.sch] Erreur de conformité CI-SIS : L'élément bloodTypeObservation doit contenir un seul élément value (cardinalité [1..1])
        </assert>
    </rule>    
</pattern>

