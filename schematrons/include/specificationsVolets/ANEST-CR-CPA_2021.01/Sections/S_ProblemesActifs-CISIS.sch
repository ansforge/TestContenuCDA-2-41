<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_ProblemesActifs-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Problemes-actifs (1.3.6.1.4.1.19376.1.5.3.1.3.6) dans le document ANEST-CR-CPA 
   Section FR-Problemes-actifs : Pathologies chroniques
   
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    04/01/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ProblemesActifs-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Problèmes actifs </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.6"]'>
        <!-- Vérifier le title de la section 'FR-Problemes-actifs' -->
        <assert test='.//cda:title/text()="Liste des problèmes actifs (Pathologies chroniques)"'>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe,
            une section FR-Problemes-actifs (1.3.6.1.4.1.19376.1.5.3.1.3.6) doit obligatoirement contenir le title 'Liste des problèmes actifs (Pathologies chroniques)'
        </assert>
        
        <!-- Vérifier le code de la section 'FR-Problemes-actifs' -->
        <assert test='.//cda:code/@code="11450-4"'>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe,
            une section FR-Problemes-actifs (1.3.6.1.4.1.19376.1.5.3.1.3.6) doit obligatoirement contenir un élément code dont l'attribut @code='11450-4'.
        </assert>
        
        <!-- Vérifier la cardinalité de l'entrée 'FR-Liste-des-problemes' -->
        <assert test='count(./cda:entry[cda:act/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5.2"]) &lt;= 1'>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Problemes-actifs doit obligatoirement contenir [0..1] entrée FR-Liste-des-problemes(1.3.6.1.4.1.19376.1.5.3.1.4.5.2).
        </assert>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.6"]/cda:entry/cda:act[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5.2"]'>
        
        <!-- Vérifier les cardinalités des entryRelationships FR-Probleme[0..*] dans l'entrée 'FR-Liste-des-problemes' -->
        <assert test='count(./cda:entryRelationship[cda:observation/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5"]) &gt;= 0'>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Liste-des-problemes(1.3.6.1.4.1.19376.1.5.3.1.4.5.2) doit obligatoirement contenir [0..*] entryRelationship FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5).
        </assert>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5"]'>
        <!-- Vérifier la cardinalité de l'entryRelationship FR-Commentaire-ER [0..1] dans l'entrée 'FR-Probleme' -->
        <assert test='count(.//cda:entryRelationship[cda:act/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.2"])&lt;= 1'>
            [S_ProblemesActifs-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Probleme doit obligatoirement contenir [0..1] entryRelationship FR-Commentaire-ER '1.3.6.1.4.1.19376.1.5.3.1.4.2'.
        </assert>
    </rule>
</pattern>

