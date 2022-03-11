<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE APSR v2.0  "Procedure Steps Section" (1.3.6.1.4.1.19376.1.8.1.2.6) -->

<!--                  -=<<o#%@O[ S_procedureSteps_CRGM.sch ]O@%#o>>=-
    
    Teste la conformité de la Section "Prélèvement/Procedure Steps Section" (1.3.6.1.4.1.19376.1.8.1.2.6)
    aux spécifications du volet CRGM du CI-SIS de l'ASIP Santé.
    Cette section est utilisée pour coder la rubrique 'Informations sur le prélèvement' du compte rendu de génétique moléculaire.
    
    
    Historique :
    10/01/2019 : NNA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_procedureSteps_CRGM">
    <title>CI-SIS CRGM Section Prélèvement </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.8.1.2.6"]'>
        
        <!-- Présence obligatoire d'une Entrée Specimen Procedure Step  -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.3.10.4.1"]'>
            [S_procedureSteps_CRGM.sch] Erreur de Conformité volet CRGM: L'Elément entry 'Specimen Procedure Step/ Entrée Prélèvement' est obligatoire dans la sur-section Procedure Steps Section.
        </assert>  
                  
    </rule>
    
</pattern>