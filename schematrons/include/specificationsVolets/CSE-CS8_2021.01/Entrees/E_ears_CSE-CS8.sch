<?xml version="1.0" encoding="UTF-8"?>

<!-- E_ears_CSE-CS8.sch
    
    Vérification des entrées FR-Probleme de la sous-section Système auditif du CSE-CS8
    
    Historique :
    27/06/2011 : Création
    21/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP    
    15/05/2018 : NMA : imiter le test de l'examen auditif aux CSE9 et CSE24
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS8) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_ears_CSE-CS8">
    <title>Vérification des entrées FR-Probleme de la sous-section Système auditif du CSE-CS8</title>
    
    <!-- ****** Contexte = sous-section Système auditif ****** -->
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.21"]'>
        
        <!-- Vérifier que l'entrée 'Audition à surveiller' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="MED-179"'>
            [E_ears_CSE-CS8] Erreur de conformité : L'entrée FR-Probleme de code "MED-179" est obligatoire pour indiquer si 'Audition à surveiller' ou pas.
        </assert>
    </rule>
</pattern>
