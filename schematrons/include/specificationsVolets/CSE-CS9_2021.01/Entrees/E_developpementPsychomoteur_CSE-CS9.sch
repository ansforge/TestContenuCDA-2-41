<?xml version="1.0" encoding="UTF-8"?>


<!--  E_developpementPsychomoteur_CSE-CS9.sch
    
    Vérification des entrées FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13) de la sous-section FR-Developpement-psychomoteur (1.3.6.1.4.1.19376.1.7.3.1.1.13.4) du CSE-CS9
    
    Historique :
    01/06/2021 : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_developpementPsychomoteur_CSE-CS9">
    <title>Vérification des entrées FR-Simple-Observation de la sous-section FR-Developpement-psychomoteur du CSE-CS9</title>
    
    <!-- ****** Contexte = sous-section FR-Developpement-psychomoteur ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.4"]'>
        
        <!-- Vérifier que le code de l'entrée 'Tient assis sans appui' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-190"'>
            [E_developpementPsychomoteur_CSE-CS9] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-190" est obligatoire pour indiquer la présence de 'Tient assis sans appui'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Réagit à son prénom' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-191"'>
            [E_developpementPsychomoteur_CSE-CS9] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-191" est obligatoire pour indiquer ou la présence de 'Réagit à son prénom'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée ' Répète une syllabe' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-192"'>
            [E_developpementPsychomoteur_CSE-CS9] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-192" est obligatoire pour indiquer la présence de 'Répète une syllabe'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Se déplace' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-193"'>
            [E_developpementPsychomoteur_CSE-CS9] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-193" est obligatoire pour indiquer la présence de 'Se déplace'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Saisit un objet avec participation du pouce' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-194"'>
            [E_developpementPsychomoteur_CSE-CS9] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-194" est obligatoire pour indiquer la présence de 'Saisit un objet avec participation du pouce'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Imite un geste simple (au revoir/bravo)' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="GEN-082"'>
            [E_developpementPsychomoteur_CSE-CS9] Erreur de conformité : L'entrée FR-Simple-Observation de code "GEN-082" est obligatoire pour indiquer la présence de 'Imite un geste simple (au revoir/bravo)'.
        </assert>
        
        <!-- Vérifier que le code de l'entrée 'Motricité symétrique des 4 membres' est présent -->
        <assert test='.//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="MED-195"'>
            [E_developpementPsychomoteur_CSE-CS9] Erreur de conformité : L'entrée FR-Simple-Observation de code "MED-195" est obligatoire pour indiquer la présence de 'Motricité symétrique des 4 membres'.
        </assert>
    </rule>
</pattern>

