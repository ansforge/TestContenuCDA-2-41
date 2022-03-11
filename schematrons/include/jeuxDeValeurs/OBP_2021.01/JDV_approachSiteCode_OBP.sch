<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_approachSiteCode_OBP.sch        
    ......................................................................................................................................................    
    Auteur : ANS
    ......................................................................................................................................................    
    Historique :
        25/10/2013 : CRI : Création
        20/11/2020 : ANS : Modification du nom du schématron (ancien JDV_routeOfAdministration_OBP.sch)
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_approachSiteCode_OBP" is-a="dansJeuDeValeurs">
    <p></p>
    <param name="path_jdv" value="$jdv_approachSiteCode_OBP"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/procedure/approachSiteCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:procedure[cda:code/@code='OBS_242']/cda:approachSiteCode"/>
    <param name="nullFlavor" value="0"/>
</pattern>   


