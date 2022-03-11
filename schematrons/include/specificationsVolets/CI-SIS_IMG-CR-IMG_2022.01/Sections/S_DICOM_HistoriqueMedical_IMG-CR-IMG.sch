<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DICOM_HistoriqueMedical_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-DICOM-Historique-medical(2.16.840.1.113883.10.20.22.2.39) dans le document IMG-DA-IMG qui décrit 
   la documentation d’une demande d'acte d’imagerie.
   
   IMG-DA-IMG : Demande d'acte d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    10/01/2022 : ANS : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_HistoriqueMedical_IMG-CR-IMG">
    <title>CI-SIS IMG-DA-IMG Section Historique médical</title>
    
    <rule context='*[cda:templateId/@root="2.16.840.1.113883.10.20.22.2.39"]'>
        
        <!-- Vérifier le code de la section 'FR-DICOM-Historique-medical' -->
        <assert test="cda:code[@code='11329-0' and @codeSystem='2.16.840.1.113883.6.1']">
            [S_DICOM_HistoriqueMedical_IMG-CR-IMG] Erreur de conformité au modèle IMG-DA-IMG : la section FR-DICOM-Historique-medical(2.16.840.1.113883.10.20.22.2.39) doit obligatoirement avoir comme code : @code='11329-0' et @codeSystem='2.16.840.1.113883.6.1'
        </assert>
        
        <!-- Vérifier le texte de la section 'FR-DICOM-Historique-medical' -->
        <assert test="cda:text">
            [S_DICOM_HistoriqueMedical_IMG-CR-IMG] Erreur de conformité au modèle IMG-DA-IMG :  la section FR-DICOM-Historique-medical(2.16.840.1.113883.10.20.22.2.39) doit obligatoirement contenir l'élément texte
        </assert>
        
        <!-- Vérifier l'existence de l'entrée 'FR-DICOM-Observation'  : Antécédents médicaux [1..1]-->
        <assert test="count(.//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.150' and cda:code/@code='11348-0'])=1">
            [S_DICOM_HistoriqueMedical_IMG-CR-IMG] Erreur de conformité au modèle IMG-DA-IMG : l'entrée  'FR-DICOM-Observation' : Antécédents médicaux (1.2.250.1.213.1.1.3.150) doit etre obligatoirement présente [1..1] et doit avoir comme code : @code='11348-0' et @codeSystem='2.16.840.1.113883.6.1'.
        </assert>
        
        <!-- Vérifier l'existence de l'entrée 'FR-DICOM-Observation'  : Antécédents chirurgicaux [1..1]-->
        <assert test="count(.//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.150' and cda:code/@code='47519-4'])=1">
            [S_DICOM_HistoriqueMedical_IMG-CR-IMG] Erreur de conformité au modèle IMG-DA-IMG : l'entrée  'FR-DICOM-Observation' : Antécédents chirurgicaux (1.2.250.1.213.1.1.3.150) doit etre obligatoirement présente [1..1] et doit avoir comme code : @code='47519-4' et @codeSystem='2.16.840.1.113883.6.1'.
        </assert>
        
        <!-- Vérifier l'existence de l'entrée 'FR-DICOM-Observation'  : Contre-indications [1..1]-->
        <assert test="count(.//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.150' and cda:code/@code='64100-1']) =1">
            [S_DICOM_HistoriqueMedical_IMG-CR-IMG] Erreur de conformité au modèle IMG-DA-IMG : l'entrée  'FR-DICOM-Observation' : Contre-indications (1.2.250.1.213.1.1.3.150) doit etre obligatoirement présente [1..1] et doit avoir comme code : @code='64100-1' et @codeSystem='2.16.840.1.113883.6.1'.
        </assert>
        
    </rule>
    
</pattern>