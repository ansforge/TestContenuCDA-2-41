<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_Morphologie-CISIS.sch :
    Contenu :

    Paramètres d'appel :
        Néant 
    Historique :
        20/04/21 : ANS : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_Morphologie-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité du JDV_Morphologie-CISIS</p>
    <param name="path_jdv" value="$JDV_Morphologie-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section[templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/entry/act/entryRelationship/observation[code/@code='G-1009']/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='G-1009']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern>   

