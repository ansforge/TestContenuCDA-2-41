<?xml version="1.0" encoding="UTF-8"?>

<!-- E_codedSocialHistory_CSE-CS24.sch 
    
    Vérification des entrées Habitus, Mode de vie (1.3.6.1.4.1.19376.1.5.3.1.4.13.4)
    de la section Habitus, Mode de vie (1.3.6.1.4.1.19376.1.5.3.1.3.16.1) du CSE-CS24.
    
    Historique :
    24/06/2011 : Création
    25/07/2011 : Compatbilité du schematron aux trois volets CS8, CS9, CS24
    06/03/2012 : Supression des références à SNOMED CT
    11/10/2017 : Suppression du teste sur la garde à temps complet et du type de garde
    21/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    15/05/2018 : MAJ par rapport aux modifications du volet
    23/02/2021 : Renommage et vérification des contrôles par rapport au volet
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_codedSocialHistory_CSE-CS24">
    <title>Vérification des entrées Habitus, Mode de vie (1.3.6.1.4.1.19376.1.5.3.1.4.13.4) du CSE-CS24</title>
    
    <!-- ****** Contexte : Section Habitus, Mode de vie ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.16.1"]'>
        
        <!-- Vérification de la présence de l'entrée 'Allaitement au sein' --> 
        <assert test='.//cda:entry/cda:observation/cda:code[@code="11345-6"]/cda:qualifier/cda:value/@code="77318-4"'> 
            [E_codedSocialHistory_CSE-CS9] Erreur de conformité : 
            L'entrée "Allaitement au sein" de code 77318-4 est obligatoire.
        </assert>
        
        <!-- Vérification de la présence de l'entrée 'Nombre d'enfants vivant au foyer' (mère) -->
        <assert test='.//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="MTH"]/cda:code[@code="11345-6"]/cda:qualifier/cda:value/@code="85722-7"'>             
            [E_codedSocialHistory_CSE-CS9] Erreur de conformité : 
            L'entrée "Nombre d'enfants vivant au foyer" de code 85722-7 est obligatoire pour la mère.
        </assert>
        
        <!-- Vérification de la présence de l'entrée 'Type de garde de l'enfant' (mère) -->
        <assert test='.//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="MTH"]/cda:code[@code="11345-6"]/cda:qualifier/cda:value/@code="PAT-048"'>             
            [E_codedSocialHistory_CSE-CS9] Erreur de conformité : 
            L'entrée "Type de garde de l'enfant" de code PAT-048 est obligatoire pour la mère.
        </assert>
        
        <!-- Vérification de la présence de l'entrée 'Profession' (mère) -->
        <assert test='.//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="MTH"]/cda:code[@code="11345-6"]/cda:qualifier/cda:value/@code="ORG-099"'>             
            [E_codedSocialHistory_CSE-CS9] Erreur de conformité : 
            L'entrée "Profession" de code ORG-099 est obligatoire pour la mère.
        </assert> 
        
        <!-- Vérification de la présence de l'entrée 'Profession' (père) -->
        <assert test='.//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="FTH"]/cda:code[@code="11345-6"]/cda:qualifier/cda:value/@code="ORG-099"'>             
            [E_codedSocialHistory_CSE-CS9] Erreur de conformité : 
            L'entrée "Profession" de code ORG-099 est obligatoire pour le père.
        </assert>
        
        <!-- Vérification de la présence de l'entrée 'Activité professionnelle' (mère) -->
        <assert test='.//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="MTH"]/cda:code[@code="11345-6"]/cda:qualifier/cda:value/@code="ORG-075"'>             
            [E_codedSocialHistory_CSE-CS9] Erreur de Cconformité : 
            L'entrée "Activité professionnelle" de code ORG-075 est obligatoire pour la mère.
        </assert>
        
        <!-- Vérification de la présence de l'entrée 'Activité professionnelle' (père) -->
        <assert test='.//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="FTH"]/cda:code[@code="11345-6"]/cda:qualifier/cda:value/@code="ORG-075"'>             
            [E_codedSocialHistory_CSE-CS9] Erreur de Cconformité : 
            L'entrée "Activité professionnelle" de code ORG-075 est obligatoire pour le père.
        </assert>
        
        <!-- Vérification de la présence de l'entrée 'Risque de saturnisme' -->
        <assert test='.//cda:entry/cda:observation/cda:code[@code="11345-6"]/cda:qualifier/cda:value/@code="MED-181"'>             
            [E_codedSocialHistory_CSE-CS9] Erreur de conformité : 
            L'entrée "Risque de saturnisme" de code MED-181 est obligatoire.
        </assert>
        
    </rule>
</pattern>


