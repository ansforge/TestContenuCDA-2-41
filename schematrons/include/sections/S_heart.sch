<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_heart.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Heart" (1.3.6.1.4.1.19376.1.5.3.1.1.9.29)
    aux spécifications d'IHE PCC v3.0
    Note: Cette section est utilisée comme sous-section de la section IHE PCC v3.0 Coded Physical Exam Section
    (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1) et non telle quelle.
    
    Historique :
    24/06/11 : CRI : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_heart">
    
    <title>IHE PCC v3.0 Heart Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.29"]'>
        <!-- Verifier que le templateId n'est utilisé que pour une section -->
        <assert test='../cda:section'> 
            [Heart.sch] Erreur de Conformité PCC: L'entité 'Système Cardiaque' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "10200-4"]'> 
            [Heart.sch] Erreur de Conformité PCC: Le code de la section 'Système Cardiaque' doit être 10200-4
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [Heart.sch] Erreur de Conformité PCC: L'attribut 'codeSystem' de la section 'Système Cardiaque'doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>
        
    </rule>
    
</pattern>
