<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    OBP_PrelevementsPeriph20131025.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_PrelevementsPeriph_OBP" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$jdv_OBP_PrelevementsPeriph"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/procedure/targetSiteCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:procedure[cda:code/@code='OBS_243']/cda:targetSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   



