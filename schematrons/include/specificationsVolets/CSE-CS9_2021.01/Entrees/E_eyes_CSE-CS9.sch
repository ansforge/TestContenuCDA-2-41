<?xml version="1.0" encoding="UTF-8"?>

<!--  E_eyes_CSE-CS9.sch
    
    Vérification des entrées FR-Probleme de la sous-section Système occulaire du CSE-CS9
    
    Historique :
    24/06/11 : CRI : Création
    11/10/17 : NMA : Ajout du nom du schématron sur le message d'erreur
    22/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS9) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_eyes_CSE-CS9">
    <title>Vérification des entrées FR-Probleme de la sous-section Système occulaire du CSE-CS9</title>
    
    <!-- ****** Contexte = sous-section Système occulaire ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.19"]'>
        
        <!-- Vérifier que l'entrée 'Examen de l'oeil normal' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="MED-187"'> 
            [E_eyes_CSE-CS9] Erreur de conformité : 
            L'entrée FR-Probleme de code "MED-187" est obligatoire pour indiquer si l'Examen de l'oeil est normal ou pas.
        </assert>
    </rule>
</pattern>


