<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DICOM_CatalogueObjets_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la sous section FR-DICOM-Object-Catalog(1.2.250.1.213.1.1.2.217) dans le document IMG-CR-IMG qui décrit 
  le Catalogue d’objets DICOM qui répertorie les références des images / séries / études et liens WADO vers les images.
   
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    06/04/2021 : SBM : Création
    29/04/2021 : ANS : Suppression du controle sur la balise title
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_CatalogueObjets_IMG-CR-IMG">
    <title>CI-SIS IMG-CR-IMG Section Catalogue d'objets DICOM</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.217"]'>
        
        <!-- Vérifier le code de la section 'FR-DICOM-Object-Catalog' -->
        <assert test="cda:code[@code='121181' and @codeSystem='1.2.840.10008.2.16.4']">
            [S_DICOM_CatalogueObjets_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : la sous-section FR-DICOM-Object-Catalog (1.2.250.1.213.1.1.2.217) doit obligatoirement avoir comme code : @code='121181' et @codeSystem='1.2.840.10008.2.16.4'
        </assert>
        
        <!-- Vérifier le texte de la section 'FR-DICOM-Object-Catalog' -->
        <assert test="cda:text">
            [S_DICOM_CatalogueObjets_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : la sous-section FR-DICOM-Object-Catalog (1.2.250.1.213.1.1.2.217) doit obligatoirement contenir l'élément texte
        </assert>
        
        <!-- Vérifier les contraintes au niveau de l'entrée FR-DICOM-Examen-imagerie-->
        <assert test="not(.//cda:act[cda:templateId/@root='1.2.250.1.213.1.1.3.155']) or (.//cda:act[cda:templateId/@root='1.2.250.1.213.1.1.3.155']/cda:code/@code='113014' and
            .//cda:act[cda:templateId/@root='1.2.250.1.213.1.1.3.155']/cda:code/@codeSystem='1.2.840.10008.2.16.4')">
            [S_DICOM_CatalogueObjets_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : Si elle existe, l'entrée  FR-DICOM-Examen-imagerie (1.2.250.1.213.1.1.3.155) doit avoir obligatoirement comme code : @code="113014" et @codeSystem='1.2.840.10008.2.16.4'.
        </assert>
        
    </rule>
    
</pattern>