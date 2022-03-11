<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE APSR v2.0  "Diagnostic Conclusion Section" (1.3.6.1.4.1.19376.1.8.1.2.5) -->

<!--                  -=<<o#%@O[ S_diagnosticConclusion_CRGM.sch ]O@%#o>>=-
    
    Teste la conformité de la Section "Conclusion du diagnostic/Diagnostic Conclusion Section" (1.3.6.1.4.1.19376.1.8.1.2.5)
    aux spécifications du volet CRGM du CI-SIS de l'ASIP Santé.
    Cette section est utilisée pour coder la rubrique 'Conclusion / Interprétation des résultats en l’état actuel des connaissances' du compte rendu de génétique moléculaire.
    
    
    Historique :
    10/01/2019 : NNA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_diagnosticConclusion_CRGM">
    <title>CI-SIS CRGM Section conclusion du diagnostic </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.8.1.2.5"]'>
        
        <!-- Présence obligatoire d'une Entrée Problem Organizer  -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.3.6"]'>
            [S_diagnosticConclusion_CRGM.sch] Erreur de Conformité volet CRGM: Au moins un élément entry 'Problem Organizer/ Liste d'observations' est obligatoire dans la sur-section Diagnostic Conclusion.
        </assert> 
        
                  
    </rule>
    
</pattern>