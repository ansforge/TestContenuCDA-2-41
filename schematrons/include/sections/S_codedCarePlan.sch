<?xml version="1.0" encoding="UTF-8"?>

<!--  Schématron S_codedCarePlan.sch 
    
    Teste la conformité de la section " Coded care plan Section" (1.3.6.1.4.1.19376.1.5.3.1.3.36)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    02/08/2016 : Création
    03/07/2017 : Vérification du nombre de templateId + conventions de nommage
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedCarePlan">
    
    <title>IHE PCC v3.0 Coded Care Plan Section</title>
    
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.36&quot;]"> <!-- ou 1.3.6.1.4.1.19376.1.5.3.1.3.31-->
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;1">
            [S_codedCarePlan.sch] Erreur de conformité PCC : La section "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit contenir au minimum deux templateIds
        </assert>
    
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [S_codedCarePlan.sch] Erreur de conformité PCC :  La section "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) ne peut être utilisée que comme section.</assert>
        
        <!-- Vérifier la présence des templateId parents. -->
        <assert test="cda:templateId[@root=&quot;2.16.840.1.113883.10.20.1.10&quot;]"> 
            [S_codedCarePlan.sch] Erreur de conformité PCC : Le templateId parent '2.16.840.1.113883.10.20.1.10' de la section "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit être présent</assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = &quot;18776-5&quot;]"> 
            [S_codedCarePlan.sch] Erreur de conformité PCC : Le code de la section "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit être '18776-5'</assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_codedCarePlan.sch] Erreur de conformité PCC :  L'élément 'codeSystem' de la section 
            "Plan de soins" (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit être "2.16.840.1.113883.6.1" (LOINC)</assert>
        
    </rule>
</pattern>
