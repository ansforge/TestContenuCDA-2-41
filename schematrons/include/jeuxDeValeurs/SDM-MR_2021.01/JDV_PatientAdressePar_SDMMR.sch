<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_PatientAdressePar_SDMMR" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_PatientAdressePar"/>
    <param name="vue_elt" value="ClinicalDocument/participant/associatedEntity/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:participant[@typeCode='REFB']/cda:associatedEntity[@classCode='PROV']/cda:code"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
