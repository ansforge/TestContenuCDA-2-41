<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_PlanDeSoins_IMG-DA-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section  FR-Plan-de-soins (1.2.250.1.213.1.1.2.158) dans le document IMG-DA-IMG qui décrit 
   Modalité et région anatomique-organe/ Délai souhaité / Urgence vitale ou fonctionnelle (hors urgence organisationnelle) .
   
   IMG-DA-IMG : Demande d'acte d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    05/01/2022 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_PlanDeSoins_IMG-DA-IMG">
    <title>CI-SIS IMG-DA-IMG Section plan de soins</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.158"]'>
        
        <!-- présence de l'entrée FR-Acte(1.2.250.1.213.1.1.3.62) --> 
        <assert test="count(.//cda:procedure[cda:templateId/@root='1.2.250.1.213.1.1.3.62']) &gt;=1"> 
            [S_PlanDeSoins_IMG-DA-IMG] Erreur de conformité au modèle IMG-DA-IMG : L'entrée "FR-Acte" (1.2.250.1.213.1.1.3.62) doit être présente une ou plusieurs fois [1..*].
        </assert>
        
    </rule>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.62"]'>
        <!-- Vérifier l'existence de l'élément code de l'entrée "FR-Acte" (1.2.250.1.213.1.1.3.62) -->
        <assert test="cda:code"> 
            [S_PlanDeSoins_IMG-DA-IMG] Erreur de conformité au modèle IMG-DA-IMG : L'entrée FR-Acte(1.2.250.1.213.1.1.3.62) doit obligatoirement contenir un élément code.
        </assert>
        
        <!-- Vérifier l'existence de l'élément targetSiteCode dans l'entrée FR-Acte(1.2.250.1.213.1.1.3.62) ' -->
        <assert test="cda:targetSiteCode"> 
            [S_PlanDeSoins_IMG-DA-IMG] Erreur de conformité au modèle IMG-DA-IMG : L'entrée FR-Acte(1.2.250.1.213.1.1.3.62) doit obligatoirement contenir un élément targetSiteCode.
        </assert>
        
        <!-- Vérifier l'existence du caractère urgent d'un examen -->
        <assert test="count(cda:priorityCode) &lt;2"> 
            [S_PlanDeSoins_IMG-DA-IMG] Erreur de conformité au modèle IMG-DA-IMG : L'entrée FR-Acte(1.2.250.1.213.1.1.3.62) doit obligatoirement contenir un élément priorityCode.
        </assert>
        
        <!-- Vérifier l'existence de la justification de l'urgence si l'examen est urgent -->
        <assert test="(cda:priorityCode/@code='UR' and cda:priorityCode/cda:originalText/cda:reference) or (not(cda:priorityCode/@code='UR') and not(cda:priorityCode/cda:originalText/cda:reference))"> 
            [S_PlanDeSoins_IMG-DA-IMG] Erreur de conformité au modèle IMG-DA-IMG : Si priorityCode/@code='UR', l'élément priorityCode doit obligatoirement contenir originalText/reference 
            sinon si priorityCode/@code est différent de 'UR', l'élément priorityCode/originalText/reference ne doit pas exister.
        </assert>
        
      <!--  <assert test="((cda:code/@code='PT' or cda:code/@code='NM') and cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code='MED-1131')
            or (cda:code/@code!='PT' and cda:code/@code!='NM' and cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code!='MED-1131')">
            [S_PlanDeSoins_IMG-DA-IMG] Erreur de conformité au modèle IMG-DA-IMG : Si code/@code='PT' ou bien code/@code='NM', l'entryRelationship FR-Simple-Observation ayant comme code/@code='MED-1131' doit 
            obligatoirement exister (si la modalité d'examen est TEP ou bien Scintigraphie, la fontion étudiée doit obligatoirement exister)..
        </assert>-->
    </rule>
    
</pattern>