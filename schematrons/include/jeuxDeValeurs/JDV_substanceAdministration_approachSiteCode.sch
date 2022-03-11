<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_substanceAdministration_approachSiteCode.sch (spécialisation du pattern dansJeuDeValeurs.sch)
    
    Contenu :
        Contrôle du code de la voie d'administration (nullFlavor autorisé)

    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_humanSubstance_administrationSite a été valorisé à ../../jeuxDeValeurs/JDV_HL7_HumanSubstanceAdministrationSite-CISIS.xml dans le schématron CI-SIS_StructurationMinimale.sch)
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        27/06/11 : CRI ASIP/PRAS : Création
        03/11/20 : renommage du schématron en JDV_substanceAdministration_ApproachSiteCode.sch (ancien nom : humanSubstanceAdministrationSite.sch)
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_substanceAdministration_approachSiteCode" is-a="dansJeuDeValeurs">
    <p>Conformité des demandes d'examen complémentaires</p>
    <param name="path_jdv" value="$jdv_substanceAdministration_approachSiteCode"/>
    <param name="vue_elt" value="'substanceAdministration/approachSiteCode'"/>
    <param name="xpath_elt" value="cda:substanceAdministration/cda:approachSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   


