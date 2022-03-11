<?xml version="1.0" encoding="UTF-8"?>

<!-- E_lymphatic_CSE-CS24
    
    Vérification des entrées FR-Probleme de la sous-section Système lymphatique-hématologique-immunologique du CSE-CS24
    
    Historique :
    24/06/2011 : Création
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS24) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_lymphatic_CSE-CS24">
    <title>Vérification des entrées FR-Probleme de la sous-section Système lymphatique-hématologique-immunologique du CSE-CS24</title>
    
    <!-- ****** Contexte = sous-section Système lymphatique-hématologique-immunologique ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.32"]'>
        
        <!-- Observation: Maladie de l'hémoglobine -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="DC-20000"'> 
            [E_lymphatic_CSE-CS24] Erreur de conformité : 
            L'entrée FR-Probleme de code "DC-20000" est obligatoire pour indiquer l'absence ou la présence de maladie de l'hémoglobine.
        </assert>
        
        <!-- Vérifier que l'entrée 'Autre pathologie' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="GEN-097"'>
            [E_lymphatic_CSE-CS24] Erreur de conformité : 
            L'entrée FR-Probleme de code "GEN-097" est obligatoire pour indiquer l'absence ou la présence d'une autre affection du système lymphatique.
        </assert>
        
    </rule>
</pattern>
