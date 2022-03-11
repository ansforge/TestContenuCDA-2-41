<?xml version="1.0" encoding="UTF-8"?>
<!-- 
      *************************************************************************
      schématron JDV_ProtheseObjetPersonnel
      Auteur : ANS
      **********************************************************************************************************
      Modifications :            
      07/01/2021 : Création
      **********************************************************************************************************
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ProtheseObjetPersonnel" is-a="dansJeuDeValeurs">
    <p>Conformité DLU-DLU du code des observations section FR-Resultats-evenements</p>
    <param name="path_jdv" value="$JDV_ProtheseObjetPersonnel"/>
    <param name="vue_elt" value="'observation/code'"/>
    <param name="xpath_elt" value="cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.12']/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   