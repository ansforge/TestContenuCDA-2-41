<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_typeCode.sch (spécialisation du pattern dansJeuDeValeurs.sch)
    
    Contenu :
        Contrôle du confidentialityCode du document dans l'en-tête CDA (nullFlavor interdit) 
        
   Paramètres d'appel :
        
        "path_jdv" : chemin relatif du fichier TRE (TRE_A08-HL7Confidentiality.xml)
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
    Historique :
        08/10/21 : SBE : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_confidentialityCode" is-a="dansJeuDeValeurs">
    <p>Conformité au CI-SIS du confidentialityCode</p>
    <param name="path_jdv" value="$jdv_confidentialityCode"/>
    <param name="vue_elt" value="'ClinicalDocument/confidentialityCode'"/>
    <param name="xpath_elt" value="cda:ClinicalDocument/cda:confidentialityCode"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
