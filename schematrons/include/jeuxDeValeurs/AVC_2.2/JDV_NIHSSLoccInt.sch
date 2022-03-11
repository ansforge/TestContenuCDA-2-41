<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    AVC_NIHSSLoccInt20131025.sch :
    Contenu :
    Paramètres d'appel : Néant 
    Historique :
        25/10/2013 : CRI : Création
        17/01/18 : NMA : Prise en compte du NullFlavor dans le JDV
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_NIHSSLoccInt" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$JDV_NIHSSLoccInt"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/interpretationCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation/cda:entryRelationship/cda:observation
        [cda:code/@code='70186-2']/cda:interpretationCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   

<!-- 


	 
70187-0	AVC_NIHSSOculInt
70188-8	AVC_NIHSSCvInt
70189-6	AVC_NIHSSPfInt
70967-5	et 70190-4	AVC_NIHSSMsInt
70968-3	et 70191-2	AVC_NIHSSMiInt
70192-0	AVC_NIHSSAtaxInt
70193-8	AVC_NIHSSSensInt
70194-6	AVC_NIHSSLangInt
70195-3	AVC_NIHSSDysInt
-->