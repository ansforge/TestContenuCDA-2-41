<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DICOM_ExamenComparatif_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-DICOM-Examen-comparatif(1.2.250.1.213.1.1.2.207) dans le document IMG-CR-IMG qui décrit 
   la documentation d’un acte d’imagerie antérieur à lequel les images actuelles ont été comparées.
   
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    29/03/2021 : SBM : Création
    29/04/2021 : ANS : Suppression du controle sur la balise title
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_ExamenComparatif_IMG-CR-IMG">
    <title>CI-SIS IMG-CR-IMG Section Examen Comparatif</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.207"]'>
        
        <!-- Vérifier le code de la section 'FR-DICOM-Examen-comparatif' -->
        <assert test="cda:code[@code='18834-2' and @codeSystem='2.16.840.1.113883.6.1']">
            [S_DICOM_ExamenComparatif_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, la section FR-DICOM-Examen-comparatif (1.2.250.1.213.1.1.2.207) doit obligatoirement avoir comme code : @code='18834-2' et @codeSystem='2.16.840.1.113883.6.1'
        </assert>
        
        <!-- Vérifier le texte de la section 'FR-DICOM-Examen-comparatif' -->
        <assert test="cda:text">
            [S_DICOM_ExamenComparatif_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, une section FR-DICOM-Examen-comparatif (1.2.250.1.213.1.1.2.207) doit obligatoirement contenir l'élément texte
        </assert>
        
    </rule>
    
</pattern>