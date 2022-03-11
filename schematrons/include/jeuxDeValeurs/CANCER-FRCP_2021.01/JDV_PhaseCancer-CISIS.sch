<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_PhaseCancer-CISIS.sch :
    Contenu :

    Paramètres d'appel :
        Néant 
    Historique :
        10/01/2014 : CRI : Création
        14/10/19 : NMA : Mise à jour du nom du schématron, de l'id, de la variable et du titre
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_PhaseCancer-CISIS" is-a="dansJeuDeValeurs">
    <p>Phase du cancer</p>
    <param name="path_jdv" value="$JDV_PhaseCancer-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.25']/cda:entry/cda:observation[cda:code/@code='MED-243']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   

