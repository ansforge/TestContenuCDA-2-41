<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   S_AntecedentChirurgicaux_CRANEST
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Antecedents-chirurgicaux (1.3.6.1.4.1.19376.1.5.3.1.3.11) dans le document CR-ANEST 
   
   CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    28/09/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_AntecedentsChirurgicaux_CRANEST">
    <title>CI-SIS CR-ANEST Section Antécédents chirurgicaux </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.11"]'>
        <!-- Vérifier le title de la section 'FR-Antecedents-chirurgicaux' -->
        <assert test='.//cda:title/text()="Antécédents chirurgicaux ayant nécessité une anesthésie"'>
            [S_ActesEtInterventions_CRANEST] Erreur de conformité au modèle CR-ANEST : Une section FR-Antecedents-chirurgicaux (1.3.6.1.4.1.19376.1.5.3.1.3.11) doit obligatoirement contenir le title 'Antécédents chirurgicaux ayant nécessité une anesthésie'
        </assert>
        <!-- Vérifier que la section 'FR-Antecedents-chirurgicaux' contient l'entrée FR-Acte  -->
        <assert test='.//count(cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19"])&gt;=1'>
            [S_AntecedentsChirurgicaux_CRANEST] Erreur de conformité au modèle CR-ANEST : Une section FR-Antecedents-chirurgicaux (1.3.6.1.4.1.19376.1.5.3.1.3.11) doit obligatoirement contenir une ou plusieurs entrées de type FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19).
        </assert>
        
    </rule>
    
</pattern>
