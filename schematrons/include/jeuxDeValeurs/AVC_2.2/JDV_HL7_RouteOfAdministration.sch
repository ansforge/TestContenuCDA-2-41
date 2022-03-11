<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_HL7_RouteOfAdministration.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_HL7_RouteOfAdministration" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_HL7_RouteOfAdministration"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/substanceAdministration/routeCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:substanceAdministration/cda:routeCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   


