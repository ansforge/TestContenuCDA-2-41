<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE APSR v2.0  "Macroscopic Observation Section" (1.3.6.1.4.1.19376.1.8.1.2.3) -->

<!--                  -=<<o#%@O[ S_macroscopicObservation_CRGM.sch ]O@%#o>>=-
    
    Teste la conformité de la Section "Observation macroscopique/Macroscopic Observation Section" (1.3.6.1.4.1.19376.1.8.1.2.3)
    aux spécifications du volet CRGM du CI-SIS de l'ASIP Santé.
    Cette section est utilisée pour coder la rubrique 'Renseignements anatomo- cyto-pathologiques du prélèvement' du compte rendu de génétique moléculaire.
    
    
    Historique :
    10/01/2019 : NNA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_macroscopicObservation_CRGM">
    <title>CI-SIS CRGM Section Observation macroscopique </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.8.1.2.3"]'>
        
        <!-- Présence obligatoire d'une Entrée Problem Organizer  -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.3.6"]'>
            [S_macroscopicObservation_CRGM.sch] Erreur de Conformité volet CRGM: Un élément entry 'Problem Organizer/ Liste d'observations' est obligatoire dans la sur-section Observation macroscopique/Macroscopic Observation Section.
        </assert>  
        
        <!-- Présence obligatoire d'au moins un préleveur  -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.3.6"]/../cda:performer[@typeCode="PRF"]'>
            [S_macroscopicObservation_CRGM.sch] Erreur de conformité au Volet CRGM : Au minimum un élément "performer" doit être présent avec un typeCode='PRF'.
        </assert>
                  
    </rule>
    
</pattern>