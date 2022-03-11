<?xml version="1.0" encoding="UTF-8"?>

<!--  E_heart_CSE-CS9
    
    Vérification des entrées FR-Probleme de la sous-section Système cardiovasculaire du CSE-CS9
    
    Historique :
    24/06/2011 : Création
    11/10/2017 : Ajout du nom du schématron sur les messages d'erreur
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS9) et modification des messages d'erreur   
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_heart_CSE-CS9">
    <title>Vérification des entrées FR-Probleme de la sous-section Système cardiovasculaire du CSE-CS9</title>
    
    <!-- ****** Contexte = sous-section Système cardiovasculaire ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.29"]'>
        
        <!-- Vérifier que l'entrée 'Cardiopathie congénitale' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="MED-271"'>
            [E_heart_CSE-CS9] Erreur de conformité : 
            L'entrée FR-Probleme de code "MED-271" est obligatoire pour indiquer l'absence ou la présence d'une 'Cardiopathie congénitale'.
        </assert>
        
        <!-- Observation: autre pathologie -->
        <assert test='(.//cda:entry/cda:observation/cda:value/@code="GEN-097")'>
            [E_heart_CSE-CS9] Erreur de conformité : 
            L'absence ou la présence d'une autre affection du système cardiovasculaire est obligatoire.
        </assert>
        
    </rule>
</pattern>
