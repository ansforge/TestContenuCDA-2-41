<?xml version="1.0" encoding="UTF-8"?>

<!-- S_scoreRankin_ANS.sch
    
     Vérification de la conformité de la section FR-Score-de-Rankin (1.2.250.1.213.1.1.2.39) créée par l'ANS
     
    Historique :
    17/08/2017 : LBE : Création
    20/10/2017 : NMA : Suppression du test sur la nomenclature utilisée pour coder la section
    01/04/2019 : APE : Correction du contrôle du code de la section
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_scoreRankin_ANS">
    
    <title>Vérification de la conformité de la section FR-Score-de-Rankin (1.2.250.1.213.1.1.2.39) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.39"]'>
        
        <assert test="../cda:section"> 
            [S_scoreRankin_ANS.sch] Erreur de conformité CI-SIS : cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_scoreRankin_ANS.sch] Erreur de conformité CI-SIS : la section doit contenir un élément 'id' unique.
        </assert>
        
        <assert test="cda:text">
            [S_scoreRankin_ANS.sch] Erreur de conformité CI-SIS : la section doit contenir un élément 'text'.
        </assert>
        
        <assert test='cda:code[@code = "75859-9"]'>
            [S_scoreRankin_ANS.sch] Erreur de conformité CI-SIS : Le code de cett section doit être '75859-9'.
        </assert>

        <!-- Vérification des entrées optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [S_scoreRankin_ANS.sch] Erreur de conformité CI-SIS : Les entrées optionnelles autorisées sont de type simple observation (1.3.6.1.4.1.19376.1.5.3.1.4.13).
        </assert>

    </rule>

</pattern>
