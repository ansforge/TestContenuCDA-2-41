<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_occupationalDataForHealth.sch ]O@%#o>>=-
    
    Teste la conformité de la section "occupational Data For Health" (1.3.6.1.4.1.19376.1.5.3.1.3.37)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    14/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_occupationalDataForHealth">
    
    <title>IHE PCC v3.0 occupational Data For Health</title>
    
    <!-- ****** Contexte = section Historique professionnel ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.37"]'>
        
        <!-- Verifier que le templateId n'est utilisé que pour une section -->
        <assert test='../cda:section'> 
            [S_occupationalDataForHealth] Erreur de Conformité PCC: "Occupational Data For Health" ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code ="74166-0"]'> 
            [S_occupationalDataForHealth] Erreur de Conformité PCC: Le code de la section "Occupational Data For Health" doit être 74166-0
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_occupationalDataForHealth] Erreur de Conformité PCC: L'attribut 'codeSystem' de la section "Occupational Data For Health" doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>
        
    </rule>
    
</pattern>




