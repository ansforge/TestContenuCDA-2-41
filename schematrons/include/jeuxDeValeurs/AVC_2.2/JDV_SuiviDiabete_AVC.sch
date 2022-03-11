<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    AVC_SuiviDiabete20131025.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_SuiviDiabete_AVC" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_AVC_statutEvt"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:value/@code='DB-61000']/cda:entryRelationship[@typeCode='RSON']/cda:observation/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   


