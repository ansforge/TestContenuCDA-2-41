<?xml version="1.0" encoding="UTF-8"?>

<!-- Schématron Section Dispositifs médicaux
    
   Teste la conformité de la section Dispositifs médicaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.5) 
    
    
   Historique :
   13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_medicalDevices">
    
    <title>IHE Section medicalD evices</title>
    
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.5']">
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section">
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "46264-8"]'>
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : Le code de la section Dispositifs médicaux doit être 46264-8
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_medicalDevices.sch] Erreur de Conformité CI-SIS : L'élément 'codeSystem' correspond à la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
    </rule>

    
</pattern>
