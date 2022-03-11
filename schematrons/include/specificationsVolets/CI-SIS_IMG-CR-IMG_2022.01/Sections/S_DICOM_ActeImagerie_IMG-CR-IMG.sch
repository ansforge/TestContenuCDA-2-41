<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   S_DICOM_ActeImagerie_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-DICOM-Acte-imagerie(1.2.250.1.213.1.1.2.206) dans le document IMG-CR-IMG qui décrit 
   la documentation d’un acte d’imagerie.
   
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    29/03/2021 : SBM : Création
    29/04/2021 : ANS : Suppression du controle sur la balise title
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_ActeImagerie_IMG-CR-IMG">
    <title>CI-SIS IMG-CR-IMG Section Acte d'imagerie</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.206"]'>
        
        <!-- Vérifier le code de la section 'FR-DICOM-Acte-imagerie' -->
        <assert test="cda:code[@code='55111-9' and @codeSystem='2.16.840.1.113883.6.1']">
            [S_DICOM_ActeImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : la section FR-DICOM-Acte-imagerie (1.2.250.1.213.1.1.2.206) doit obligatoirement avoir comme code : @code='55111-9' et @codeSystem='2.16.840.1.113883.6.1'
        </assert>
        
        <!-- Vérifier le texte de la section 'FR-DICOM-Acte-imagerie' -->
        <assert test="cda:text">
            [S_DICOM_ActeImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, une section FR-DICOM-Acte-imagerie (1.2.250.1.213.1.1.2.206) doit obligatoirement contenir l'élément texte
        </assert>
        
        <!-- Vérifier l'existence de l'entrée 'FR-DICOM-Technique-imagerie' [1..1]-->
        <assert test="count(.//cda:procedure[cda:templateId/@root='1.2.250.1.213.1.1.3.153'])=1">
            [S_DICOM_ActeImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-Technique-imagerie (1.2.250.1.213.1.1.3.153) doit etre obligatoirement présente [1..1].
        </assert>
        
        <!-- Vérifier l'existence de la sous-section 'FR-DICOM-Complications' -->
        <assert test="count(.//cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.214']) &lt;=1">
            [S_DICOM_ActeImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : la sous-section FR-DICOM-Complications (1.2.250.1.213.1.1.2.214) optionnelle doit etre présente au maximum une seule fois [0..1].
        </assert>
        
        <!-- Vérifier l'existence de la sous-section 'FR-DICOM-Exposition-aux-radiations' -->
        <assert test="count(.//cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.215']) &lt;=1">
            [S_DICOM_ActeImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : la sous-section FR-DICOM-Exposition-aux-radiations (1.2.250.1.213.1.1.2.215) optionnelle doit etre présente au maximum une seule fois [0..1].
        </assert>
        
        <!-- Vérifier l'existence de la sous-section 'FR-DICOM-Object-Catalog' -->
        <assert test="count(.//cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.217'])=1">
            [S_DICOM_ActeImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : la sous-section FR-DICOM-Object-Catalog (1.2.250.1.213.1.1.2.217) doit etre obligatoirement présente [1..1].
        </assert>
    </rule>
    
</pattern>