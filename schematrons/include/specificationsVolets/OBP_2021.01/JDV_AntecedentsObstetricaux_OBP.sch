<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_AntecedentsObstetricaux_OBP.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        08/03/2018 : CRI : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_AntecedentsObstetricaux_OBP" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$jdv_AntecedentsObstetricaux_OBP"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/organizer/component/observation/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>