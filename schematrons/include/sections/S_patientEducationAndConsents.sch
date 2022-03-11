<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_patientEducationAndConsents.sch ]O@%#o>>=-
    
    Teste la conformité de la section Patient Education and Consents (1.3.6.1.4.1.19376.1.5.3.1.1.9.39)
    
    04/08/11 : CRI : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_patientEducationAndConsents">
    
    <title>IHE PCC v3.0 Patient Education and Consents</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.39"]'>
        
        <!-- Verifier que le template id est utilisé correctement -->
        <assert test='../cda:section'> 
            [S_patientEducationAndConsents] 'Patient Education and Consents' ne peut qu'être utilisé que comme sections. 
        </assert>
        
        <!-- Verifier que le templateId parent est présent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.38"]'> 
            [S_patientEducationAndConsents] le templateId parent de la section 'Patient Education and Consents' n'est pas présent. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "34895-3"]'> 
            [S_patientEducationAndConsents] Le code de la section 'Patient Education and Consents' doit être '34895-3' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_patientEducationAndConsents] élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert> 

    </rule>
    
</pattern>