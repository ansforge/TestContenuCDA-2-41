<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ContexteActivite_SDMMR" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_ContexteActivite"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/encounter/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:encounter/cda:entryRelationship/cda:observation[cda:code/@code='ORG-033']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
