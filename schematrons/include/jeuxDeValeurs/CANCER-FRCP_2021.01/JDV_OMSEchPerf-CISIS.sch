<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_OMSEchPerf-CISIS.sch :
    Contenu :

    Paramètres d'appel :
        Néant 
    Historique :
        10/01/2014 : CRI : Création
        14/10/19 : NMA : Mise à jour du nom du schématron, de l'id, de la variable et du titre
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_OMSEchPerf-CISIS" is-a="dansJeuDeValeurs">
    <p>OMSEchPerf</p>
    <param name="path_jdv" value="$JDV_OMSEchPerf-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5']/cda:entry/cda:observation[cda:code/@code='MED-239']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   

