<?xml version="1.0" encoding="UTF-8"?>

<!--  E_respiratory_CSE-CS24.sch
    
    Vérification des entrées FR-Probleme de la sous-section Système respiratoire du CSE-CS24
    
    Historique :
    24/06/11 : CRI : Création
    25/07/11 : CRI : Extension aux volets CS9 et CS24
    12/10/17 : NMA : Ajout du nom du schématron sur les messages d'erreur
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS24) et modification des messages d'erreur 
    30/08/2021 : Suppression du [@negationInd] dans cda:observation[@negationInd] qui n'est pas obligatoire dans l'observation 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_respiratory_CSE-CS24">
    <title>Vérification des entrées FR-Probleme de la sous-section Système respiratoire du CSE-CS24</title>
    
    <!-- ****** Contexte = sous-section Système respiratoire ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.30"]'>
        
        <!-- Observation: Mucoviscidose -->
        <assert test='(.//cda:entry/cda:observation/cda:value/@code="D6-94800")'>
            [E_respiratory_CSE-CS24] Erreur de conformité : 
            L'entrée FR-Probleme de code "D6-94800" est obligatoire pour indiquer l'absence ou la présence de Mucoviscidose.
        </assert>
        
        <!-- Observation: Asthme -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:value/@code="D2-51000")'>
            [E_respiratory_CSE-CS24] Erreur de conformité : 
            L'entrée FR-Probleme de code "D2-51000" est obligatoire pour indiquer l'absence ou la présence d'Asthme.
        </assert>
        
        <!-- Observation: autre pathologie -->
        <assert test='(.//cda:entry/cda:observation/cda:value/@code="GEN-097")'>
            [E_respiratory_CSE-CS24] Erreur de conformité : 
            L'absence ou la présence d'une autre affection du système respiratoire est obligatoire.
        </assert>
    </rule>
</pattern>