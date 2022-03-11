<?xml version="1.0" encoding="UTF-8"?>

<!-- S_cadrePropositionTherapeutique_ANS.sch
    
     Vérification de la conformité de la section FR-Cadre-de-la-proposition-therapeutique (	1.2.250.1.213.1.1.2.45) créée par l'ANS
        
     Historique :
     24/07/2020 : ANS : Création
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_cadrePropositionTherapeutique_ANS">
    <title>Vérification de la conformité de la section FR-Cadre-de-la-proposition-therapeutique (1.2.250.1.213.1.1.2.45) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.45"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_cadrePropositionTherapeutique_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un templateId
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_cadrePropositionTherapeutique_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_cadrePropositionTherapeutique_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'id' unique.
        </assert>
        
        <assert test="cda:text">
            [S_cadrePropositionTherapeutique_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'.
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "35510-7"] or cda:code[@code = "56447-6"]'>
            [S_cadrePropositionTherapeutique_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '35510-7' "Essais cliniques - Informations générales"
            ou '35510-7' "Note sur le plan de soins"
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_cadrePropositionTherapeutique_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des entrées obligatoires -->
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [S_cadrePropositionTherapeutique_ANS.sch] Erreur de conformité CI-SIS : L'entrée Simple observation est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.4.13)
        </assert>
        
    </rule>

</pattern>
