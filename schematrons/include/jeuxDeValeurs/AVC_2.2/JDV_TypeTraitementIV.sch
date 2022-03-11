<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_TypeTraitementIV.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TypeTraitementIV" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_TypeTraitementIV"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/substanceAdministration/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:substanceAdministration/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>   


