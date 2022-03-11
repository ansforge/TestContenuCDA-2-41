<?xml version="1.0" encoding="UTF-8"?>


<!--                  -=<<o#%@O[ S_ProthesesEtObjetsPerso.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Protheses Et Objets Personnels" (1.2.250.1.213.1.1.2.53)
    aux spécifications du CI-SIS
    

    
    Historique :
    11/10/16 : NMA : Création
    03/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_prothesesEtObjetsPerso">
    
    <title>Prothèse et objets personnel Section</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.53"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test='../cda:section'> 
            [S_ProthesesEtObjetsPerso] Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "46264-8"]'> 
            [S_ProthesesEtObjetsPerso] Erreur de Conformité CI-SIS: Le code de la section Protheses Et Objets Personnels doit être 46264-8
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_ProthesesEtObjetsPerso] Erreur de Conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'> 
            <!-- Alert on any missing required if known elements -->
            [S_ProthesesEtObjetsPerso] Erreur de Conformité CI-SIS : la section 'Protheses Et Objets Personnels' doit avoir une 'Simple Observation Entry'
        </assert> 

    </rule>
    
</pattern>

