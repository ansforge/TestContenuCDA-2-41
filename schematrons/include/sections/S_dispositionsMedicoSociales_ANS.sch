<?xml version="1.0" encoding="UTF-8"?>

<!-- S_dispositionsMedicoSociales_ANS.sch
    
     Vérification de la conformité de la section FR-Dispositions-medico-sociales (1.2.250.1.213.1.1.2.44) créée par l'ANS
    
    Historique :
    17/08/2017 : LBE : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_dispositionsMedicoSociales_ANS">
    <title>Vérification de la conformité de la section FR-Dispositions-medico-sociales (1.2.250.1.213.1.1.2.44) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.44"]'>

        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_dispositionsMedicoSociales_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_dispositionsMedicoSociales_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'id'.
        </assert>
        
        <assert test="cda:text">
            [S_dispositionsMedicoSociales_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'.
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "34841-7"]'>
            [S_dispositionsMedicoSociales_ANS.sch] Erreur de conformité CI-SIS : Le code de la section FR-Dispositions-medico-sociales doit être '34841-7'
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_dispositionsMedicoSociales_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des entrées optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [S_dispositionsMedicoSociales_ANS.sch] Erreur de conformité CI-SIS : Les entrées optionnelles autorisées sont : 
            simple observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)     
        </assert>

    </rule>

</pattern>
