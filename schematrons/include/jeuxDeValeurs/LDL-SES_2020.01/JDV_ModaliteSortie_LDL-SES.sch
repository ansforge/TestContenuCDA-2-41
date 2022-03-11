<?xml version="1.0" encoding="UTF-8"?>

<!--
     JDV_ModaliteSortie_LDL-SES
	 Schématron du JDV contenant toutes les modalités de sortie possibles
	 Historique : 
	 19/12/2016 : Création
	 22/02/2021 : Renommage
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ModaliteSortie_LDL-SES" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_ModaliteSortie_LDL-SES"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='ORG-074']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>