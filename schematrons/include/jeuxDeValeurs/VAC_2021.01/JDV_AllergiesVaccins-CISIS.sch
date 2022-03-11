<?xml version="1.0" encoding="UTF-8"?>

<!--
 Historique :
        20/12/18 : NMA : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_AllergiesVaccins-CISIS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_AllergiesVaccins-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/act/entryRelationship/observation/participant/participantRole/playingEntity/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:participant/cda:participantRole/cda:playingEntity/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
