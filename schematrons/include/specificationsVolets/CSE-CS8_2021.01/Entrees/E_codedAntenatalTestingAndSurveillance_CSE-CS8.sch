<?xml version="1.0" encoding="UTF-8"?>

<!-- E_codedAntenatalTestingAndSurveillance_CSE-CS8
    
    Vérification des sous-entrées de type Simple observation de l'entrée Examen ou surveillance prénataux (1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10) 
    de la section Examens et surveillance prénataux (1.3.6.1.4.1.19376.1.5.3.1.1.21.2.5.1) du CSE-CS8.
    
    Historique :
    25/07/2011 : Création
    21/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    14/05/2018 : Suppression des tests sur l'Ag HBs
    23/02/2021 : Renommage et ajout des contrôles manquants
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_codedAntenatalTestingAndSurveillance_CSE-CS8">
    <title>Vérification des sous-entrées de type Simple observation de l'entrée Examen ou surveillance prénataux (1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10)</title>
    <!-- Contexte : Entrée Examen ou surveillance prénataux -->
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10']">
        
        <!-- Vérifier que l'entrée GEN-078 est présente -->
        <assert test='cda:component/cda:observation/cda:code[@code = "GEN-078"]'>
            [E_codedAntenatalTestingAndSurveillance_CSE-CS8] Erreur de conformité : L'entrée Simple observation de code GEN-078 est obligatoire pour indiquer la présence ou l'absence Dépistage de la trisomie 21. 
        </assert>
        
        <!-- Vérifier que l'entrée ORG-079 est présente -->
        <assert test='cda:component/cda:observation/cda:code[@code = "ORG-079"]'>
            [E_codedAntenatalTestingAndSurveillance_CSE-CS8] Erreur de conformité : L'entrée Simple observation de code ORG-079 est obligatoire pour indiquer le nombre total d'échographies. 
        </assert>
        <!-- Vérifier que la valeur de l'entrée ORG-079 est exprimée en INT -->
        <assert test='cda:component/cda:observation[cda:code/@code = "ORG-079"]/cda:value[@xsi:type="INT"] '>
            [E_codedAntenatalTestingAndSurveillance_CSE-CS8] Erreur de conformité : Pour le nombre d'échographies, l'attribut @xsi:type="INT" dans l'élément 'value'.
        </assert>
        
        <!-- Vérifier que l'entrée ORG-080 est présente -->
        <assert test='cda:component/cda:observation/cda:code[@code = "ORG-080"]'>
            [E_codedAntenatalTestingAndSurveillance_CSE-CS8] Erreur de conformité : L'entrée Simple observation de code ORG-080 est obligatoire pour indiquer la présence ou l'absence d'échographie morphologique. 
        </assert>
        
        <!-- Vérifier que l'entrée 51659-1 est présente -->
        <assert test='cda:component/cda:observation/cda:code[@code = "51659-1"]'>
            [E_codedAntenatalTestingAndSurveillance_CSE-CS8] Erreur de conformité : L'entrée Simple observation de code 51659-1 est obligatoire pour indiquer la présence ou l'absence d'Hépatite B. 
        </assert>
        
        <!-- Vérifier que l'entrée GEN-079 est présente -->
        <assert test='cda:component/cda:observation/cda:code[@code = "GEN-079"]'>
            [E_codedAntenatalTestingAndSurveillance_CSE-CS8] Erreur de conformité : L'entrée Simple observation de code GEN-079 est obligatoire pour indiquer la présence ou l'absence d'Entretien prénatal précoce. 
        </assert>
        
    </rule>
</pattern>