<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    documentCode.sch :
    Contenu :
        Contrôle du code du type de document dans l'en-tête CDA  
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        31/05/11 : FMY ASIP/PRAS : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="documentCode" is-a="abstractTypeCode">
    <p>Conformité du type de document au CI-SIS</p>
    <param name="path_jdv" value="$jdv_typeCode_1"/>
    <param name="path_jdv" value="$jdv_typeCode_2"/>
    <param name="vue_elt" value="'ClinicalDocument/code'"/>
    <param name="xpath_elt" value="cda:ClinicalDocument/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
