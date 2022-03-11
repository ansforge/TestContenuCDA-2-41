<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    OBP_GesteReanimationNN20131025.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_GesteReanimationNN_OBP" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$jdv_OBP_GesteReanimationNN"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/procedure/entryRelationship/procedure/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:procedure[cda:code/@code='OBS_241']/cda:entryRelationship/cda:procedure/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   


