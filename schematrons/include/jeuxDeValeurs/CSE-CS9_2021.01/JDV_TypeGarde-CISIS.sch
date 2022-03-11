<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_TypeGarde-CISIS.sch :
    Contenu :
    Contrôle du code du type de garde d'un enfant de la section Coded Social history  (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        27/06/11 : Création
        24/02/21 : Renommage
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TypeGarde-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité du type de garde de l'enfant</p>
    <param name="path_jdv" value="$JDV_TypeGarde-CISIS"/>
    <param name="vue_elt" value="'ClinicalDocument/component/structuredBody/component/section/entry/observation/value'"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/@code='S-80000']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
