<?xml version="1.0" encoding="UTF-8"?>
<!-- 

    Contrôle du code des codes statiques des entrées de la section Active Problems de SAP
    Paramètres d'appel : Néant 
    Historique :
    25/10/2013 : CRI :OBP_InfectCervicoVaginale20131025.sch
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_InfectCervicoVaginale_OBP" is-a="dansJeuDeValeurs">
    <p>Conformité des demandes d'examen complémentaires</p>
    <param name="path_jdv" value="$jdv_OBP_InfectCervicoVaginale"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:value/@code='OBS_132']/cda:entryRelationship/cda:observation/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   




