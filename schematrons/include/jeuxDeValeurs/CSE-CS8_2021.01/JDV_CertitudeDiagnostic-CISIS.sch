<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_CertitudeDiagnostic-CISIS.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :        
        01/06/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_CertitudeDiagnostic-CISIS" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$JDV_CertitudeDiagnostic-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/component/section/entry/observation/value/qualifier/value"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5' and cda:code/@code='G-1009']/cda:value/cda:qualifier[cda:name/@code='G-2000']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>

