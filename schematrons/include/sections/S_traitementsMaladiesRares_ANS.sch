<?xml version="1.0" encoding="UTF-8"?>

<!--  S_traitementsMaladiesRares_ANS.sch
    
     Vérification de la conformité de la section FR-Traitements-maladies-rares (1.2.250.1.213.1.1.2.54) créée par l'ANS

    Historique :
    24/06/11 : CRI : Création
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_traitementsMaladiesRares_ANS">
    
    <title>Vérification de la conformité de la section FR-Traitements-maladies-rares (1.2.250.1.213.1.1.2.54) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.54"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_traitementsMaladiesRares_ANS] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que pour une section. 
        </assert> 
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "10160-0"]'> 
            [S_traitementsMaladiesRares_ANS] Erreur de conformité CI-SIS : Le code de cette section doit être '10160-0'.
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_traitementsMaladiesRares_ANS] Erreur de conformité CI-SIS : Le code de la section doit être un code LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.3.13"]'> 
            [S_traitementsMaladiesRares_ANS] Erreur de conformité CI-SIS : Cette section doit contenir des entrées de type "Traitement Maladie rare" (1.2.250.1.213.1.1.3.13).
        </assert>
        
    </rule>
    
</pattern>