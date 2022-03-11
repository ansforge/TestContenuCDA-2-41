<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DICOM_Conclusion_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-DICOM-Conclusion (1.2.250.1.213.1.1.2.209) dans le document IMG-CR-IMG qui décrit 
   les conclusions cliniques
   
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    29/03/2021 : SBM : Création
    29/04/2021 : ANS : Suppression du controle sur la balise title
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_Conclusion_IMG-CR-IMG">
    <title>CI-SIS IMG-CR-IMG Section Conclusion </title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.209"]'>
        
        <!-- Vérifier le code de la section 'FR-DICOM-Conclusion' -->
        <assert test="cda:code[@code='19005-8' and @codeSystem='2.16.840.1.113883.6.1']">
            [S_DICOM_Conclusion_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : La section FR-DICOM-Conclusion (1.2.250.1.213.1.1.2.209) doit obligatoirement avoir comme code : @code='19005-8' et @codeSystem='2.16.840.1.113883.6.1'
        </assert>
               
        <!-- Vérifier le texte de la section 'FR-DICOM-Conclusion' -->
        <assert test="cda:text">
            [S_DICOM_Conclusion_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : une section FR-DICOM-Conclusion (1.2.250.1.213.1.1.2.209) doit obligatoirement contenir l'élément texte
        </assert>
        
    </rule>
    
</pattern>