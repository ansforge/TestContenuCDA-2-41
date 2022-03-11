<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DICOM_Complications_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-DICOM-Complications (1.2.250.1.213.1.1.2.214) dans le document IMG-CR-IMG qui décrit 
   les conclusions cliniques
   
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    02/02/2022 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_Complications_IMG-CR-IMG">
    <title>CI-SIS IMG-CR-IMG Section Complications </title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.214"]'>
        
        <!-- Vérifier le code de la section 'FR-DICOM-Complications' -->
        <assert test="cda:code[@code='55109-3' and @codeSystem='2.16.840.1.113883.6.1']">
            [S_DICOM_Complications_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, la section FR-DICOM-Complications (1.2.250.1.213.1.1.2.214) doit obligatoirement avoir comme code : @code='55109-3' et @codeSystem='2.16.840.1.113883.6.1'
        </assert>
        
        <!-- Vérifier le texte de la section 'FR-DICOM-Complications' -->
        <assert test="cda:text">
            [S_DICOM_Complications_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, une section FR-DICOM-Complications (1.2.250.1.213.1.1.2.214) doit obligatoirement contenir l'élément texte
        </assert>
        
    </rule>
    
</pattern>