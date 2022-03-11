<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_pregnancyHistoryOrganizer_fr.sch ]O@%#o>>=-
    
    Teste la conformité des entrées de la section "Pregnancy History Organizer" (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4)
    aux spécifications du CI-SIS
    
    Historique :
    30/06/17 : NMA : Création E_pregnancyHistoryOrganizer_fr.sch
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_pregnancyHistoryOrganizer_fr">
    <title>CI-SIS Pregnancy History Organizer</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1"]'>
        
        <assert test="count(cda:code[@codeSystem='1.2.250.1.213.2.12'])=1">
            [E_pregnancyHistoryOrganizer_fr] : Erreur de conformité CI-SIS : Il doit y avoir un seul élément code et il doit être codé en SNOMED 3.5 (1.2.250.1.213.2.12)
        </assert>

    </rule>
</pattern>