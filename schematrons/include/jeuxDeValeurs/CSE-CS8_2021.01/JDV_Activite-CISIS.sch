<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_Activité-CISIS.sch
    Contrôle du code de l'activité professionnelle d'une personne de la section Habitus, Mode de vie
    
    Paramètres d'appel :
      - path_jdv : chemin relatif du JDV_Activité-CISIS.xml (jdv_Activite a été valorisé à ../jeuxDeValeurs/JDV_Activité-CISIS.xml dans le schématron CI-SIS_CSE_CS8.sch) 
      - vue_elt : chemin affiché en cas d'erreur
      - xpath_elt : xpath de l'élément codé dans le CDA utilisant ce JDV
      - nullFlavor : autorisé (1) ou non (0)
      
    Historique :
        27/06/2011 : Création
        23/10/2020 : Mise à jour des commentaires
        23/02/2021 : Renommage
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_Activite-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité de l'activité professionnelle de la personne au CI-SIS</p>
    <param name="path_jdv" value="$JDV_Activite-CISIS"/>
    <param name="vue_elt" value="'ClinicalDocument/component/structuredBody/component/section/entry/observation/value'"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.4' and cda:code/@code='ORG-075']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
