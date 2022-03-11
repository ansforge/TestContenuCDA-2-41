<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_CertitudeDiagnostic-CISIS.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : Création
        26/02/2021 : Renommage
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_CertitudeDiagnostic-CISIS" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$JDV_CertitudeDiagnostic-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value/qualifier/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='F-06230']/cda:value/cda:qualifier/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   



