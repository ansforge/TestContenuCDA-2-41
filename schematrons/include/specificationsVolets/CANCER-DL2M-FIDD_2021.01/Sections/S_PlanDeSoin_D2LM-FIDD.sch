<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................    
   S_PlanDeSoin_D2LM-FIDD.sch
   Schématron de vérification de la section FR-Plan-de-soins dans un document CANCER-D2LM-FIDD 
   
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    06/09/2021 : Création
    09/09/2021 : Modification (à revoir car ne semble pas fonctionner)
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_PlanDeSoin_D2LM-FIDD">
    <title>Vérification de la section FR-Plan-de-soins dans un document CANCER-D2LM-FIDD</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
        
        <!-- Présence obligatoire de l'entrée FR-Demande-d-examen-ou-de-suivi (Conduite à tenir) dans la section  FR-Plan-de-soins -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1"]/cda:code/@code="GEN-007") = 1'>
            [S_PlanDeSoin_D2LM-FIDD.sch] Erreur de conformité : Une entrée FR-Demande-d-examen-ou-de-suivi (1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1) de code "GEN-007" (Conduite à tenir) est obligatoire dans la section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36).
        </assert>
        
    </rule>
    
</pattern>