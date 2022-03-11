<?xml version="1.0" encoding="UTF-8"?>

<!--  E_rechHbs_CSE-CS8    
    
    Historique :
    27/06/11 : CRI : Création
    22/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_rechHbs_CSE-CS8">
    <title>IHE PCC v3.0 Ears</title>
    
    <!-- ****** Contexte = aNTENATAL TESTING BATTERY ****** -->
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10"]'>
        <assert test='.//cda:observation[cda:code/@code="51659-1"]/cda:value[@code="MED-214" or @code="MED-215" or @nullFlavor]'>
            [E_rechHbs_CSE] La recherche d'Ag Hbs doit être négative, positive, ou non faite. Dans ce dernier cas, l'élément nullFlavor peut être utilisé
        </assert>
    </rule>
</pattern>