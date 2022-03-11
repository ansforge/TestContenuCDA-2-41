<?xml version="1.0" encoding="UTF-8"?>

<!--  S_statutDossierRCP_ANS.sch
    
     Vérification de la conformité de la section FR-Statut-dossier-RCP (1.2.250.1.213.1.1.2.33) créée par l'ANS
    
    Historique :
    17/08/2017 : LBE : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_statutDossierRCP_ANS">
    
    <title>Vérification de la conformité de la section FR-Statut-dossier-RCP (1.2.250.1.213.1.1.2.33) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.33"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_statutDossierRCP_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_statutDossierRCP_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'id' unique.
        </assert>
        
        <assert test="cda:text">
            [S_statutDossierRCP_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'.
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "21874-3"]'>
            [S_statutDossierRCP_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '21874-3'.
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_statutDossierRCP_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des entrées optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.7'">
            [S_statutDossierRCP_ANS.sch] Erreur de conformité CI-SIS : L'entrée optionnelle autorisée est organizer RCP (1.2.250.1.213.1.1.3.7).        
        </assert>

    </rule>

</pattern>
