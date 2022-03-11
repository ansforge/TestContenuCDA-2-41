<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_RCP-Organe-CISIS.sch :
    Contenu : Vérification du code RCP Organe

    Auteur : ANS
         
    Historique :
        19/04/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_RCP-Organe-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité Organe</p>
    <param name="path_jdv" value="$JDV_RCP-Organe-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='ORG-118']/cda:entryRelationship/cda:observation[cda:code/@code='ORG-119']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   

