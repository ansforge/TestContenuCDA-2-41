<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_clinicalStatusCodes.sch (spécialisation du pattern dansJeuDeValeurs.sch)
    
    Contenu :
    Contrôle du code du statut clinique d'un problème dans une entrée Fr-Probleme (nullFlavor interdit)
    
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_ClinicalStatusCodes a été valorisé à ../../jeuxDeValeurs/JDV_ClinicalStatusCodes-CISIS.xml dans le schématron CI-SIS_StructurationMinimale.sch)
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        27/06/2011 : CRI ASIP/PRAS : Création
        03/11/2020 : ANS : mise à jour du value du paramètre "vue_elt" pour être conforme à un schématron JDV générique
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_clinicalStatusCodes" is-a="dansJeuDeValeurs">
    <p>Conformité PCC du statut de santé d'un patient</p>
    <param name="path_jdv" value="$jdv_clinicalStatusCodes"/>
    <param name="vue_elt" value="'observation/value'"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   

