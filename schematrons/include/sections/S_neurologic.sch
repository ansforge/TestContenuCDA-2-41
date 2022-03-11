<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_neurologic.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Neurologic System" (1.3.6.1.4.1.19376.1.5.3.1.1.9.35)
    aux spécifications d'IHE PCC v3.0
    Note: Cette section est utilisée comme sous-section de la section IHE PCC v3.0 Coded Physical Exam Section
    (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1) et non telle quelle.
    
    Historique :
    24/06/11 : CRI : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_neurologic">
    
    <title>IHE PCC v3.0 Neurologic System</title>
    
    <!-- ****** Contexte = section Système Neurologique ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.35"]'>
        
        <!-- Verifier que le templateId n'est utilisé que pour une section -->
        <assert test='../cda:section'> 
            [S_neurologic] Erreur de Conformité PCC: "Neurologic System" ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code ="10202-0"]'> 
            [S_neurologic] Erreur de Conformité PCC: Le code de la section "Neurologic System" doit être 10202-0
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_neurologic] Erreur de Conformité PCC: L'attribut 'codeSystem' de la section "Neurologic System" doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>
        
    </rule>
    
</pattern>




