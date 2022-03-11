<?xml version="1.0" encoding="UTF-8"?>

<!--  S_codedPhysicalExam_CSE-CS9.sch 
    
    Teste la conformité de la section Examens physiques (Coded Physical Examination - 1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1)
    aux spécifications du volet CSE-CS9 du CI-SIS.
    
    Les sous-sections suivantes sont obligatoires :
    - Signes vitaux (Coded Vital Signs - 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2)
    - Système nerveux (Neurologic System - 1.3.6.1.4.1.19376.1.5.3.1.1.9.35)
    - Système digestif (Abdomen - 1.3.6.1.4.1.19376.1.5.3.1.1.9.31)
    - Système musculo-squelettique (Musculoskeletal System - 1.3.6.1.4.1.19376.1.5.3.1.1.9.34)
    - Système réno-uro-génital (Genitalia - 1.3.6.1.4.1.19376.1.5.3.1.1.9.36)
    - Système cardiovasculaire (Heart - 1.3.6.1.4.1.19376.1.5.3.1.1.9.29)
    - Système auditif (Ears - 1.3.6.1.4.1.19376.1.5.3.1.1.9.21)
    - Système respiratoire (Respiratory System - 1.3.6.1.4.1.19376.1.5.3.1.1.9.30)
    - Système endocrinien et métabolique (Endocrine System - 1.3.6.1.4.1.19376.1.5.3.1.1.9.25)    
    - Système tégumentaire (Integumentary System - 1.3.6.1.4.1.19376.1.5.3.1.1.9.17)
    - Système lymphatique-hématologique-immunolique (Lymphatic System - 1.3.6.1.4.1.19376.1.5.3.1.1.9.32)
    - Système occulaire (Eyes - 1.3.6.1.4.1.19376.1.5.3.1.1.9.19)
    - Stomatologie (Mouth and Throat and Teeth - 1.3.6.1.4.1.19376.1.5.3.1.1.9.23)
    - État général (General Appearance - 1.3.6.1.4.1.19376.1.5.3.1.1.9.16)
            
    Historique :
    25/07/2011 : Création
    11/10/2017 : Renseignement du nom du schematron sur les messages d'erreur
    23/02/2021 : Renommage et vérification des sous-sections testées
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedPhysicalExam_CSE-CS9">
    <title>Vérification de la conformité de la section Examens physiques du CSE-CS9</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1"]'> 
       
        <!-- Sous-section Signes vitaux -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Signes vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) est obligatoire.
        </assert>
        
        <!-- Sous-section Système nerveux -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.35"]'> 
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système nerveux (1.3.6.1.4.1.19376.1.5.3.1.1.9.35) est obligatoire.
        </assert>
        
        <!-- Sous-section Système digestif -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.31"]'> 
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système digestif (1.3.6.1.4.1.19376.1.5.3.1.1.9.31) est obligatoire.
        </assert> 
        
        <!-- Sous-section Système musculo-squelettique -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.34"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système musculo-squelettique (1.3.6.1.4.1.19376.1.5.3.1.1.9.34) est obligatoire.
        </assert> 
        
        <!-- Sous-section Système réno-uro-génital -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.36"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système réno-uro-génital (1.3.6.1.4.1.19376.1.5.3.1.1.9.36) est obligatoire.
        </assert>
        
        <!-- Sous-section Système cardiovasculaire -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.29"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système cardiovasculaire (1.3.6.1.4.1.19376.1.5.3.1.1.9.29) est obligatoire.
        </assert> 
        
        <!-- Sous-section Système auditif -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.21"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système auditif (1.3.6.1.4.1.19376.1.5.3.1.1.9.21) est obligatoire.
        </assert> 
        
        <!-- Sous-section Système respiratoire -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.30"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système respiratoire (1.3.6.1.4.1.19376.1.5.3.1.1.9.30) est obligatoire.
        </assert>        
        
        <!-- Sous-section Système endocrinien et métabolique -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.25"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système endocrinien et métabolique (1.3.6.1.4.1.19376.1.5.3.1.1.9.25) est obligatoire.
        </assert>
        
        <!-- Sous-section Système tégumentaire -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.17"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système tégumentaire (1.3.6.1.4.1.19376.1.5.3.1.1.9.17) est obligatoire.
        </assert>
        
        <!-- Sous-section Système lymphatique-hématologique-immunolique -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.32"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système lymphatique-hématologique-immunolique (1.3.6.1.4.1.19376.1.5.3.1.1.9.32) est obligatoire.
        </assert>
        
        <!-- Sous-section Système occulaire -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.19"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Système occulaire (1.3.6.1.4.1.19376.1.5.3.1.1.9.19) est obligatoire.
        </assert>
        
        <!-- Sous-section Stomatologie -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.23"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section Stomatologie (1.3.6.1.4.1.19376.1.5.3.1.1.9.23) est obligatoire.
        </assert>
        
        <!-- Sous-section État général -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.16"]'>
            [S_codedPhysicalExam_CSE-CS9] Erreur de conformité : La sous-section État général (1.3.6.1.4.1.19376.1.5.3.1.1.9.16) est obligatoire.
        </assert>
        
    </rule>
</pattern>