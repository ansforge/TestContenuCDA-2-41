<?xml version="1.0" encoding="UTF-8"?>


<!-- S_dossier_ANS.sch
    
     Vérification de la conformité de la section FR-Dossier (1.2.250.1.213.1.1.2.66) créée par l'ANS
        
    Historique :
    09/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_dossier_ANS">
    <title>Vérification de la conformité de la section FR-Dossier (1.2.250.1.213.1.1.2.66) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.66"]'>

        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_dossier_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)&lt;2">
            [S_dossier_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir au maximum un seul 'id' (cardinalité [0..1])
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "GEN-168"]'>
            [S_dossier_ANS.sch] Erreur de conformité CI-SIS : Le 'code' de la section FR-Dossier doit être 'GEN-168'
        </assert>
        
    </rule>

</pattern>
