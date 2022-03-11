<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    ConsommationAlcool.sch :
    Contenu :
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        02/09/19 : ASIP : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ConsommationAlcool" is-a="dansJeuDeValeurs">
    <p>Consommation d'alcool du patient</p>
    <param name="path_jdv" value="$jdv_ConsommationAlcool"/>
    <param name="vue_elt" value="'ClinicalDocument/component/structuredBody/component/section/entry/observation/text/reference/value'"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:code/@code='74205-6']/cda:text/cda:text/cda:reference/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
