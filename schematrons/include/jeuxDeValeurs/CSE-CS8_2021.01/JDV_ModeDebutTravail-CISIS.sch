<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_ModeDebutTravail-CISIS.sch :
    Contenu :
    Contrôle de l'élément value dans l'entrée FR-Simple-observation (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        01/06/21 : SBM Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ModeDebutTravail-CISIS" is-a="dansJeuDeValeurs">
    <p>Contrôle du mode début travail</p>
    <param name="path_jdv" value="$JDV_ModeDebutTravail-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and cda:code/@code='F-84640']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern> 