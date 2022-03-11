<?xml version="1.0" encoding="UTF-8"?>

<!--  S_codedPhysicalExam-CSE-CS8
    
    Teste la conformité de la section Examens physiques (Coded Physical Examination - 1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1)
    aux spécifications du volet CSE-CS8 du CI-SIS.
    
    Les sous-sections suivantes sont obligatoires :
    - Signes vitaux (Coded Vital Signs - 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2)
    - Système nerveux (Neurologic System - 1.3.6.1.4.1.19376.1.5.3.1.1.9.35)
    - Système digestif (Abdomen - 1.3.6.1.4.1.19376.1.5.3.1.1.9.31)
    - Système musculo-squelettique (Musculoskeletal System - 1.3.6.1.4.1.19376.1.5.3.1.1.9.34)
    - Système cardiovasculaire (Heart - 1.3.6.1.4.1.19376.1.5.3.1.1.9.29)
    - Système réno-uro-génital (Genitalia - 1.3.6.1.4.1.19376.1.5.3.1.1.9.36)
    - Système auditif (Ears - 1.3.6.1.4.1.19376.1.5.3.1.1.9.21)
    - État général (General Appearance - 1.3.6.1.4.1.19376.1.5.3.1.1.9.16)
    
    Historique :
    25/07/2011 : Création
    11/10/2017 : Ajout du nom du schématron sur les messages d'erreur
    23/02/2021 : Renommage et vérification des sous-sections testées
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedPhysicalExam-CSE-CS8">
    <title>Vérification de la conformité de la section Examens physiques du CSE-CS8</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1"]'> 
        
        <!-- Sous-section Signes vitaux -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2"]'>
            [S_codedPhysicalExam-CSE-CS8] Erreur de conformité : La sous-section Signes vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) est obligatoire.
        </assert>        
        
        <!-- Sous-section Système nerveux -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.35"]'> 
            [S_codedPhysicalExam-CSE-CS8] Erreur de conformité : La sous-section Système nerveux (1.3.6.1.4.1.19376.1.5.3.1.1.9.35) est obligatoire.
        </assert>
        
        <!-- Sous-section Système digestif -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.31"]'> 
            [S_codedPhysicalExam-CSE-CS8] Erreur de conformité : La sous-section Système digestif (1.3.6.1.4.1.19376.1.5.3.1.1.9.31) est obligatoire.
        </assert>
        
        <!-- Sous-section Système musculo-squelettique -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.34"]'>
            [S_codedPhysicalExam-CSE-CS8] Erreur de conformité : La sous-section Système musculo-squelettique (1.3.6.1.4.1.19376.1.5.3.1.1.9.34) est obligatoire.
        </assert> 
        
        <!-- Sous-section Système cardiovasculaire -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.29"]'>
            [S_codedPhysicalExam-CSE-CS8] Erreur de conformité : La sous-section Système cardiovasculaire (1.3.6.1.4.1.19376.1.5.3.1.1.9.29) est obligatoire.
        </assert> 
        
        <!-- Sous-section Système réno-uro-génital -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.36"]'>
            [S_[S_codedPhysicalExam-CSE-CS8] Erreur de conformité : La sous-section Système réno-uro-génital (1.3.6.1.4.1.19376.1.5.3.1.1.9.36) est obligatoire.
        </assert>
        
        <!-- Sous-section Système auditif -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.21"]'>
            [S_codedPhysicalExam-CSE-CS8] Erreur de conformité : La sous-section Système auditif (1.3.6.1.4.1.19376.1.5.3.1.1.9.21) est obligatoire.
        </assert> 
        
        <!-- Sous-section État général -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.16"]'>
            [S_codedPhysicalExam-CSE-CS8] Erreur de conformité : La sous-section État général (1.3.6.1.4.1.19376.1.5.3.1.1.9.16) est obligatoire.
        </assert>
        
    </rule>
</pattern>