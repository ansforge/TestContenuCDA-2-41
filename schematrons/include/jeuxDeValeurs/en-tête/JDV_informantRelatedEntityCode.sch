<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_informantRelatedEntityCode.sch
    
    Contenu :
        Contrôle du code de l'élement relatedEntity de l'informant
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_authorFunctionCode a été valorisé à :
        ../../jeuxDeValeurs/TRE_R216-HL7RoleCode.xml 
        ../../jeuxDeValeurs/TRE_R217-ProtectionJuridique.xml
        
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        14/12/2020 : SBM : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_informantRelatedEntityCode" is-a="abstractInformantRelatedEntityCode">
    <p>Conformité du functionCode de l'auteur au CI-SIS</p>
    <param name="path_jdv1" value="$jdv_informantRelatedEntityCode_1"/>
    <param name="path_jdv2" value="$jdv_informantRelatedEntityCode_2"/>
    <param name="vue_elt" value="'informant/relatedEntity/code'"/>
    <param name="xpath_elt" value="cda:informant/cda:relatedEntity/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
