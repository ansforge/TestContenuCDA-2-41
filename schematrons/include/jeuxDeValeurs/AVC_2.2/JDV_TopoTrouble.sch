<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    AVC_TopoTrouble20131025.sch :
    Contenu :
    Contrôle de la topographie des troubles moteurs 
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TopoTrouble" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_TopoTrouble"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/targetSiteCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:value/@code='DA-21100' or cda:value/@code='F-A4580']/cda:targetSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   


