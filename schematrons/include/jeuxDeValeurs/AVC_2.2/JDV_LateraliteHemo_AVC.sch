<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    AVC_LateraliteHemo20131025.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_LateraliteHemo_AVC" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_lateralite"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/qualifier/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation/cda:entryRelationship/cda:observation
        /cda:value[@code='T-A2050' or @code='T-A6000' or @code='AVC-160' or @code='AVC-161' or @code='G-A105' or @code='T-A2050' or @code='G-A106']/cda:qualifier/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
