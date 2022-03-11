<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_MotifConsultationOphtalmologique-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_MotifConsultationOphtalmologique-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' 
        and cda:code/@code='42349-1']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>

