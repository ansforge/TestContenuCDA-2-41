<?xml version="1.0" encoding="UTF-8"?>

<!-- S_laboratorySpecialty.sch
    
    Teste la conformité de la section FR-CR-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.1) aux spécifications d'IHE
    
    Historique :
    22/10/2013 : Création
    04/07/2017 : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : Suppression du test sur le nombre de templateId 
    13/01/2021 : Mise à jour pour version 2021.01
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_laboratorySpecialty">

    <title>Vérification de la conformité de la section FR-CR-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.1)</title>
    
    <rule context='*[cda:templateId/@root = "1.3.6.1.4.1.19376.1.3.3.2.1"]'>
        
        <assert test="(cda:text and count(cda:entry) = 1 and not(cda:component)) or
            (not(cda:text) and not(cda:entry) and count(cda:component) &gt; 0)">
            [S_laboratorySpecialty] Erreur de conformité : 
            Une section FR-CR-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.1) doit comporter soit un élément text et un seul élément entry soit des sections de niveau 2. 
        </assert>
 
    </rule>

</pattern>
