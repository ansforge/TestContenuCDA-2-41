<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................    
   S_ResultatsExamens_DL2M-FIDD.sch
   Schématron de vérification de la section FR-Resultats-examens dans un document CANCER-D2LM-FIDD
   
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    06/09/2021 : Création
    09/09/2à21 : Modification
  
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ResultatsExamens_DL2M-FIDD">
    <title>Vérification de la section FR-Resultats-examens dans un document CANCER-D2LM-FIDD</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.28"]'>
        
        <!-- Présence obligatoire de l'entrée FR-Acte ("MED-014" "Bilan diagnostic") dans la section FR-Resultats-examens -->
        <assert test='count(.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19"]/cda:code/@code="MED-014")=1'>
            [S_ResultatsExamens_DL2M-FIDD.sch] Erreur de conformité : L'entrée FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19) de code="MED-014" est obligatoire dans la section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28).
        </assert> 
        
        <!-- Présence obligatoire d'au moins une entrée FR-Simple-Observation ("MED-013" "Motif du diagnostic") dans la section FR-Resultats-examens -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-013") &gt;= 1'>
            [S_ResultatsExamens_DL2M-FIDD.sch] Erreur de conformité : Au moins une entrée FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13) de code="MED-013" est obligatoire dans la section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28).
        </assert>        
        
        <!-- Présence obligatoire d'au moins une entrée FR-Simple-Observation ("MED-068" "Techniques sur lesquelles repose le diagnostic") dans la section FR-Resultats-examens -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-068") &gt;= 1'>
            [S_ResultatsExamens_DL2M-FIDD.sch] Erreur de conformité : Au moins une entrée FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13) de code="MED-068" est obligatoire dans la section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28).
        </assert>
        
        <!-- Présence obligatoire de l'entrée FR-Simple-Observation ("MED-018" "Comparaison avec clichés antérieurs") dans la section FR-Resultats-examens -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-018")=1'>
            [S_ResultatsExamens_DL2M-FIDD.sch] Erreur de conformité : L'entrée FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13) de code="MED-018" est obligatoire dans la section FR-Resultats-examens (1.3.6.1.4.1.19376.1.5.3.1.3.28).
        </assert>       
        
       
    </rule>
    
</pattern>
