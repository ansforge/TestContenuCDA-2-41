<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   JDV_encompassingEncounterCode.sch
    
    Contenu :
        Contrôle du componentOf/encompassingEncounter/code d'un componentOf (nullFlavor autorisé)
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier TRE :
        ../../jeuxDeValeurs/TRE_R304-HL7v3ActCode.xml 
        ../../jeuxDeValeurs/TRE_R305-TypeRencontre.xml
        dans le schématron CI-SIS_StructurationMinimale.sch)
        
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        13/10/2021 : SBM : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_encompassingEncounterCode" is-a="abstractEncompassingEncounterCode">
    <p>Conformité du componentOf/encompassingEncounter/code au CI-SIS</p>
    <param name="path_jdv1" value="$jdv_encompassingEncounterCode_1"/>
    <param name="path_jdv2" value="$jdv_encompassingEncounterCode_2"/>
    <param name="vue_elt" value="'ClinicalDocument/componentOf/encompassingEncounter/code'"/>
    <param name="xpath_elt" value="cda:componentOf/cda:encompassingEncounter/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
