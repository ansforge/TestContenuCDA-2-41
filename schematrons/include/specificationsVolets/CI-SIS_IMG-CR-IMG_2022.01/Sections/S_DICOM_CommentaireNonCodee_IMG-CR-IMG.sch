<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DICOM_CommentaireNonCodee_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Commentaire-non-code (1.2.250.1.213.1.1.2.73) dans le document IMG-CR-IMG qui décrit 
   les observations information au patient
   
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    26/03/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_CommentaireNonCodee_IMG-CR-IMG">
    <title>CI-SIS IMG-CR-IMG Section Commentaire non codé </title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.73"]'>
        
        <!-- Vérifier le code de la section 'FR-Commentaire-non-code' -->
        <assert test="cda:code[@code='55112-7' and @codeSystem='2.16.840.1.113883.6.1']">
            [S_DICOM_CommentaireNonCodee_IMG-CR-IMG] Erreur de conformité : Si elle existe, la section FR-Commentaire-non-code (1.2.250.1.213.1.1.2.73) doit obligatoirement avoir comme code : @code='55112-7' et @codeSystem='2.16.840.1.113883.6.1'
        </assert>
        
        <!-- Vérifier le texte de la section 'FR-Commentaire-non-code' -->
        <assert test="cda:text">
            [S_DICOM_CommentaireNonCodee_IMG-CR-IMG] Erreur de conformité : Si elle existe, la section FR-Commentaire-non-code (1.2.250.1.213.1.1.2.73) doit obligatoirement contenir l'élément text
        </assert>
        
    </rule>
    
</pattern>