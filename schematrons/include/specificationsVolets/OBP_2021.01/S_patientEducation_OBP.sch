<?xml version="1.0" encoding="UTF-8"?>

<!-- S_patientEducation_OBP.sch
    
    Teste la conformité des entrées pour la section FR-Education-du-patient dans le volet OBP
    
    Historique :
    25/07/11 : Création
    25/10/17 : Renommage du schématron en S_patientEducationAndConsents_OBP
    25/01/22 : Renommage du schématron en S_patientEducation_OBP
    25/01/22 : remplacement de l'entrée de type procedure par une entrée de type observation
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_patientEducation_OBP">
    <title>Vérification de la section FR-Education-du-patient</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.39"]'>
        <assert test='(.//cda:entry/cda:observation/cda:code[@code="MED-163"])'>
            [S_patientEducation_OBP] La section doit comporter un élément 'Préparation à la naissance' (MED-163).        
        </assert>
        <assert test='(.//cda:entry/cda:observation/cda:code[@code="OBS_009"])'>
            [S_patientEducation_OBP] La section doit comporter un élément 
            'Consultation auprès d'un centre de diagnostic prénatal' (OBS_009).        
        </assert>
        
    </rule>
</pattern>

