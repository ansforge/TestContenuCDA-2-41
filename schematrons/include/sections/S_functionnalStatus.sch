<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_FunctionnalStatus.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Functionnal Status" (1.3.6.1.4.1.19376.1.5.3.1.3.17)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    13/01/2020 : NMA : Création
    
-->



<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_functionnalStatus">
    <title>IHE PCC v3.0 Functionnal Status Section - errors validation phase</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.17"]'>
        
        <!-- Verifier que le templateId est utilisépour une section -->
        <assert test='../cda:section'> 
            [S_FunctionnalStatus] Erreur de Conformité PCC : Ce template ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:templateId)&gt;1">
            [S_FunctionnalStatus] Erreur de Conformité PCC : Deux templateIds au moins doivent être présents pour cette section
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "47420-5"]'> 
            [S_FunctionnalStatus] Erreur de Conformité PCC : Le code de la section Functionnal Status doit être 47420-5
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_FunctionnalStatus] Erreur de Conformité PCC : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <!-- Verifier que le templateId parent est présent. --> 
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.5"]'> 
            [S_FunctionnalStatus] Erreur de Conformité PCC : L'identifiant du template de conformité CCD est absent. 
        </assert>
    </rule>
</pattern>
