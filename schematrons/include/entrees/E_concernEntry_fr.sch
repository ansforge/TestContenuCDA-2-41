<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_concernEntry_fr.sch ]O@%#o>>=-
    
    Teste les entrées de la section PCC Concern Entry (1.3.6.1.4.1.19376.1.5.3.1.4.5.1)
    
    26/06/17 : NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_concernEntry_fr">
    <title>CI-SIS Concern Entry</title>
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5.1"]'>

            <assert test="not(cda:author) or (cda:author/cda:assignedAuthor/cda:id and cda:author/cda:assignedAuthor/cda:addr and cda:author/cda:assignedAuthor/cda:telecom and cda:author/cda:assignedAuthor/cda:assignedPerson/cda:name and cda:author/cda:assignedAuthor/cda:representedOrganization/cda:name)">
                [E_concernEntry_fr] Erreur de conformité CI-SIS : si l'élément author est présent, il doit contenir l'élément assignedAuthor qui devra contenir les éléments: id, addr, telecom, assignedPerson (name) et representedOrganization (name)
            </assert>

        </rule>
    </pattern>