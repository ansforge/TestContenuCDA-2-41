<?xml version="1.0" encoding="UTF-8"?>

<!--  S_anamneseEtFacteursDeRisques_ANS.sch
    
    Vérification de la conformité de la section FR-Anamnese-et-facteurs-de-risques (1.2.250.1.213.1.1.2.68) créée par l'ANS

    Historique :
    29/11/2019 : Création
    19/12/2019 : Corrections
    30/01/2020 : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_anamneseEtFacteursDeRisques_ANS">
    <title>Vérification de la conformité de la section FR-Anamnese-et-facteurs-de-risques (1.2.250.1.213.1.1.2.68) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.68"]'>
        
        <assert test="../cda:section"> 
            [S_anamneseEtFacteursDeRisques_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_anamneseEtFacteursDeRisques_ANS.sch] Erreur de onformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
                
        <assert test='cda:code[@code = "46612-8"]'> 
            [S_anamneseEtFacteursDeRisques_ANS.sch] Erreur de conformité CI-SIS : Le code de la section 'ANAMNESE ET FACTEURS DE RISQUES' doit être '46612-8' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_anamneseEtFacteursDeRisques_ANS.sch] Erreur de conformité CI-SIS :  L'attribut 'codeSystem' du code de la section doit être '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        
        <assert test='cda:component/cda:section/cda:templateId/@root="1.2.250.1.213.1.1.2.69"'> 
            [S_anamneseEtFacteursDeRisques_ANS.sch] Erreur de conformité CI-SIS : Cette section Anamnèse et facteurs de risques doit contenir la section FR Anamnèse (1.2.250.1.213.1.1.2.69).
        </assert>
        
        <assert test="count(//cda:component/cda:section/cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1']) &lt;= 1">
            [S_anamneseEtFacteursDeRisques_ANS.sch] Erreur de conformité CI-SIS : Si elle existe, La sous-section optionnelle Facteurs de risques professionnels (Hazardous working conditions - 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1) ne doit être présente qu'une seule fois [0..1].
        </assert> 
        
        <assert test="count(//cda:component/cda:section/cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.3.16']) &lt;= 1">
            [S_anamneseEtFacteursDeRisques_ANS.sch] Erreur de conformité CI-SIS :  Si elle existe, La sous-section optionnelle Habitus, Mode de vie (Social History - 1.3.6.1.4.1.19376.1.5.3.1.3.16) ne doit être présente qu'une seule fois [0..1].
        </assert> 
        
        <!-- Vérification de la présence des sous-sections optionnelles -->
        <!-- [APE] Ce test ne fonctionne pas 
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId[
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.16' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1']">
            [S_anamneseEtFacteursDeRisques_ANS.sch] Erreur de conformité CI-SIS : Les sous-sections optionnelles possibles sont : 
            Habitus, Mode de vie (Social History - 1.3.6.1.4.1.19376.1.5.3.1.3.16) et Facteurs de risques professionnels (Hazardous working conditions - 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1)
        </assert> -->
                
    </rule>
</pattern>
