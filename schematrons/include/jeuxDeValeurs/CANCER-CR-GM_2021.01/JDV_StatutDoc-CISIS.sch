<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_StatutDoc-CISIS.sch : Contrôle du code du statut du document
    
    Spécialisation du pattern dansJeuDeValeurs
    
    Paramètres d'appel :
      - path_jdv : chemin relatif du JDV_StatutDoc-CISIS.xml (a été valorisé dans le schématron du document) 
      - vue_elt : chemin affiché en cas d'erreur
      - xpath_elt : xpath de l'élément codé dans le CDA utilisant ce JDV
      - nullFlavor : autorisé (1) ou non (0)
    
    Historique :
        21/04/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_StatutDoc-CISIS" is-a="dansJeuDeValeurs">
    <p>Vérification du statut du document</p>
    <param name="path_jdv" value="$JDV_StatutDoc-CISIS"/>
    <param name="vue_elt" value="'observation/value'"/>
    <param name="xpath_elt" value="cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.35']/cda:entry/cda:observation/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
