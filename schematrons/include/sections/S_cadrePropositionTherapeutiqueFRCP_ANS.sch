<?xml version="1.0" encoding="UTF-8"?>


<!-- S_cadrePropositionTherapeutiqueFRCP_ANS
    
    Vérification de la conformité de la section FR-Cadre-de-la-proposition-therapeutique-FRCP (1.2.250.1.213.1.1.2.45) créée par l'ANS
        
     Historique :
     13/01/2020 : NMA : Création
     31/03/2020 : APE : remise de l'ancien code de la FRCP V2
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_cadrePropositionTherapeutiqueFRCP_ANS">
    <title>Vérification de la conformité de la section FR-Cadre-de-la-proposition-therapeutique (1.2.250.1.213.1.1.2.45) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.45"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_cadrePropositionTherapeutiqueFRCP_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un templateId
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_cadrePropositionTherapeutiqueFRCP_ANS.sch]  Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_cadrePropositionTherapeutiqueFRCP_ANS.sch]  Erreur de conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_cadrePropositionTherapeutiqueFRCP_ANS.sch]  Erreur de conformité CI-SIS : La section doit contenir un élément text
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "56447-6"]'>
            [S_cadrePropositionTherapeutique_ANS.sch]  Erreur de conformité CI-SIS : Le code de cette section doit être 56447-6 "Note sur le plan de soins"
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_cadrePropositionTherapeutiqueFRCP_ANS.sch]  Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des entrées obligatoires -->
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [S_cadrePropositionTherapeutiqueFRCP_ANS.sch]  Erreur de conformité CI-SIS : L'entrée Simple observation est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.4.13)
        </assert>
        
    </rule>

</pattern>
