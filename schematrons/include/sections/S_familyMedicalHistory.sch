<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_FamilyMedicalHistory.sch ]O@%#o>>=-

Teste la conformité de la section "Family Medical History" (1.3.6.1.4.1.19376.1.5.3.1.3.14)
aux spécifications d'IHE PCC v3.0

Historique :
    14/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_familyMedicalHistory">
   
    <title>IHE PCC v3.0 Family Medical History Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.14"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_FamilyMedicalHistory.sch] Erreur de conformité PCC : le templateId de 'Family Medical History' 
            ne peut être utilisé que pour une section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "10157-6"]'> 
            [FamilyMedicalHistory] : Le code de la section 'Family Medical History' doit être 10157-6
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [FamilyMedicalHistory] : L'attribut 'codeSystem' de la section ' Family Medical History' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>  

    </rule>
</pattern>
