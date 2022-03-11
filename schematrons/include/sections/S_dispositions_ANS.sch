<?xml version="1.0" encoding="UTF-8"?>

<!-- S_dispositions_ANS.sch
    
    Vérification de la conformité de la section FR-Dispositions (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.10) créée par l'ANS
    
    Historique :
    26/05/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_dispositions_ANS">
    <title>Vérification de la conformité de la section FR-Dispositions (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.10) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.172"]'>
        <!-- Vérifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_dispositions_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)&lt;=1">
            [S_dispositions_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "11302-7"]'> 
            [S_dispositions_ANS.sch] Erreur de conformité CI-SIS : Le code de la section 'FR-Dispositions' doit être '11302-7' 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_dispositions_ANS.sch] Erreur de conformité CI-SIS : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        <!-- Vérification de la présence de l'élément text -->
        <assert test="cda:text">
            [S_dispositions_ANS.sch] Erreur de conformité CI-SIS : l’élément 'text' est obligatoire.
        </assert>
        <!-- Vérification de la présence de l'entrée FR-Disposition -->
        <assert test="count(cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.10.4.2'])&gt;=1">
            [S_dispositions_ANS.sch] Erreur de conformité CI-SIS : l’entrée obligatoire FR-Disposition (1.3.6.1.4.1.19376.1.5.3.1.1.10.4.2) doit être présente une ou plusieurs fois [1..*].
        </assert>
        
    </rule>
    
</pattern>