<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ProfessionPersonnelActivite_SDMMR" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_ProfessionPersonnelActivite"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/encounter/participant/participantRole/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:encounter/cda:participant[@typeCode='PRF']/cda:participantRole/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
