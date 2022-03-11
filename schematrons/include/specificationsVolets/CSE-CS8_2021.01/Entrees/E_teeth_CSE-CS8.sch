<?xml version="1.0" encoding="UTF-8"?>

<!-- E_teeth_CSE-CS8.sch
    
    Vérification des entrées FR-Probleme de la sous-section Stomatologie du CSE-CS8 
    
    Historique :
    24/06/2011 : Création
    12/10/2017 : Ajout du nom du schématron sur les messages d'erreur
    22/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS8) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_teeth_CSE-CS8">
    <title>Vérification des entrées FR-Probleme de la sous-section Stomatologie du CSE-CS8</title>
    
    <!-- ****** Contexte = sous-section Stomatologie ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.23"]'>
        
        <!-- Vérifier que l'entrée 'Fente (labio-) palatine' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="D4-51450"'>
            [E_teeth_CSE-CS8] Erreur de conformité : L'entrée FR-Probleme de code "D4-51450" est obligatoire pour indiquer l'absence ou la présence d'une 'Fente (labio-) palatine'.
        </assert>
        
    </rule>
</pattern>



