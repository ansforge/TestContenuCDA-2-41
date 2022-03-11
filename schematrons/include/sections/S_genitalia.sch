<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_genitalia.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Genitalia" (1.3.6.1.4.1.19376.1.5.3.1.1.9.36)
    aux spécifications d'IHE PCC v3.0
    Note: Cette section est utilisée comme sous-section de la section IHE PCC v3.0 Coded Physical Exam Section
    (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1) et non telle quelle.
    
    Historique :
    24/06/11 : CRI : Création
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_genitalia">
    
    <title>IHE PCC v3.0 Genitalia</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.36"]'>
        
            <!-- Verifier que le templateId est utilisé que pour une section -->
            <assert test='../cda:section'> 
                [S_genitalia] Erreur de Conformité PCC: Cet élément ne peut être utilisé que comme section.
            </assert>
        
            <!-- Vérifier le code de la section --> 
            <assert test='cda:code[@code ="11400-9"]'> 
                [S_genitalia] Erreur de Conformité PCC: Le code de la section doit être 11400-9
            </assert> 
        
            <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
                [S_genitalia] Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
                (2.16.840.1.113883.6.1). 
            </assert>
        
        </rule>

</pattern>


