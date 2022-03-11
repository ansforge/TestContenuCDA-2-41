<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................    
   S_Interpretation-2eme-lecteur-DL2M-FIN.sch
   Schématron de vérification de la conformité de la section FR-Interpretation-2eme-lecteur-DL2M-FIN (1.2.250.1.213.1.1.2.174) dans un document CANCER-D2LM-FIN 
   
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    06/09/2021 : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_Interpretation-2eme-lecteur-DL2M-FIN">
    <title>CI-SIS CANCER-D2LM-FIN : Vérification de la Section FR-Interpretation-2eme-lecteur-DL2M-FIN</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.174"]'>
        
        <!-- Contrôle du code de la section -->
        <assert test='.//cda:code[@code = "22030-1"]'>
            [S_Interpretation-2eme-lecteur-DL2M-FIN.sch] Erreur de conformité : Le code de la section FR-Interpretation-2eme-lecteur-DL2M-FIN (1.2.250.1.213.1.1.2.174) doit être "22030-1".
        </assert>  
        <assert test='.//cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_Interpretation-2eme-lecteur-DL2M-FIN.sch] Erreur de conformité : Le code de la section FR-Interpretation-2eme-lecteur-DL2M-FIN (1.2.250.1.213.1.1.2.174) doit faire partie de la nomenclature LOINC.
        </assert>  
        
        <!-- Présence obligatoire de la section FR-Resultats-examens -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.28"]'>
            [S_Interpretation-2eme-lecteur-DL2M-FIN.sch] Erreur de conformité : La section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28) est obligatoire dans la section FR-Interpretation-2eme-lecteur-DL2M-FIN (1.2.250.1.213.1.1.2.174).
        </assert>          
        
        <!-- Présence obligatoire de la section FR-Plan-de-soins -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
            [S_Interpretation-2eme-lecteur-DL2M-FIN.sch] Erreur de conformité : La section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) est obligatoire dans la section FR-Interpretation-2eme-lecteur-DL2M-FIN (1.2.250.1.213.1.1.2.174).
        </assert>
        <!-- Présence obligatoire de la section FR-Documents-ajoutes -->
        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.37"]'>
            [S_Interpretation-2eme-lecteur-DL2M-FIN.sch] Erreur de conformité : La section FR-Documents-ajoutes (1.2.250.1.213.1.1.2.37) est obligatoire dans la section FR-Interpretation-2eme-lecteur-DL2M-FIN (1.2.250.1.213.1.1.2.174).
        </assert>  
        
        
    </rule>
    
</pattern>
