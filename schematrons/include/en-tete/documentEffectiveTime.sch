<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    documentEffectiveTime.sch :
    Contenu :
        Règles de contrôle de la date et heure locale de production du document 
    Paramètres d'appel :
        néant
    Historique :
        02/06/11 : FMY ASIP/PRAS : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="documentEffectiveTime" is-a="IVL_TS">
    <p>Conformité de la date et heure de production du document, nullFlavor interdit</p>
    <param name="elt" value="cda:ClinicalDocument/cda:effectiveTime"/>
    <param name="vue_elt" value="'ClinicalDocument/effectiveTime'"/>
    <param name="nullFlavor" value="0"/>
</pattern>