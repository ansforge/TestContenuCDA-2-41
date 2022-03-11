<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_AntecedentsTransfusionnelsNonCodee-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Antecedents-chirurgicaux-non-code (1.3.6.1.4.1.19376.1.5.3.1.1.9.12) dans le document ANEST-CR-CPA
   
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    22/04/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_AntecedentsTransfusionnelsNonCodee-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Antecedents transfusionnels non codée </title>
    
    
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.12"]'>
        
        <!-- Vérifier le title de la section 'FR-Histoire-transfusionnelle-non-code' -->
        <assert test=".//cda:title/text()='Antécédents transfusionnels'">
            [S_AntecedentsTransfusionnelsNonCodee-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Histoire-transfusionnelle-non-code (1.3.6.1.4.1.19376.1.5.3.1.1.9.12)
            doit obligatoirement contenir le title 'Antécédents transfusionnels'
        </assert>
        
    </rule>
    
</pattern>