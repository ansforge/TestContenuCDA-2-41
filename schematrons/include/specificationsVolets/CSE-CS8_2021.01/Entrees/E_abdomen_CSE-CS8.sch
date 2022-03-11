<?xml version="1.0" encoding="UTF-8"?>


<!--  E_abdomen_CSE-CS8.sch
    
    Vérification des entrées FR-Probleme de la sous-section Système digestif du CSE-CS8
    
    Historique :
    27/06/2011 : Création
    25/07/2011 : Ajout des éléments cliniques des volets CS8, CS9 et CS24
    22/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS8) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_abdomen_CSE-CS8">
    <title>Vérification des entrées FR-Probleme de la sous-section Système digestif du CSE-CS8</title>
    
    <!-- ****** Contexte = sous-section Système digestif ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.31"]'>
        
        <!-- Vérifier que l'entrée 'Atrésie de l'oesophage' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="D4-55002"'>
            [E_abdomen_CSE-CS8] Erreur de conformité : L'entrée FR-Probleme de code "D4-55002" est obligatoire pour indiquer l'absence ou la présence d'atrésie de l'oesophage.
        </assert>
        
        <!-- Vérifier que l'entrée 'Omphalocèle, Gastroschisis' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="MED-177"'>
            [E_abdomen_CSE-CS8] Erreur de conformité : L'entrée FR-Probleme de code "MED-177" est obligatoire pour indiquer l'absence ou la présence de Gastroschisis/Omphalocèle.
        </assert>
        
    </rule>
</pattern>

