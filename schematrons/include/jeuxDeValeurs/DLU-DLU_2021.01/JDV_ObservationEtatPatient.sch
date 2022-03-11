<?xml version="1.0" encoding="UTF-8"?>
<!-- 
      *************************************************************************
      schématron JDV_ObservationEtatPatient
      Auteur : ANS
      **********************************************************************************************************
      Modifications :            
      06/01/2021 : Création
      **********************************************************************************************************
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ObservationEtatPatient" is-a="dansJeuDeValeurs">
    <p>Conformité DLU-DLU du code des observations section FR-Resultats-evenements</p>
    <param name="path_jdv" value="$JDV_ObservationEtatPatient"/>
    <param name="vue_elt" value="'observation/code'"/>
    <param name="xpath_elt" value="cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7']/cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   