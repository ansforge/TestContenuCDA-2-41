<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE APSR v2.0  "Intraoperative Observation Section" (1.3.6.1.4.1.19376.1.8.1.2.2) -->

<!--                  -=<<o#%@O[ S_intraoperativeObservation_CRGM.sch ]O@%#o>>=-
    
    Teste la conformité de la Section "observation intraoperative/Intraoperative Observation Section" (1.3.6.1.4.1.19376.1.8.1.2.2)
    aux spécifications du volet CRGM du CI-SIS de l'ASIP Santé.
    Cette section est utilisée pour coder la rubrique 'Résultats' du compte rendu de génétique moléculaire.
    
    
    Historique :
    10/01/2019 : NNA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_intraoperativeObservation_CRGM">
    <title>CI-SIS CRGM Section Observation intraoperative </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.8.1.2.2"]'>
        
        <!--Présence obligatoire d'une Entrée Problem Organizer 
        <assert test='.//cda:templateId[@code = "75326-9"]//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.4.9"]'>
            [S_intraoperativeObservation_CRGM.sch] Erreur de Conformité volet CRGM: Une sous entrée de type 'AP observation (1.3.6.1.4.1.19376.1.8.1.4.9)' est obligatoire pour coder un gène sous l'Entrée Problem Organizer.
        </assert>  
        -->
                  
    </rule>
    
</pattern>