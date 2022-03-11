<?xml version="1.0" encoding="UTF-8"?>


<!-- S_documentsAjoutes_ANS.sch
    
     Vérification de la conformité de la section FR-Documents-ajoutes (1.2.250.1.213.1.1.2.37) créée par l'ANS
        
    Historique :
    14/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_documentsAjoutes_ANS">
    <title>Vérification de la conformité de la section FR-Documents-ajoutes (1.2.250.1.213.1.1.2.37) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.37"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_documentsAjoutes_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)&lt;2">
            [S_documentsAjoutes_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir au maximum un seul 'id'.
        </assert>
        
        <assert test="cda:text">
            [S_documentsAjoutes_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "55107-7"]'>
            [S_documentsAjoutes_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '55107-7'
        </assert>

        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_documentsAjoutes_ANS.sch] Erreur de conformité CI-SIS : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='//cda:templateId[@root = "1.2.250.1.213.1.1.3.18"]'> 
            [S_documentsAjoutes_ANS.sch] Erreur de conformité CI-SIS : L'entrée Document attaché (1.2.250.1.213.1.1.3.18) est obligatoirement présente dans cette section
        </assert> 
        
    </rule>

</pattern>
