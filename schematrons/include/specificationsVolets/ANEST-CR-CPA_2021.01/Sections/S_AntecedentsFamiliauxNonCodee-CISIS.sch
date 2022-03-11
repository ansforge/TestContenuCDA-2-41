<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_AntecedentsFamiliauxNonCodee-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Antecedents-familiaux-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.14) dans le document ANEST-CR-CPA
   
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    04/01/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_AntecedentsFamiliauxNonCodee-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Antecedents familiaux non codée </title>
    
    
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.14"]'>
        
        <!-- Vérifier le title de la section 'FR-Antecedents-familiaux-non-code' -->
        <assert test=".//cda:title/text()='Antécédents familiaux'">
            [S_AntecedentsFamiliauxNonCodee-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Antecedents-familiaux-non-code (1.3.6.1.4.1.19376.1.5.3.1.3.14)
            doit obligatoirement contenir le title 'Antécédents familiaux'
        </assert>
        
    </rule>
    
</pattern>