<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_EvenementsAccouchement-CISIS.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :        
        24/03/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_EvenementsAccouchement-CISIS" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$JDV_EvenementsAccouchement-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.21.2.3']/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9']/cda:entry/cda:observation/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>