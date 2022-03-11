<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_MesureLentilleDelivree-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_MesureLentilleDelivree-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/component/section/component/section/entry/organizer/component/observation/code"/>
    <param name="xpath_elt" value="cda:organizer[cda:code/@code='MED-1069']/cda:component/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.9']/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>

