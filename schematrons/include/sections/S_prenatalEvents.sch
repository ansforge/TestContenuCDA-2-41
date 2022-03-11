<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_prenatalEvents.sch ]O@%#o>>=-
    
    Teste la conformité de la section " Prenatal Events" (1.3.6.1.4.1.19376.1.5.3.1.1.21.2.2)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/07/11 : CRI : Création
    14/11/16 : NMA : Enlever le test de présence de l'entrée Coded Results
     03/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_prenatalEvents">
    
    <title>IHE PCC v3.0 Prenatal Events Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.21.2.2"]'> 
        
        <!-- Verifier que le templateId est utilisé correctement -->        
        <assert test='../cda:section'> 
            [S_prenatalEvents] Erreur de Conformité PCC: 'Prenatal Events' ne peut être utilisé que comme section.
        </assert>

        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "57073-9"]'> 
            [S_prenatalEvents] Erreur de Conformité PCC: Le code de la section 'Prenatal Events' doit être '57073-9'
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_prenatalEvents] Erreur de Conformité PCC: L'élément 'codeSystem' de la section 
            'Prenatal Events' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
 
    </rule>
    
</pattern>