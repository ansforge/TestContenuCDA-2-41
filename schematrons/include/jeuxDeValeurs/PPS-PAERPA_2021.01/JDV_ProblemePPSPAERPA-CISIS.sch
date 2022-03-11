<?xml version="1.0" encoding="UTF-8"?>

<!--
 Historique :
        24/08/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ProblemePPSPAERPA-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_ProblemePPSPAERPA-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/code"/>
    <param name="xpath_elt" value="cda:component/cda:section/cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1']/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
