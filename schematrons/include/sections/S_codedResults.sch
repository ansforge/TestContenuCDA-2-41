<?xml version="1.0" encoding="UTF-8"?>

<!-- S_codedResults.sch 
    
    Teste la conformité de la section FR-Resultats-examens (Coded Results - 1.3.6.1.4.1.19376.1.5.3.1.3.28)
    aux spécifications d'IHE PCC
    
    Historique :
    25/07/11 : CRI : Création
    04/07/17 : NMA : Ajout des contraintes sur le nombre des templateIds, sur les entrées et renommage du schématron
    08/11/17 : NMA : Ajout du test sur le templateId parent
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    25/11/2020 : APE : Suppression du contrôle de présence de l'entrée Simple observation qui n'est pas obligatoire
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedResults">

    <title>IHE PCC Coded Results Section</title>
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.28&quot;]">
        
        <!-- Verifier que le templateId est utilisé correctement --> 
        <assert test="../cda:section"> 
            [S_codedResults] Erreur de Conformité PCC : FR-Resultats-examens ne peut être utilisé que comme section.
        </assert>
        
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.27']"> 
            [S_codedResults] Erreur de conformité PCC : Le templateId parent (1.3.6.1.4.1.19376.1.5.3.1.3.27) doit être présent pour cette section
        </assert>
        
        <assert test="count(cda:templateId)&gt;1">
            [S_codedResults] Erreur de Conformité PCC : Au minimum deux templateIds doivent être présents pour cette section
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = '30954-2']"> 
            [S_codedResults] Erreur de Conformité PCC : Le code de la section FR-Resultats-examens doit être '30954-2'
        </assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_codedResults] Erreur de Conformité PCC : L'élément 'codeSystem' de la section 
            FR-Resultats-examens doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19"]'>
            [S_CodedResults] Erreur de Conformité PCC : La section FR-Resultats-examens doit contenir au moins une entrée FR-Acte (Procedure Entry - 1.3.6.1.4.1.19376.1.5.3.1.4.19).
        </assert>
        
        <!-- 25/11/2020 : suppression du contrôle de présence de l'entrée Simple observation qui n'est pas obligatoire 
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
            [S_CodedResults] Erreur de Conformité PCC : La section FR-Resultats-examens doit contenir au moins une entrées de type Simple Obesrvation (1.3.6.1.4.1.19376.1.5.3.1.4.13).
        </assert>
        --> 
        
    </rule>
</pattern>
