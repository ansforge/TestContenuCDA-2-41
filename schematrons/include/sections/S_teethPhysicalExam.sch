<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_teethPhysicalExam.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Mouth, Throat and Teeth" (1.3.6.1.4.1.19376.1.5.3.1.1.9.23)
    aux spécifications d'IHE PCC
    Note: Cette section est utilisée comme sous-section de la section IHE PCC v3.0 Coded Physical Exam Section
    (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1) et non telle quelle.
    
    Historique :
    24/06/11 : CRI : Création
    03/07/17 : NMA : Ajout du test sur le nombre de templateIds et renommage du schématron
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_teethPhysicalExam">
    
    <title>IHE PCC v3.0 Mouth, Throat and Teeth section</title>
    
    <!-- ****** Contexte = sous-section Dents ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.23"]'>
        
        <!-- Verifier que le templateId n'est utilisé que pour une section -->
        <assert test='../cda:section'> 
            [S_teethPhysicalExam] Erreur de Conformité PCC: section 'Mouth, Throat and Teeth' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "10201-2"]'> 
            [S_teethPhysicalExam] Erreur de Conformité PCC: Erreur de Conformité PCC: Le code de la section 'Mouth, Throat and Teeth' doit être 10200-4
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_teethPhysicalExam] Erreur de Conformité PCC: Erreur de Conformité PCC: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>

    </rule>
    
</pattern>



