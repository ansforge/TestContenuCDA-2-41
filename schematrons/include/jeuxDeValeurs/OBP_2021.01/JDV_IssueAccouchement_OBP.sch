<?xml version="1.0" encoding="UTF-8"?>
<!-- 

    Contrôle du code des codes statiques des entrées de la section Active Problems de SAP
    Paramètres d'appel : Néant 
    Historique :
    25/10/2013 : CRI : OBP_IssueAccouchement20131025.sch
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_IssueAccouchement_OBP" is-a="dansJeuDeValeurs">
    <p>Conformité des demandes d'examen complémentaires</p>
    <param name="path_jdv" value="$jdv_OBP_IssueAccouchement"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/organizer/component/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation[cda:code/@code='XX-MCH219']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   


