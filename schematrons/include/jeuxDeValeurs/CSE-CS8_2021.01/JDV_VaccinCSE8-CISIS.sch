<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_VaccinCSE8-CISIS.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :        
        01/06/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_VaccinCSE8-CISIS" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$JDV_VaccinCSE8-CISIS"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial/code/translation"/>
    <param name="xpath_elt" value="cda:substanceAdministration[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.12' and cda:code/@code='INITIMMUNIZ']/cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:translation"/>
    <param name="nullFlavor" value="0"/>
</pattern>

