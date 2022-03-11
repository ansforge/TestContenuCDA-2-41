<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_AllergyAndIntoleranceCodes_F-PRC.sch :
    Contenu :
    Contrôle du code du niveau diagnostique d'une entrée Allergy and Intolerance Entry (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        27/06/2011 : Création
        22/02/2021 : Renommage
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_AllergyAndIntoleranceCodes_F-PRC" is-a="dansJeuDeValeurs">
    <p>Conformité PCC du statut de santé d'un patient</p>
    <param name="path_jdv" value="$jdv_AllergyAndIntoleranceCodes"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/code"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.6']/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   

