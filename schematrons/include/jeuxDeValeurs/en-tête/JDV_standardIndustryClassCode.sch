<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_standardIndustryClassCode .sch
    
    Contenu :
        Contrôle du du cadre d'exercice du PS (nullFlavor non autorisé)
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_authorSpecialty a été valorisé à :
        ../../jeuxDeValeurs/TRE_A00-ProducteurDocNonPS.xml
         ../../jeuxDeValeurs/TRE_A01-CadreExercice.xml
        dans le schématron CI-SIS_StructurationMinimale.sch).
        
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
    Historique :
        11/12/2020 : SBM : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_standardIndustryClassCode" is-a="abstractStandardIndustryClassCode">
    <p>Conformité du cadre d'exercice du PS</p>
    <param name="path_jdv1" value="$jdv_standardIndustryClassCode_1"/>
    <param name="path_jdv2" value="$jdv_standardIndustryClassCode_2"/>
    <param name="vue_elt" value="'standardIndustryClassCode'"/>
    <param name="xpath_elt" value="cda:standardIndustryClassCode"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
