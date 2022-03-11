<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................    
   S_bilanCancerologie_D2LM-FIN
   Schématron de vérification de la conformité au modèle du CI-SIS d'une section FR-Bilan-cancerologie (1.2.250.1.213.1.1.2.59) dans un document D2LM-FIN 
   
   D2LM : CR de seconde lecture de mammographie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    23/10/2017 : NMA : Création
    30/07/2020 : SBM : Modification du nom du schématron dans le dernier test
   ......................................................................................................................................................    
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_bilanCancerologie_D2LM-FIN">
    <title>CI-SIS D2LM-FIN Section Bilan Cancérologie</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.59"]'>
        <!-- Présence obligatoire de la section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.28"]'>
            [S_bilanCancerologie_D2LM-FIN.sch] Erreur de conformité au modèle D2LM : La section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28) est obligatoire dans la section FR-Bilan-cancerologie (1.2.250.1.213.1.1.2.59).
        </assert>
        <!-- Présence obligatoire de la section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
            [S_bilanCancerologie_D2LM-FIN.sch] Erreur de conformité au modèle D2LM : La section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) est obligatoire dans la section FR-Bilan-cancerologie (1.2.250.1.213.1.1.2.59).
        </assert>  
        <!-- Présence obligatoire de la section FR-Resultats-evenements-non-code (1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9"]'>
            [S_bilanCancerologie_D2LM-FIN.sch] Erreur de conformité au modèle D2LM : La section FR-Resultats-evenements-non-code (1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9) est obligatoire dans la section FR-Bilan-cancerologie (1.2.250.1.213.1.1.2.59).
        </assert>  
       
        <assert test='.//cda:code[@code = "72135-7"]'>
            [S_bilanCancerologie_D2LM-FIN.sch] Erreur de conformité au modèle D2LM : Le code de la section FR-Bilan-cancerologie (1.2.250.1.213.1.1.2.59) doit être "72135-7"
        </assert>  
        <assert test='.//cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_bilanCancerologie_D2LM-FIN.sch] Erreur de conformité au modèle D2LM : Le code de la section FR-Bilan-cancerologie (1.2.250.1.213.1.1.2.59) doit faire partie de la nomenclature LOINC
        </assert>  
        
    </rule>
    
</pattern>