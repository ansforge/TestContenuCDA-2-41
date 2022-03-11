<?xml version="1.0" encoding="UTF-8"?>

<!-- JDV_SeverityObservation (spécialisation du pattern dansJeuDeValeurs.sch)
    
    Contenu :
        Vérification de la valeur de l'élément <value> de l'entrée FR-Severite (nullFlavor autorisé)
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici JDV_SeverityObservation a été valorisé à ../../jeuxDeValeurs/JDV_HL7_SeverityObservation-CISIS.xml dans le schématron CI-SIS_EP-MED-DM_2022.01.sch)
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        - 25/09/2020 : Création
        - 30/11/2020 : Mise à jour
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_SeverityObservation" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_SeverityObservation"/>
    <param name="vue_elt" value="observation/value"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>
