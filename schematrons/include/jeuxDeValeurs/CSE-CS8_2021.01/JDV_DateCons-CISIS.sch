<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_DateCons-CISIS.sch :
    Contenu :
    Contrôle de la date de déclaration de grossesse de la patiente  (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        27/06/11 : Création
        22/11/17 : Mise à jour du code TA_CS ==> TA_ASIP
        23/02/21 : Renommage
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_DateCons-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité de la date de déclaration de grossesse au CI-SIS</p>
    <param name="path_jdv" value="$JDV_DateCons-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation/cda:value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='ORG-076']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>
