<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    AVC_artereCervelet20131025.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ArtereCervelet" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_ArtereCervelet"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/targetSiteCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:value/@code='D3-89400']/cda:entryRelationship/cda:observation[cda:value/@code='T-A6000']/cda:targetSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
