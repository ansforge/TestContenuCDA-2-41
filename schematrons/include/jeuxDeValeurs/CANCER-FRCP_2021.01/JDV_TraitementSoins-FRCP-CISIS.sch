<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_TraitementSoins-FRCP-CISIS.sch :
    Contenu :

    Paramètres d'appel :
        Néant 
    Historique :
        16/04/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TraitementSoins-FRCP-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité JDV_TraitementSoins-FRCP-CISIS</p>
    <param name="path_jdv" value="$JDV_TraitementSoins-FRCP-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation[cda:value/@code='ORG-132']/cda:entryRelationship/cda:observation[cda:code/@code='ORG-138']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   

