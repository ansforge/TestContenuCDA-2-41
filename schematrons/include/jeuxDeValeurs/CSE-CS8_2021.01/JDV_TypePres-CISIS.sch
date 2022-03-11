<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_TypePres-CISIS.sch :
    Contenu :
    Contrôle de la présentation du nouveau-né lors du travail  (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        27/06/11 : Création
        24/02/21 : Renommage
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TypePres-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité de la date de déclaration de grossesse au CI-SIS</p>
    <param name="path_jdv" value="$JDV_TypePres-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='F-87000']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>

