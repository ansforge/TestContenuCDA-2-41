<?xml version="1.0" encoding="UTF-8"?>

<!-- E_neurologic_CSE-CS8
    
    Vérification des entrées FR-Probleme de la sous-section Système nerveux du CSE-CS8 
    
    Historique :
    24/06/2011 : Création
    22/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    15/05/2018 : MAJ par rapport à la maj du volet
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS8) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_neurologic_CSE-CS8">
    <title>Vérification des entrées FR-Probleme de la sous-section Système nerveux du CSE-CS8</title>
    
    <!-- ****** Contexte = sous-section Système nerveux ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.35"]'>
        
        <!-- Vérifier que l'entrée 'Anomalies du tube neural' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="MED-176"'>
            [E_neurologic_CSE-CS8] Erreur de conformité : L'entrée FR-Probleme de code "MED-176" est obligatoire pour indiquer l'absence ou la présence d'une 'Anomalies du tube neural'.
        </assert>
        
        <!-- Vérifier que l'entrée 'Hydrocéphalie' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="D4-91300"'>
            [E_neurologic_CSE-CS8] Erreur de conformité : L'entrée FR-Probleme de code "D4-91300" est obligatoire pour indiquer l'absence ou la présence d'une 'Hydrocéphalie'.
        </assert>        
        
    </rule>
    
</pattern>




