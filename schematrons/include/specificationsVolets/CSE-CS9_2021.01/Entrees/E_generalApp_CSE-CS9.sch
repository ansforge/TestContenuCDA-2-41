<?xml version="1.0" encoding="UTF-8"?>

<!-- E_generalApp_CSE-CS9.sch
    
    Vérification des entrées FR-Probleme de la sous-section Etat général du CSE-CS9
    
    Historique :
    24/06/2011 : Création
    22/05/2015 : Mise à jour du code pour l'élément Autre pathologie (CSE-070 à la place de XX-MCH207)
    11/10/2017 : Ajout du nom du schématron sur les messages d'erreur
    22/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS9) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_generalApp_CSE-CS9">
    <title>Vérification des entrées FR-Probleme de la sous-section Etat général du CSE-CS9</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.16"]'>       
        
        <!-- Vérifier que l'entrée 'Syndrome polymalformatif' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="D4-0100"'>
            [E_generalApp_CSE-CS9] Erreur de conformité : L'entrée FR-Probleme de code "D4-0100" est obligatoire pour indiquer l'absence ou la présence de Syndrome polymalformatif.
        </assert>
        
        <!-- Vérifier que l'entrée 'Trisomie 21' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="D4-02214"'>
            [E_generalApp_CSE-CS9] Erreur de conformité : L'entrée FR-Probleme de code "D4-02214" est obligatoire pour indiquer l'absence ou la présence de trisomie 21.
        </assert>
        
        <!-- Vérifier que l'entrée 'Aberrations chromosomiques' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="D4-02000"'>
            [E_generalApp_CSE-CS9] Erreur de conformité : L'entrée FR-Probleme de code "D4-02000" est obligatoire pour indiquer l'absence ou la présence d'Aberrations chromosomiques.
        </assert>
        
        <!-- Vérifier que l'entrée 'Autre' est présente -->
        <assert test='.//cda:entry/cda:observation/cda:value/@code="GEN-097"'>
            [E_generalApp_CSE-CS9] Erreur de conformité : 
            L'entrée FR-Probleme de code "GEN-097" est obligatoire pour indiquer l'absence ou la présence d'une autre anomalie.
        </assert>
        
    </rule>
</pattern>