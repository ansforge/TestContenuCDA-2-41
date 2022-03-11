<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DICOM_Addendum_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-DICOM-Addendum(1.2.250.1.213.1.1.2.210) dans le document IMG-CR-IMG qui décrit 
   les informations supplémentaires ajoutées au contenu du document original
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    26/03/2021 : SBM : Création
    29/04/2021 : ANS : Suppression du controle sur la balise title
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_Addendum_IMG-CR-IMG">
    <title>CI-SIS IMG-CR-IMG Section Addendum</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.210"]'>
        
        <!-- Vérifier le code de la section 'FR-DICOM-Addendum' -->
        <assert test="cda:code[@code='55107-7' and @codeSystem='2.16.840.1.113883.6.1']">
            [ S_DICOM_Addendum_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, la section FR-DICOM-Addendum (1.2.250.1.213.1.1.2.210) doit obligatoirement avoir comme code : @code='55107-7' et @codeSystem='2.16.840.1.113883.6.1'
        </assert>
        
        <!-- Vérifier le texte de la section 'FR-DICOM-Addendum' -->
        <assert test="cda:text">
            [ S_DICOM_Addendum_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, une section FR-DICOM-Addendum (1.2.250.1.213.1.1.2.210) doit obligatoirement contenir l'élément texte
        </assert>
        
        <!-- Vérifier l'élément author de la section 'FR-DICOM-Addendum' -->
        <assert test="cda:author/cda:assignedAuthor/cda:assignedPerson/cda:name">
            [ S_DICOM_Addendum_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, la section FR-DICOM-Addendum (1.2.250.1.213.1.1.2.210) doit obligatoirement contenir l'élément author/assignedAuthor/assignedPerson/name
        </assert>
    </rule>
    
</pattern>