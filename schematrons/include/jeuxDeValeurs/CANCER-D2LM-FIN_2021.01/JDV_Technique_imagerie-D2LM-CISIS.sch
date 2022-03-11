<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_Technique_imagerie-D2LM-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_Technique_imagerie-D2LM-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/procedure/code"/>
    <param name="xpath_elt" value="cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.28']/cda:entry/cda:procedure[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.19']/cda:code[not(@code='MED-022') and not(@code='MED-014')]"/>
    <param name="nullFlavor" value="0"/>
</pattern>   


