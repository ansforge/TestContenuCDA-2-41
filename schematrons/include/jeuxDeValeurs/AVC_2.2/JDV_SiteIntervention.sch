<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    AVC_siteIntervention20131025.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_SiteIntervention" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_SiteIntervention"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/procedure/targetSiteCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.12']/cda:entry/cda:procedure/cda:targetSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
