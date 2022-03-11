<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_payers.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Payers Section" (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.7) aux spécifications d'IHE PCC v3.0
    
    Historique :
    14/01/2020 : NMA : Création
    
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_payers">
    
    <title>Section couverture sociale</title>

    <rule context='*[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.1.5.3.7"]'>

        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section">
            [S_payers] Erreur de conformité PCC : 'Couverture sociale' ne peut être utilisé que comme section
        </assert>

        <assert test="count(cda:templateId) &gt; 1">
            [S_payers] Erreur de conformité PCC : Au moins deux templateIds doivent être présents pour cette section
        </assert>
        
        <assert test="cda:templateId/@root='2.16.840.1.113883.10.20.1.9'">
            [S_payers] Erreur de conformité PCC : Le template parent CCD payers (2.16.840.1.113883.10.20.1.9) doit être présent
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "48768-6"]'>
            [S_payers.sch] Erreur de Conformité PCC : Le code de la section couverture sociale doit être 48768-6
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_payers.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 'couverture sociale' doit
            être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
             
    </rule>

</pattern>
