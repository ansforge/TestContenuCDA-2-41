<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ CodedAntenatalTestingAndSurveillance.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Coded Antenatal Testing and Surveillance" (1.3.6.1.4.1.19376.1.5.3.1.1.21.2.5.1)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/07/11 : CRI : Création
    03/07/2017 : LBE : Ajout du compte de templateId et conventions de nommage
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_CodedAntenatalTestingAndSurveillance">
    <title>IHE PCC v3.0 Coded Antenatal Testing and Surveillance Section</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.21.2.5.1"]'>
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;1">
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : Coded Antenatal Testing and Surveillance Section doit contenir au minimum deux templateId
        </assert>
        
        <!-- Verifier que le templateId est utilisé à bon escient -->        
        <assert test='../cda:section'> 
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : 'Coded Antenatal Testing and Surveillance' ne peut être utilisé que comme section.
        </assert> 

        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "57078-8"]'> 
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : Le code de la section 'Prenatal Events' doit être '57078-8'
        </assert> 
        <!-- Vérifier que le système de codification de la section est bien LOINC. -->
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Coded Antenatal Testing and Surveillance Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <!-- Vérifier que le templateId parent est bien présent. --> 
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.1.21.2.5"]'> 
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : L'OID du template parent de la section 'Coded physical Exam' est absent. 
        </assert> 
        
        <!-- Verifier qu'un organizer 'Antenatal Testing and Surveillance' est present -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10"]'>
            [S_codedAntenatalTestingAndSurveillance.sch] Erreur de conformité PCC : Une section 'Antenatal Testing and Surveillance' doit contenir un élément 'Antenatal Testing and Surveillance Battery'.
        </assert> 
    </rule>
</pattern>