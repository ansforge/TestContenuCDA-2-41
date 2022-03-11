<?xml version="1.0" encoding="UTF-8"?>

<!-- JDV_actSubstanceAdministrationImmunizationCode.sch (spécialisation du pattern dansJeuDeValeurs.sch)

    Contenu :
        Contrôle du substanceAdministration/code d'une entrée FR-Vaccination(nullFlavor interdit)
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_actSubstanceAdministrationImmunizationCode a été valorisé à ../../jeuxDeValeurs/JDV_HL7_ActSubstanceAdministrationImmunizationCode-CISIS.xml dans le schématron CI-SIS_StructurationMinimale.sch)
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        30/11/2020 : ANS : Création

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_actSubstanceAdministrationImmunizationCode" is-a="dansJeuDeValeurs">
    <p>Conformité du code de l'entrée FR-Vaccination</p>
    <param name="path_jdv" value="$jdv_actSubstanceAdministrationImmunizationCode"/>
    <param name="vue_elt" value="substanceAdministration/code"/>
    <param name="xpath_elt" value="cda:substanceAdministration[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.12']/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>
