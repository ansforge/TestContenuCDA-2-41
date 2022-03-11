<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_Activite_AVC.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_Activite_AVC" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_AVC_Activite"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation/cda:code[@code='G-A224']"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
