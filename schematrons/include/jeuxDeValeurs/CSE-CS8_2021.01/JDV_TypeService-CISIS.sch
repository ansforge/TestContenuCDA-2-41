<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_TypeService-CISIS.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :        
        01/06/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TypeService-CISIS" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$JDV_TypeService-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/act/participant/participantRole/code/translation"/>
    <param name="xpath_elt" value="cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1' and cda:code/@code='80413-8']/cda:participant/cda:participantRole/cda:code/cda:translation"/>
    <param name="nullFlavor" value="0"/>
</pattern>

