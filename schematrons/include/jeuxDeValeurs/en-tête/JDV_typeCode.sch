<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_typeCode.sch (spécialisation du pattern dansJeuDeValeurs.sch)
    
    Contenu :
        Contrôle du typeCode du document dans l'en-tête CDA (nullFlavor interdit) 
        
   Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier TRE :
        ../../jeuxDeValeurs/TRE_A04-LoincTypeDocument.xml 
        ../../jeuxDeValeurs/TRE_A05-TypeDocComplementaire.xml
        
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_typeCode a été valorisé à ../../jeuxDeValeurs/JDV_J07-XdsTypeCode-CISIS.xml dans le schématron CI-SIS_StructurationMinimale.sch)
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
    Historique :
        31/05/11 : FMY ASIP/PRAS : Création
        27/10/20 : renommage de ce schématron en JDV_typeCode (ancien nom documentCode)
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_typeCode" is-a="abstractTypeCode">
    <p>Conformité au CI-SIS du type de document</p>
    <param name="path_jdv1" value="$jdv_typeCode_1"/>
    <param name="path_jdv2" value="$jdv_typeCode_2"/>
    <param name="vue_elt" value="'ClinicalDocument/code'"/>
    <param name="xpath_elt" value="cda:ClinicalDocument/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
