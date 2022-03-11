<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_OeilExamine-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_OeilExamine-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/component/section/component/section/entry/organizer/component/observation/targetSiteCode"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.7' or cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.6']/cda:targetSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>

