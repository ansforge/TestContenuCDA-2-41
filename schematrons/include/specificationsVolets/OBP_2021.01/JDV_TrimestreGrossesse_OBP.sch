<?xml version="1.0" encoding="UTF-8"?>
<!-- 

   
    Paramètres d'appel : Néant 
    Historique :
    25/10/2013 : CRI : OBP_TrimestreGrossesse20131025.sch
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TrimestreGrossesse_OBP" is-a="dansJeuDeValeurs">
    <p>Conformité des demandes d'examen complémentaires</p>
    <param name="path_jdv" value="$jdv_OBP_TrimestreGrossesse"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/entryRelationship/observation/value/qualifier/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:organizer/cda:component/cda:observation/cda:entryRelationship/cda:observation/cda:value/cda:qualifier[cda:name/@code='OBP_278']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   