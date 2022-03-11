<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................    
   S_bilan-diagnostic-immediat_ANS
   Schématron de vérification de la conformité au modèle du CI-SIS d'une section FR-Bilan-diagnostic-immediat (1.2.250.1.213.1.1.2.59) dans un document D2LM-FIN 
   
   D2LM : CR de seconde lecture de mammographie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    23/10/2017 : Création
    06/09/2021 : Suppression de la sous-section FR-Resultats-evenements
   ......................................................................................................................................................    
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_bilan-diagnostic-immediat_ANS">
    <title>Vérification de la Section FR-Bilan-diagnostic-immediat</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.59"]'>

        <!-- Contrôle du code de la section -->
        <assert test='.//cda:code[@code = "72135-7"]'>
            [S_bilan-diagnostic-immediat_ANS.sch] Erreur de conformité : Le code de la section FR-Bilan-diagnostic-immediat (1.2.250.1.213.1.1.2.59) doit être "72135-7".
        </assert>  
        <assert test='.//cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_bilan-diagnostic-immediat_ANS.sch] Erreur de conformité : Le code de la section FR-Bilan-diagnostic-immediat (1.2.250.1.213.1.1.2.59) doit faire partie de la nomenclature LOINC.
        </assert> 
        
        <!-- Présence obligatoire de la section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.28"]'>
            [S_bilan-diagnostic-immediat_ANS.sch] Erreur de conformité : La section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28) est obligatoire dans la section FR-Bilan-diagnostic-immediat (1.2.250.1.213.1.1.2.59).
        </assert>
        
        <!-- Présence obligatoire de la section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
            [S_bilan-diagnostic-immediat_ANS.sch] Erreur de conformité : La section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) est obligatoire dans la section FR-Bilan-diagnostic-immediat (1.2.250.1.213.1.1.2.59).
        </assert>         
        
    </rule>
    
</pattern>