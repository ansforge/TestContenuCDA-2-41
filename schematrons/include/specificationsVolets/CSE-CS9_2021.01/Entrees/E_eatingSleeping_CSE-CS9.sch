<?xml version="1.0" encoding="UTF-8"?>

<!-- E_eatingSleeping_CSE-CS9
    
    Vérification des entrées Simple observation relatives aux fonctions d'alimentation et du sommeil des documents
    pour la section "Evaluation du statut fonctionnel de l'enfant" / Entrée "Evaluation fonctionnelle du sommeil et de l'alimentation" 
    
    Historique :
    24/06/2011 : Création
    25/07/2011 : Prise en compte des trois volets CS8, CS9, CS24
    11/10/2017 : Ajout du nom du schématron dans les messages d'erreur
    22/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    09/06/2020 : Suppression du contrôle sur l'allergie alimentaire (suite à création nouvelle section Allergies et intolérances)
    24/02/2020 : Renommage et modification des messages d'erreurs    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_eatingSleeping_CSE-CS9">
    <title>Schématrion Entrée Evaluation fonctionnelle du sommeil et de l'alimentation du CSE-CS9</title>
    
    <!-- ****** Contexte = Sous-section Evaluation fonctionnelle du sommeil et de l'alimentation ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.5"]'>
        
        <!-- Troubles du sommeil -->
        <assert test='.//cda:entry/cda:observation/cda:code/@code="D9-74000"'>
            [E_eatingSleeping_CSE-CS9] Erreur de conformité : 
            L'observation "Troubles du sommeil" (D9-74000) est obligatoire.
        </assert>
        <assert test='.//cda:entry/cda:observation[cda:code/@code="D9-74000"]/cda:value/@value'>
            [E_eatingSleeping_CSE-CS9] Erreur de conformité : 
            Le résultat de l'observation "Troubles du sommeil" (D9-74000) est obligatoire (pas de Nullflavor).
        </assert>
        
        <!-- Anorexie et/ou troubles de l'alimentation -->
        <assert test='.//cda:entry/cda:observation/cda:code/@code="D9-13000"'>
            [E_eatingSleeping_CSE-CS9] Erreur de conformité : 
            L'observation "Anorexie et/ou troubles de l'alimentation" (D9-13000) est obligatoire.
        </assert>
        <assert test='.//cda:entry/cda:observation[cda:code/@code="D9-13000"]/cda:value/@value'>
            [E_eatingSleeping_CSE-CS9] Erreur de conformité : 
            Le résultat de l'observation "Anorexie et/ou troubles de l'alimentation" (D9-13000) est obligatoire (pas de Nullflavor).
        </assert>
                
    </rule>
</pattern>
