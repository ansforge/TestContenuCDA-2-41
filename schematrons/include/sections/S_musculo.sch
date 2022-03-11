<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_musculo.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Musculoskeletal system" (1.3.6.1.4.1.19376.1.5.3.1.1.9.34)
    aux spécifications d'IHE PCC v3.0
    Note: Cette section est utilisée comme sous-section de la section IHE PCC v3.0 Coded Physical Exam Section
    (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1) et non telle quelle.
    
    Historique :
    24/06/11 : CRI : Création
    27/10/17 : NMA : Mise à jour du nom du schématron , des messages d'erreur et correction du titre
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_musculo">
    
    <title>IHE PCC v3.0 Musculoskeletal system Section - errors validation phase</title>
    
    <!-- ****** Contexte = section Musculo-squelettique ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.34"]'>
        
        <!-- Verifier que le templateId n'est utilisé que pour une section -->
        <assert test='../cda:section'> 
            [S_musculo] Erreur de Conformité PCC: l'élément 'Musculoskeletal system' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code ="11410-8"]'> 
            [S_musculo] Erreur de Conformité PCC: Le code de la section 'Musculoskeletal system' doit être 11410-8
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_musculo] Erreur de Conformité PCC: L'attribut 'codeSystem' de la section 'Musculoskeletal system' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>

    </rule>
    
</pattern>

