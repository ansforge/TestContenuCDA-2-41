<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_vitalSignsOrganizer_fr.sch ]O@%#o>>=-
    
    Teste l'entrée "vital Signs Organizer" (1.3.6.1.4.1.19376.1.5.3.1.4.13.1)

    25/07/11 : CRI : Création
    19/06/2017 : LBE : Ajout de la vérification de l'élément texte et des indications : [E_simpleObservation_int.sch]
                       modification de l'id du pattern (au même nom que le nom du schématorn)
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_vitalSignsOrganizer_fr">
    <title>Modèle de Contenu CDA vital signs Organizer</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.1']">
        <let name="count_id" value="count(cda:id)"/>
        <assert test="$count_id=1">
            [E_vitalSignsOrganizer_fr] : Erreur de conformité CI-SIS : L'élément id ne peut être présent qu'une seule (cardinalité [1..1])
        </assert>
        <assert test="cda:code[(@code='F-03400' and @codeSystem='1.2.250.1.213.2.12') or (@code='85353-1' and @codeSystem='2.16.840.1.113883.6.1')]">
           [E_vitalSignsOrganizer_fr] : Erreur de conformité CI-SIS : L'élément code doit avoir les attributs suivants : 
           •	code='F-03400' et codeSystem=1.2.250.1.213.2.12 (SNOMED 3.5) ou
           •	code='85353-1' et codeSystem=2.16.840.1.113883.6.1 (LOINC)
           
       </assert>
    </rule>
    
    
</pattern>

