<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_intravenousFluidsAdministered.sch ]O@%#o>>=-

Teste la conformité de la section "intravenous Fluids Administered" (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.6)
aux spécifications d'IHE PCC v3.0

Historique :

    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_intravenousFluidsAdministered">
    
    <title>IHE PCC v3.0 Intravenous Fluids Administered Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.13.2.6"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_intravenousFluidsAdministered] Erreur de Conformité PCC : Le templateId de 'intravenous Fluids Administered' ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "57072-1"]'> 
            [S_intravenousFluidsAdministered] Erreur de Conformité PCC : Le code de la section intravenous Fluids Administered doit être '57072-1' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_intravenousFluidsAdministered] Erreur de Conformité PCC : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.13.3.2"]'> 
            <!-- Vérifier que les entrées sont conformes -->
            [S_intravenousFluidsAdministered] Erreur de Conformité PCC : La section Medications doit contenir des entrées de type Intravenous Fluids (1.3.6.1.4.1.19376.1.5.3.1.1.13.3.2).
        </assert> 
        
    </rule>
    
</pattern>