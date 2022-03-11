<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_administrativeGenderCode.sch
    
    Contenu :
        Règles de contrôle du sexe d'une personne (nullFlavor autorisé)
     
    Historique :
        11/10/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_administrativeGenderCode" is-a="dansJeuDeValeurs">
    <p>Conformité du code sexe d'une personne</p>
    <param name="path_jdv" value="$jdv_administrativeGenderCode"/>
    <param name="vue_elt" value="'administrativeGenderCode'"/>
    <param name="xpath_elt" value="//cda:administrativeGenderCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
