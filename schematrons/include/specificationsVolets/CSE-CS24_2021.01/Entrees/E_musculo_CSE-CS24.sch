<?xml version="1.0" encoding="UTF-8"?>

<!--  E_musculo_CSE-CS24.sch
    
    Vérification des entrées FR-Probleme de la sous-section Système musculosquelettique du CSE-CS24
    
    Historique :
    24/06/2011 : Création
    12/10/2017 : Ajout du nom du schématron dans les messages d'erreur
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS24) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_musculo_CSE-CS24">
    <title>Vérification des entrées FR-Probleme de la sous-section Système musculosquelettique du CSE-CS24</title>
    
    <!-- ****** Contexte = sous-section Système musculosquelettique ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.34"]'>
        
        <!-- Vérifier que l'entrée 'Luxation de la hanche' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="D4-14700"'>
            [E_musculo_CSE-CS24] Erreur de conformité : 
            L'entrée FR-Probleme de code "D4-14700" est obligatoire pour indiquer l'absence ou la présence d'une 'Luxation de la hanche'.
        </assert>
        
        <!-- Vérifier que l'entrée 'Autre' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="GEN-097"'>
            [E_musculo_CSE-CS24] Erreur de conformité : 
            L'entrée FR-Probleme de code "GEN-097" est obligatoire pour indiquer l'absence ou la présence d'une autre affection du système musculosquelettique.
        </assert>
    </rule>
</pattern>

