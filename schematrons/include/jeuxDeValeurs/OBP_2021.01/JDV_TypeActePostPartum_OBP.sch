<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    OBP_TypeActePostPartum20131025.sch :
    Contenu :
    Contrôle du code des Types d'acte ré&lisé après Naissance (Procedures & Interventions subsection)
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_TypeActePostPartum_OBP" is-a="dansJeuDeValeurs">
    <p>Conformité des demandes d'examen complémentaires</p>
    <param name="path_jdv" value="$jdv_OBP_TypeActePostPartum"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/procedure/entryRelationship/procedure/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section/cda:entry/cda:procedure[cda:code/@code='OBS_033']/cda:entryRelationship/cda:procedure/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   

