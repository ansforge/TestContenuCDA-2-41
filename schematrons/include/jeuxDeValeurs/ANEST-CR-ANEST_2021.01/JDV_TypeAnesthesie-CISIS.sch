<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TypeAnesthesie-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_TypeAnesthesie-CISIS"/>
    <param name="vue_elt"
        value="ClinicalDocument/component/structuredBody/component/section/entry/procedure/code"/>
  <!--  <param name="xpath_elt"
        value="cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11']/cda:entry
        /cda:procedure[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.19' and not(cda:code/@code='GDFA014')
        and not(cda:code/@code='JQGA003')
        and not(cda:code/@code='MED-658')  and not(cda:code/@code='EPLF002') and not(cda:code/@code='MED-632')
        and not(cda:code/@code='GLLP003') 
        and not(cda:code/@code='GELD004') and not(cda:code/@code='FELF006')]/cda:code"/>-->
    <param name="xpath_elt"
        value="cda:procedure[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.19' and cda:text/cda:reference/starts-with(@value,'#ANEST-typeAnestesie')]/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>
