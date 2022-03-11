<?xml version="1.0" encoding="UTF-8"?>


<!-- S_conclusionCRO_ANS.sch
    
     Vérification de la conformité de la section FR-Conclusion-de-CRO (1.2.250.1.213.1.1.2.26) créée par l'ANS
        
    Historique :
    17/08/2017 : LBE : Création (section utilisée par le volet FRCP)
    06/06/2019 : Mofication du code LOINC de la section
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_conclusionCRO_ANS">
    <title>Vérification de la conformité de la section FR-Conclusion-de-CRO (1.2.250.1.213.1.1.2.26) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.26"]'>

        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_conclusionCRO_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_conclusionCRO_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'id'.
        </assert>
        
        <assert test="cda:text">
            [S_conclusionCRO_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "10218-6"]'>
            [S_conclusionCRO_ANS.sch] Erreur de conformité CI-SIS : Le code de la section FR-Conclusion-de-CRO doit être '10218-6'
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_conclusionCRO_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
    </rule>

</pattern>
