<?xml version="1.0" encoding="UTF-8"?>

<!-- E_statutDuDocument_fr.sch 
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entrée 
    FR-Statut-document (1.2.250.1.213.1.1.3.48.16)  
    
    Historique :
    27/05/2021 : SBM : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_statutDuDocument_fr">
    
    <title>CI-SIS Statut du document</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.48.16"]'>
        
        <assert test='count(cda:id)=1'>
            [E_statutDuDocument_fr] : Erreur de conformité CI-SIS : Un élément "Allergies and Intolerance" comporte obligatoirement un identifiant "id".
        </assert>
        <assert test="cda:templateId/@root='1.2.250.1.213.1.1.3.48.16'">
            [E_statutDuDocument_fr] : Erreur de conformité CI-SIS : L'élément de templatId '1.2.250.1.213.1.1.3.48.16' doit être présent
        </assert>
        <assert test="cda:templateId/@root='1.2.250.1.213.1.1.3.48'">
            [E_statutDuDocument_fr] : Erreur de conformité CI-SIS : L'élément de templatId '1.2.250.1.213.1.1.3.48' doit être présent
        </assert>
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_statutDuDocument_fr] : Erreur de conformité CI-SIS : L'élément de templatId '1.3.6.1.4.1.19376.1.5.3.1.4.13' doit être présent
        </assert>
        <assert test='cda:code/@code="GEN-065"'>
            [E_statutDuDocument_fr] Erreur de Conformité CI-SIS:
            L'élément 'code' doit être obligatoirement 'GEN-065'.</assert>
        
        <assert test="cda:effectiveTime"> 
            [E_statutDuDocument_fr] Erreur de conformité CI-SIS : L'élément "effectiveTime" doit être présent.
        </assert>
        
        <assert test='cda:statusCode[@code = "completed"]'>
            [E_statutDuDocument_fr] Erreur de conformité CI-SIS: L'élément "statusCode" sera présent et prendra la valeur "completed"</assert>
        
        <assert test='cda:value'>
            [E_statutDuDocument_fr] Erreur de conformité CI-SIS: L'élément "value" doit être présent.</assert>
        
    </rule>
</pattern>
