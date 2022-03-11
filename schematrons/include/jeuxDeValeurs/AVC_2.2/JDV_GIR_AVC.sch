<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_GIR_AVC.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_GIR_AVC" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_AVC_GIR"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation/cda:value[@displayName='']"/>
    <param name="nullFlavor" value="1"/>
</pattern> 