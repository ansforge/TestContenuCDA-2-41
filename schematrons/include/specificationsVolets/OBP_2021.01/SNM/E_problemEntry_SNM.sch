<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[E_problemEntry_SNM.sch ]O@%#o>>=-
    
    Teste la conformité des valeurs de l'entrée "Problem Entry" (1.3.6.1.4.1.19376.1.5.3.1.4.5)
    dans le contexte du volet OBP/SNM
    
    Historique :
    25/07/11 : CRI : Création
    25/10/17 : NMA : Renommage du schématron
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_problemEntry_SNM">
    <title>IHE PCC v3.0 Problem Entry</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6']">
        <assert
            test="cda:entry/cda:act/cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:value[
            @code='D8-12200' or
            @code='D8-22120' or
            @code='F-88450' or
            @code='OBS_002' or
            @code='OBS_205' or
            @code='OBS_206' or
            @code='XX-MCH170' or
            @code='XX-MCH171'
            ]">
            [E_problemEntry_SNM]: Les valeurs possibles pour cet éléments sont
            contenues dans le jeu de valeurs 'SAP_MotifDeclenchementTravail'</assert>
    </rule>
</pattern>
