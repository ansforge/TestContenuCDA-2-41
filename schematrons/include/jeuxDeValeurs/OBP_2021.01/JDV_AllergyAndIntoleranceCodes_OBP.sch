<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    ProblemCodes.sch :
    Contenu :
    Contrôle du code du niveau diagnostique d'une entrée Allergy and Intolerance Entry (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        27/06/11 : CRI ASIP/PRAS : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_AllergyAndIntoleranceCodes_OBP" is-a="dansJeuDeValeurs">
    <p>Conformité PCC du statut de santé d'un patient</p>
    <param name="path_jdv" value="$jdv_AllergyAndIntoleranceCodes"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/code"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.6']/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   

