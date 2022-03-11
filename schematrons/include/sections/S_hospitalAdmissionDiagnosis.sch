<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[Hospital Admission Diagnosis.sch ]O@%#o>>=-
    
    Teste la conformité de la section " Hospital Admission Diagnosis Section" (1.3.6.1.4.1.19376.1.5.3.1.3.3)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    09/08/16 : NMA : Création
    19/06/2017 : LBE : Ajout de la vérification de la présence de l'entrée problem Concern
    03/06/2017 : LBE :  ajout compte templateId
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_hospitalAdmissionDiagnosisSection">
    
    
    <title>IHE PCC v3.0 Hospital Admission Diagnosis Section</title>
    
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.3&quot;]">
        
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [HospitalAdmissionDiagnosisSection.sch] : Erreur de conformité PCC : 'Hospital Admission Diagnosis' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = &quot;46241-6&quot;]"> 
            [HospitalAdmissionDiagnosisSection.sch] : Erreur de conformité PCC : Le code de la section 'Hospital Admission Diagnosis' doit être '46241-6'
        </assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [HospitalAdmissionDiagnosisSection.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Hospital Admission Diagnosis' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
        
        <assert test="cda:entry/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']">
            [HospitalAdmissionDiagnosisSection.sch] : Erreur de conformité PCC : La section doit contenir une entrée de type 'Problem Concern' qui contient un templateId dont la valeur de l'attribut @root est fixée à '1.3.6.1.4.1.19376.1.5.3.1.4.5.2'
        </assert>
        
    </rule>
    
</pattern>
