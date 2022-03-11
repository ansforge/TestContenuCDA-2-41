<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_OrientationBaseDuPrisme-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_OrientationBaseDuPrisme-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/component/section/component/section/entry/organizer/component/observation/value"/>
    <param name="xpath_elt" value="cda:observation[(cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.9' and cda:code/@code='MED-1074') or
        (cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.9' and cda:code/@code='MED-1080') or
        (cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.6' and cda:code/@code='96051-8')]/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>

