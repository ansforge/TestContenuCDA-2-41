<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    OBP_ModeNaissance20131025.sch :
    Contenu :
    Contrôle du code des modes de Naissance 
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ModeNaissance_OBP" is-a="dansJeuDeValeurs">
    <p>Conformité des demandes d'examen complémentaires</p>
    <param name="path_jdv" value="$jdv_OBP_ModeNaissance"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/procedure/approachSiteCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:procedure[cda:code/@code='XX-MCH219']/cda:approachSiteCode"/>
    <param name="nullFlavor" value="0"/>
</pattern>   

