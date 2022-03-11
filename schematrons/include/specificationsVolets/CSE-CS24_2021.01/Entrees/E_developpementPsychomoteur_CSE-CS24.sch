<?xml version="1.0" encoding="UTF-8"?>


<!--  E_developpementPsychomoteur_CSE-CS24.sch
    
    Vérification des entrées FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13) de la sous-section FR-Developpement-psychomoteur (1.3.6.1.4.1.19376.1.7.3.1.1.13.4) du CSE-CS24
    
    Historique :
    01/06/2021 : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_developpementPsychomoteur_CSE-CS24">
    <title>Vérification des entrées FR-Simple-Observation de la sous-section FR-Developpement-psychomoteur du CSE-CS24</title>
    
    <!-- ****** Contexte = sous-section FR-Developpement-psychomoteur ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.4"]'>
        
        <!-- Vérifier que le code de l'entrée 'Comprend une consigne simple' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-196"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-196" est obligatoire pour indiquer la présence de 'Comprend une consigne simple'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Nomme au moins une image' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-197"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-197" est obligatoire pour indiquer ou la présence de 'Nomme au moins une image'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Superpose des objets' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-198"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-198" est obligatoire pour indiquer la présence de 'Superpose des objets'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Associe deux mots' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-199"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-199" est obligatoire pour indiquer la présence de 'Associe deux mots'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Marche acquise' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-200"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-200" est obligatoire pour indiquer la présence de 'Marche acquise'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Âge de la marche acquise' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-201"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-201" est obligatoire pour indiquer la présence de 'Âge de la marche acquise'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Pointe du doigt' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-202"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-202" est obligatoire pour indiquer la présence de 'Pointe du doigt'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Joue à faire semblant' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="GEN-083"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "GEN-083" est obligatoire pour indiquer la présence de 'Joue à faire semblant'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Sollicite un adulte/une autre personne' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="GEN-084"'>
            [E_developpementPsychomoteur_CSE-CS24] Erreur de conformité : L'entrée FR-Simple-Observation de code "GEN-084" est obligatoire pour indiquer la présence de 'Sollicite un adulte/une autre personne'.
        </assert>
    </rule>
</pattern>

