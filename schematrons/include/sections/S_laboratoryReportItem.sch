<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    S_laboratoryReportItem.sch :
    
    Vérification de la conformité d'une section de 2ème niveau S_LaboratoryReportItem (1.3.6.1.4.1.19376.1.3.3.2.2)  
    
    Historique :
    13/01/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_laboratoryReportItem">
    <p>Vérification de la conformité d'une section de 2ème niveau FR-Examen-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.2)</p>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.3.3.2.2"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_laboratoryReportItem] Erreur de Conformité : Le templateId "1.3.6.1.4.1.19376.1.3.3.2.2" ne peut être utilisé que pour une section. 
        </assert>
        
        <assert test="cda:code[@codeSystem = '2.16.840.1.113883.6.1'] or not(cda:code/@code)">
            [S_laboratoryReportItem] Erreur de conformité :
            Le code d'une section de  niveau 2, s'il existe, doit appartenir à la terminologie LOINC. 
        </assert>
        
        <assert test="cda:text and count(cda:entry) = 1">
            [S_laboratoryReportItem] Erreur de conformité : 
            Une section de 2ème niveau FR-Examen-de-biologie (1.3.6.1.4.1.19376.1.3.3.2.2) doit comporter exactement 1 élément text et 1 élément entry. 
        </assert>
        
    </rule>
</pattern>
