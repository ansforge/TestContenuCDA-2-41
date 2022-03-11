<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_PlanDeSoins_ANEST-CR-ANEST.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Plan-de-soins (1.2.250.1.213.1.1.2.158) dans le document ANEST-CR-ANEST 
   Section FR-Plan-de-soins : Surveillance post-opératoire
   ANEST-CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    24/11/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_PlanDeSoins_ANEST-CR-ANEST">
    <title>CI-SIS ANEST-CR-ANEST Section Plan de soins </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
        
        <!-- Vérifier le title de la section 'FR-Plan-de-soins' -->
        <assert test='.//cda:title/text()="Surveillance post-opératoire"'>
            [S_PlanDeSoins_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit obligatoirement contenir le title 'Surveillance post-opératoire'
        </assert>
        
        <!-- Vérifier la cardinalité l'entrée FR-Demande-d-examen-ou-de-suivi : Ambulatoire-->
        <assert test='count(.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1" and cda:code/@code="AMBULATOIRE"]) &lt;= 1'>
            [S_PlanDeSoins_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit contenir [0..1] 
            entrée FR-Demande-d-examen-ou-de-suivi '1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1' dont l'attribut de l'élément code est @code="AMBULATOIRE".
        </assert>
        
        <!-- Vérifier la cardinalité l'entrée FR-Demande-d-examen-ou-de-suivi : SSPI / USI / Réanimation -->
        <assert test='count(.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1" and cda:code/@code="ETABLISSEMENT"]) &lt;=1'>
            [S_PlanDeSoins_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit contenir [0..1] 
            entrée FR-Demande-d-examen-ou-de-suivi '1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1' dont l'attribut de l'élément code est @code="ETABLISSEMENT".
        </assert>
        
        <!-- Vérifier le code l'entrée FR-Demande-d-examen-ou-de-suivi : Ambulatoire-->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1"]/cda:code[@code="AMBULATOIRE"]'>
            [S_PlanDeSoins_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit obligatoirement 
            contenir l'élément code avec un attribut @code="AMBULATOIRE".
        </assert>
        
        <!-- Vérifier le code l'entrée FR-Demande-d-examen-ou-de-suivi : SSPI / USI / Réanimation -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1"]/cda:code[@code="ETABLISSEMENT"]'>
            [S_PlanDeSoins_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Plan-de-soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) doit obligatoirement 
            contenir l'élément code avec un attribut @code="ETABLISSEMENT".
        </assert>
        <!-- Vérifier le code l'entrée FR-Demande-d-examen-ou-de-suivi : SSPI / USI / Réanimation -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1" and cda:code/@code="ETABLISSEMENT"]//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.2"]/cda:code/@code="8310-5"'>
            [S_PlanDeSoins_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, l'entrée FR-Demande-d-examen-ou-de-suivi : SSPI / USI / Réanimation peut 
            contenir l'entrée FR-Simple-Observation(température corporelle) qui doit avoir obligatoirement l'élément code avec un attribut @code="8310-5".
        </assert>
    </rule>
    
</pattern>

