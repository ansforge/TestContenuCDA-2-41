<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_StatutEvt.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_StatutEvt" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_StatutEvt"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='D9-30171' or cda:code/@code='F-9B721' or cda:code/@code='P2-45020' or cda:code/@code='AVC-004']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   


