<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_RCP-Appareil-CISIS.sch :
    Contenu : vérification du code RCP Appareil

    Auteur : ANS
    
    Historique :
        
        19/04/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_RCP-Appareil-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité Appareil</p>
    <param name="path_jdv" value="$JDV_RCP-Appareil-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='ORG-118']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   

