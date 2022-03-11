<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_authorSpecialty.sch
    
    Contenu :
        Contrôle du code profession/spécialité d'un auteur (nullFlavor autorisé)
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_authorSpecialty a été valorisé à :
        ../../jeuxDeValeurs/TRE_A02-ProfessionSavFaire-CISIS.xml
        ../../jeuxDeValeurs/TRE_A00-ProducteurDocNonPS.xml
         ../../jeuxDeValeurs/TRE_R85-RolePriseCharge.xml
        ../../jeuxDeValeurs/TRE_R94-ProfessionSocial.xml
         ../../jeuxDeValeurs/TRE_R95-UsagerTitre.xml
        ../../jeuxDeValeurs/TRE_R96-AutreProfDomSanitaire.xml
        dans le schématron CI-SIS_StructurationMinimale.sch)
        
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
    Historique :
        11/12/2020 : SBM : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_authorSpecialty" is-a="abstractSpecialty">
    <p>Conformité de la profession/spécialité d'un auteur</p>
    <param name="path_jdv1" value="$jdv_authorSpecialty_1"/>
    <param name="path_jdv2" value="$jdv_authorSpecialty_2"/>
    <param name="path_jdv3" value="$jdv_authorSpecialty_3"/>
    <param name="path_jdv4" value="$jdv_authorSpecialty_4"/>
    <param name="path_jdv5" value="$jdv_authorSpecialty_5"/>
    <param name="path_jdv6" value="$jdv_authorSpecialty_6"/>
    <param name="vue_elt" value="'author/assignedAuthor/code'"/>
    <param name="xpath_elt" value="cda:author/cda:assignedAuthor/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
