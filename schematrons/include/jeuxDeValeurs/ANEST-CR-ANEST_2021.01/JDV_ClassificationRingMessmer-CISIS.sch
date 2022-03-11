<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ClassificationRingMessmer-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_ClassificationRingMessmer-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5' and (cda:value/@code='T88.7' or cda:value/@code='T41.3')]//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>  

