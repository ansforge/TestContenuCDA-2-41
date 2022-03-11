<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_AntecedentsHemorragiquesNonCodee-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Antecedents-medicaux-non-code (1.2.250.1.213.1.1.2.2) dans le document ANEST-CR-CPA
   
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    22/04/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_AntecedentsHemorragiquesNonCodee-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Antecedents hémorragiques non codée </title>
    
    
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.2"]'>
        
        <!-- Vérifier le title de la section 'FR-Antecedents-medicaux-non-code' -->
        <assert test=".//cda:title/text()='Antécédents hémorragiques'">
            [S_AntecedentsHemorragiquesNonCodee-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Antecedents-medicaux-non-code (1.2.250.1.213.1.1.2.2)
            doit obligatoirement contenir le title 'Antécédents hémorragiques'
        </assert>
        
    </rule>
    
</pattern>