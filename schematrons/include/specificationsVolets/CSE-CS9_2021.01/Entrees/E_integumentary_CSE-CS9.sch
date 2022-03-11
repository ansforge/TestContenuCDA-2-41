<?xml version="1.0" encoding="UTF-8"?>

<!-- E_integumentary_CSE-CS9
    
    Vérification des entrées FR-Probleme de la sous-section Système tégumentaire du CSE-CS9 
    
    Historique :
    24/06/2011 : Création
    11/10/2017 : Ajout du nom du schématron sur les messages d'erreur
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS9) et modification des messages d'erreur    
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_integumentary_CSE-CS9">
    <title>Vérification des entrées FR-Probleme de la sous-section Système tégumentaire du CSE-CS9</title>
    
    <!-- ****** Contexte = sous-section Système tégumentaire ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.17"]'>
        
        <!-- Vérifier que l'entrée 'Eczéma' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="D0-10100"'> 
            [E_integumentary_CSE-CS9] Erreur de conformité :
            L'entrée FR-Probleme de code "D0-10100" est obligatoire pour indiquer l'absence ou la présence d'eczéma.
        </assert>        
        
        <!-- Vérifier que l'entrée 'Autre' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="GEN-097"'>
            [E_integumentary_CSE-CS9] Erreur de conformité : 
            L'entrée FR-Probleme de code "GEN-097" est obligatoire pour indiquer l'absence ou la présence d'une autre anomalie du système tégumentaire.
        </assert>
        
    </rule>
</pattern>



