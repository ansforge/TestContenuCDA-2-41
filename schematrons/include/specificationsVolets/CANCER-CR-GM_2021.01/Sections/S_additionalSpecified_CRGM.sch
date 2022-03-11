<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE APSR v2.0  "Additional Specified Section" (1.3.6.1.4.1.19376.1.3.10.3.1) -->

<!--                  -=<<o#%@O[ S_additionalSpecified_CRGM.sch ]O@%#o>>=-
    
    Teste la conformité de la Section "Constatation(s) pathologique(s) complémentaire(s)/Additional Specified Section" (1.3.6.1.4.1.19376.1.3.10.3.1)
    aux spécifications du volet CRGM du CI-SIS de l'ASIP Santé.
    Cette section est utilisée pour coder la rubrique 'Méthode' du compte rendu de génétique moléculaire.
    
    
    Historique :
    10/01/2019 : NNA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_additionalSpecified_CRGM">
    <title>CI-SIS CRGM Section Constatation(s) pathologique(s) complémentaire(s) </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.3.10.3.1"]'>
        
        <!-- Présence obligatoire d'une Entrée Problem Organizer  -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.3.6"]'>
            [S_additionalSpecified_CRGM.sch] Erreur de Conformité volet CRGM: Un élément entry 'Problem Organizer/ Liste d'observations' est obligatoire dans la sur-section Additional Specified Section.
        </assert> 
        
                  
    </rule>
    
</pattern>