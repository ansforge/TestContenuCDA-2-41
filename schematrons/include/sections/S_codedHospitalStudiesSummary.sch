<?xml version="1.0" encoding="UTF-8"?>

<!-- S_CodedHospitalStudiesSummary.sch
    
    Teste la conformité de la section "Coded Hospital Stadies Summary Section" (1.3.6.1.4.1.19376.1.5.3.1.3.30)
    aux spécifications d'IHE PCC
    
    Historique :
    13/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_CodedHospitalStudiesSummary">
    
    
    <title>IHE PCC v3.0 Coded Hospital Studies Summary Section</title>
    
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.30&quot;]">
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt;1">
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : 'Coded Hospital Studies Summary' doit contenir au moins deux templateIds
        </assert>
        
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : 'Coded Hospital Studies Summary' ne peut être utilisé que comme section.
        </assert>
        
        <!--Vérifier le template parent-->
        <assert test="cda:templateId/@root = '1.3.6.1.4.1.19376.1.5.3.1.3.29'"> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : Cette section doit avoir un templateId parent (1.3.6.1.4.1.19376.1.5.3.1.3.29)
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = &quot;11493-4&quot;]"> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : Le code de la section 'Coded Hospital Studies Summary Section' doit être '11493-4'
        </assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Coded Hospital Studies Summary Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
        
        <!--Vérifier la présence de l'entrée obligatoire-->
        <assert test="//cda:templateId/@root = '1.3.6.1.4.1.19376.1.5.3.1.4.19'"> 
            [S_codedHospitalStudiesSummary.sch] : Erreur de conformité PCC : L'entrée Procedure (1.3.6.1.4.1.19376.1.5.3.1.4.19) est obligatoire dans cette section
        </assert>
        
        
         
    </rule>
</pattern>
