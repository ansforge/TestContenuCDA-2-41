<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_SignesVitaux-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) dans le document ANEST-CR-CPA 
   Section FR-Signes-vitaux : Taille, Poids, IMC, Pression artérielle, Fréquence cardiaque, Saturation en oxygène
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    04/01/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_SignesVitaux-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Signes vitaux </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2"]'>
        
        
        <!-- Vérifier le title de la section 'FR-Signes-vitaux' -->
        <assert test='.//cda:title/text()="Signes vitaux (Données biométriques)"'>
            [S_SignesVitaux-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir le title 'Signes vitaux (Données biométriques)'
        </assert>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.1"]'>
        <!-- Vérifier que la section 'FR-Signes-vitaux' contient [1..1] entrée Entrée FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" : Taille(cm) -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" and cda:code/@code="8302-2"])=1'>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='8302-2'.
        </assert>
        
        <!-- Vérifier que la section 'FR-Signes-vitaux' contient [1..1] entrée Entrée FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" : Poids(kg) -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" and cda:code/@code="29463-7"])=1'>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='29463-7'.
        </assert>
        
        <!-- Vérifier que la section 'FR-Signes-vitaux' contient [1..1] entrée Entrée FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" : IMC -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" and cda:code/@code="39156-5"])=1'>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='39156-5'.
        </assert>
        
        <!-- Vérifier que la section 'FR-Signes-vitaux' contient [1..1] entrée Entrée FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" : Pression artérielle systolique -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" and cda:code/@code="8480-6"])=1'>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='8480-6'.
        </assert>
        
        <!-- Vérifier que la section 'FR-Signes-vitaux' contient [1..1] entrée Entrée FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" : Pression artérielle diastolique -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" and cda:code/@code="8462-4"])=1'>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='8462-4'.
        </assert>
        
        <!-- Vérifier que la section 'FR-Signes-vitaux' contient [1..1] entrée Entrée FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" : Fréquence cardiaque -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" and cda:code/@code="8867-4"])=1'>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='8867-4'.
        </assert>
        
        <!-- Vérifier que la section 'FR-Signes-vitaux' contient [1..1] entrée Entrée FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" : Saturation en oxygène -->
        <assert test='count(.//cda:observation[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13.2" and cda:code/@code="2708-6"])=1'>
            [S_SignesVitaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Signes-vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) doit obligatoirement contenir une entrée [1..1] FR-Signe-vital-observé "1.3.6.1.4.1.19376.1.5.3.1.4.13.2"
            avec un élément code dont l'attribut @code='2708-6'.
        </assert>
        
    </rule>
</pattern>
            
            