<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_CouvertureSociale-CISIS.sch :
    Contenu :
    Contrôle du code dans l'entrée  FR-Organisme-assurance-maladie  (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        31/05/21 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_CouvertureSociale-CISIS" is-a="dansJeuDeValeurs">
    <p>Contrôle du code de l'organisme de l'assurance maladie</p>
    <param name="path_jdv" value="$JDV_CouvertureSociale-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/act/code"/>
    <param name="xpath_elt" value="cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.18']/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   

