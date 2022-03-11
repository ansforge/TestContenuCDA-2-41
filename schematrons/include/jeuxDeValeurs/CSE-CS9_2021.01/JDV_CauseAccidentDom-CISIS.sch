<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_CauseAccidentDom-CISIS.sch :
    Contenu :
    Contrôle du code du type d'accidents survenus chez un enfant durant la période périnatale dans la section History of past illness  (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        27/06/11 : CRI ASIP/PRAS : Création
        22/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
        08/06/2020 : APE : le code de l'accident domestique est porté par l'élément code (et plus value)
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_CauseAccidentDom-CISIS" is-a="dansJeuDeValeurs">
    <p>Contrôle du code du type d'accidents survenus chez un enfant</p>
    <param name="path_jdv" value="$JDV_CauseAccidentDom-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/entryRelationship/observation/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5' and cda:value/@code='MED-186']/cda:entryRelationship/cda:observation/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   

