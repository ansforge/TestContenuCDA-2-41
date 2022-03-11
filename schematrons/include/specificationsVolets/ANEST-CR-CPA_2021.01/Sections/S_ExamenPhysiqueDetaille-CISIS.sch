<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................    
   S_ExamenPhysiqueDetaille-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Examen-physique-detaille-code (1.2.250.1.213.1.1.2.84) dans le document ANEST-CR-CPA.
   
    ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    04/01/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ExamenPhysiqueDetaille-CISIS">
    <title>CI-SIS ANEST-CR-CPA Examen physique détaillé</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15"]'> 
        
        <!-- Système respiratoire -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.30"]'>
            [S_ExamenPhysiqueDetaille-CISIS.sch] Erreur de Conformité au volet ANEST-CR-CPA: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section'Système respiratoire'.
        </assert>
        
        <!-- Vaisseaux -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.33"]'>
            [S_ExamenPhysiqueDetaille-CISIS.sch] Erreur de Conformité au volet ANEST-CR-CPA: La section 'FR-Examen-physique-detaille-code' doit obligatoirement contenir [1..1] sous-section 'Vaisseaux'.
        </assert> 
        
    </rule>
    
    
    <!-- Sous-section Vaisseaux -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.33"]'> 
        
        <!--  Vérifier le code de l'accès veineux difficile -->
        <assert test='.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13" and cda:code/@code="MED-593"]'>
            [S_ExamenPhysiqueDetaille-CISIS.sch] Erreur de Conformité au volet ANEST-CR-CPA: La sous-section Vaisseaux(1.3.6.1.4.1.19376.1.5.3.1.1.9.33) doit obligatoirement contenir
            [1..1] entrée FR-Simple-Observation(1.2.250.1.213.1.1.3.48) avec un élément code dont l'attribut @code='MED-593'.
        </assert> 
        
    </rule>
    
    
    <!-- Sous-section Système respiratoire -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.30"]'> 
        <!-- Variables -->
        <let name="scoreMallampati" value=".//cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code='MED-638'"/>
        <let name="ouvertureBouche" value=".//cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code='MED-639'"/>
        <let name="distanceThyromentonnière" value=".//cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code='MED-640'"/>
        
        <!--  Vérifier les codes de score de Mallampati, ouverture de la bouche et distance thyromentonnière -->
        <assert test='not(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]) or
            (.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"] and
            ($scoreMallampati or $ouvertureBouche or $distanceThyromentonnière))'>
            [S_ExamenPhysiqueDetaille-CISIS.sch] Erreur de Conformité au volet ANEST-CR-CPA: La sous-section Système respiratoire(1.3.6.1.4.1.19376.1.5.3.1.1.9.30) peut contenir
            [0..3] entrée(s) FR-Simple-Observation(1.2.250.1.213.1.1.3.48) avec un élément code dont l'attribut @code='MED-638' ou @code='MED-639' ou  @code='MED-640'.
        </assert> 
        
    </rule>
</pattern>