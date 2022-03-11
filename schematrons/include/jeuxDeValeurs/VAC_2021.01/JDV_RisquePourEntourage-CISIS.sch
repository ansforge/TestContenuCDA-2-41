<?xml version="1.0" encoding="UTF-8"?>

<!--
 Historique :
        10/07/18 : NMA : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_RisquePourEntourage-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_RisquePourEntourage-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:observation[cda:code/cda:qualifier/cda:value/@code='GEN-064']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
