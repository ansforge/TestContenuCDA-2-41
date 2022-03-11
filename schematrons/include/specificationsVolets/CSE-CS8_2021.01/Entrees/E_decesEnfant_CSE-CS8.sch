<?xml version="1.0" encoding="UTF-8"?>

<!--  E_decesEnfant_CSE-CS8.sch
    
    Vérification de l'entrée FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13) de la sous-section FR-Resultats-evenements (1.3.6.1.4.1.19376.1.7.3.1.1.13.7)  du CSE-CS8
    
    Historique :
    01/06/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_decesEnfant_CSE-CS8">
    <title>Vérification de l'entrée FR-Simple-Observation de la sous-section FR-Resultats-evenements du CSE-CS8</title>
    
    <!-- ****** Contexte = sous-section FR-Resultats-evenements ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.21.2.4"]//cda:section[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]'>
        
        <!-- Vérifier le code de l'entrée FR-Simple-Observation-->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-173"'>
            [E_decesEnfant_CSE-CS8] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-173" est obligatoire pour indiquer le décès de l'enfant.
        </assert>
        
    </rule>
</pattern>

