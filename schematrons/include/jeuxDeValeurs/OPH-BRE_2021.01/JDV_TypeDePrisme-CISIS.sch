<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TypeDePrisme-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_TypeDePrisme-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/component/section/component/section/entry/organizer/component/observation/value"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.9' 
        and cda:code/@code='95324-0']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>

