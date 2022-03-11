<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_BatterieExamen-CISIS.sch :
    Contenu :
    Contrôle du code dans l'entrée FR-Simple-observation de l'entrée FR-Batterie-Examens-et-surveillance-prenataux  (nullFlavor interdit)
        Spécialisation du pattern dansJeuDeValeurs
    Paramètres d'appel :
        Néant 
    Historique :
        31/05/21 : SBM Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_BatterieExamen-CISIS" is-a="dansJeuDeValeurs">
    <p>Contrôle du code de batterie examen</p>
    <param name="path_jdv" value="$JDV_BatterieExamen-CISIS"/>
    <param name="vue_elt" value="/ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/code"/>
    <param name="xpath_elt" value="cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.21.3.10']//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.48']/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern> 