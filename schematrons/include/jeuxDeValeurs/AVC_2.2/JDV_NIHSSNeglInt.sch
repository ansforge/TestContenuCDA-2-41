<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    AVC_NIHSSNeglInt20131025.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_NIHSSNeglInt" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_NIHSSNeglInt"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/interpretationCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation/cda:entryRelationship/cda:observation
        [cda:code/@code='70196-1']/cda:interpretationCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   

