<?xml version="1.0" encoding="UTF-8"?>

<!-- S_psychomotorDevelopment.sch
    
    Teste la conformité de la section "Psychomotor Development" (1.3.6.1.4.1.19376.1.7.3.1.1.13.4)
    aux spécifications d'IHE PCC.
    
    Historique :
    24/06/2011 : Création
    14/11/2016 : Teste la présence de l'entrée Simple Observation
    03/07/2017 : Ajout du comptre de templateId + conventions de nommage + modifciation du nom du schématron pour le rendre conforme à IHE PCC
    22/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    30/01/2020 : Suppression du test sur le nombre de templateId
    03/03/2021 : Correction du code de la section à xx-MCH-PsychoMDev (LOINC)
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_psychomotorDevelopment">
    
    <title>IHE PCC v3.0 Psychomotor Development</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.4"]'> 
        
        <!-- Verifier que le templateId est utilisé à bon escient -->        
        <assert test='../cda:section'> 
            [S_psychomotorDevelopment] Erreur de conformité : 'Psychomotor Development' ne peut être utilisé que comme section.
        </assert>

        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "xx-MCH-PsychoMDev"]'> 
            [S_psychomotorDevelopment] Erreur de conformité : Le code de la section 'Psychomotor Development' doit être 'xx-MCH-PsychoMDev'
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_psychomotorDevelopment] Erreur de conformité : L'élément 'codeSystem' de la section 'Psychomotor Development' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
            [S_psychomotorDevelopment] Erreur de conformité : La section 'Psychomotor Development' ne contient pas d'entrée 'Simple Observation'.        
        </assert> 

    </rule>
    
</pattern>
