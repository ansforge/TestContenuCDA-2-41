<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_codedFamilyMedicalHistory.sch ]O@%#o>>=-

Teste la conformité de la section "Coded Family Medical History" (1.3.6.1.4.1.19376.1.5.3.1.3.15)
aux spécifications d'IHE PCC v3.0

Historique :
24/06/11 : CRI : Création
03/07/2017 : LBE :  Ajout du compte de templateId, pas besoin de tester si le parent de l'entrée est présent, conventions de nommage

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedFamilyMedicalHistory">
   
    <title>IHE PCC v3.0 Coded Family Medical History Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.15"]'>
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;1">
            [S_codedFamilyMedicalHistory.sch] Erreur de conformité PCC : L'élément coded Family Medical history doit contenir au minimum deux templateId
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_codedFamilyMedicalHistory.sch] Erreur de conformité PCC : le templateId de 'Coded Family Medical History' 
            ne peut être utilisé que pour une section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "10157-6"]'> 
            [S_codedFamilyMedicalHistory] : Le code de la section 'Coded Family Medical History' doit être 10157-6
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedFamilyMedicalHistory] : L'attribut 'codeSystem' de la section 'Coded Family Medical History' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>
        
        <!-- Vérifier que le templateId parent est présent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.3.14"]'> 
            [S_codedFamilyMedicalHistory] : Le template parent 1.3.6.1.4.1.19376.1.5.3.1.3.14 (Coded Family Medical History) n'est pas présent. 
        </assert>
        
        <!-- Vérifier que l'entrée organizer est présente -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.15"]'>
            [S_codedFamilyMedicalHistory] : La section Coded Family Medical History 
            doit contenir au moins une entrée Family History Organizer.
        </assert>
        
    </rule>
</pattern>
