<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE APSR v2.0  "Clinical Information Section" (1.3.6.1.4.1.19376.1.8.1.2.1) -->

<!--                  -=<<o#%@O[ S_clinicalInformation_CRGM.sch ]O@%#o>>=-
    
    Teste la conformité de la Section "Informations cliniques/ Clinical Informations" (1.3.6.1.4.1.19376.1.8.1.2.1)
    aux spécifications du volet CRGM du CI-SIS de l'ASIP Santé.
    Cette section est utilisée pour coder la rubrique 'Demande d’examen et Motif de l’analyse' du compte rendu de génétique moléculaire.
    
    
    Historique :
    10/01/2019 : NNA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_clinicalInformation_CRGM">
    <title>CI-SIS CRGM Section Informations cliniques </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.8.1.2.1"]'>
        
        <!-- Présence obligatoire d'une Entrée Problem Organizer  -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.3.6"]'>
            [S_clinicalInformation_CRGM.sch] Erreur de Conformité volet CRGM: L'Elément entry 'Problem Organizer/ Liste d'observations' est obligatoire dans la sur-section Informations Cliniques/ Clinical Informations.
        </assert>  

        <!-- Présence obligatoire de la section IHE Reason for Referral/ Raison de la recommandation -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.1"]'>
            [S_clinicalInformation_CRGM.sch] Erreur de Conformité volet CRGM: La  section 'Reason for Referral/ Raison de la recommandation' est obligatoire dans la sur-section Informations Cliniques/ Clinical Informations.
        </assert>  
                  
    </rule>
    
</pattern>