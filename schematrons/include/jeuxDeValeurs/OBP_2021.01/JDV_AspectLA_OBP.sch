<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    OBP_AspectLA20131025.sch :
    Contenu :
    Contrôle du code des modes de Naissance 
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_AspectLA_OBP" is-a="dansJeuDeValeurs">
    <p>OBP_QuantiteLA</p>
    <param name="path_jdv" value="$jdv_OBP_AspectLA"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='OBS_037']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   

