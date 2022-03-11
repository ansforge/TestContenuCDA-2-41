<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_healthcareFacilityTypeCode.sch (spécialisation du pattern dansJeuDeValeurs.sch)
    
    Contenu :
        Contrôle du type d'organisation de prise en charge du patient dans l'en-tête CDA  (nullFlavor non autorisé)
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_healthcareFacilityTypeCode a été valorisé à ../../jeuxDeValeurs/JDV_J02-XdsHealthcareFacilityTypeCode-CISIS.xml dans le schématron CI-SIS_StructurationMinimale.sch)
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        31/05/11 : FMY ASIP/PRAS : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_healthcareFacilityCode" is-a="abstractHealthcareFacilityCode">
    <p>Conformité au CI-SIS du healthcareFacilityCode de la prise en charge</p>
    <param name="path_jdv1" value="$jdv_healthcareFacilityCode_1"/>
    <param name="path_jdv2" value="$jdv_healthcareFacilityCode_2"/>
    <param name="vue_elt" value="'componentOf/encompassingEncounter/location/healtCareFacility/code'"/>
    <param name="xpath_elt" value="cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   