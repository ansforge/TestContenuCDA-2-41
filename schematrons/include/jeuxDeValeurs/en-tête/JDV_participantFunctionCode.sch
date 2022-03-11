<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_participantFunctionCode.sch (spécialisation du pattern dansJeuDeValeurs.sch)
    
    Contenu :
        Contrôle du functionCode d'un participant (nullFlavor autorisé)
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_participantFunctionCode a été valorisé à :
           ../../jeuxDeValeurs/TRE_R258-RelationPriseCharge.xml 
        ../../jeuxDeValeurs/TRE_R259-HL7ParticipationFunction.xml
        ../../jeuxDeValeurs/TRE_R85-RolePriseCharge.xml
        dans le schématron CI-SIS_StructurationMinimale.sch).
        
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        28/10/2020 : ANS : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_participantFunctionCode" is-a="abstractFunctionCode">
    <p>Conformité de la spécialité de l'auteur au CI-SIS</p>
    <param name="path_jdv1" value="$jdv_participantFunctionCode_1"/>
    <param name="path_jdv2" value="$jdv_participantFunctionCode_2"/>
    <param name="path_jdv3" value="$jdv_participantFunctionCode_3"/>
    <param name="vue_elt" value="'participant/functionCode'"/>
    <param name="xpath_elt" value="cda:participant/cda:functionCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
