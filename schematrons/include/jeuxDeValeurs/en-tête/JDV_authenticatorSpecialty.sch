<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_authenticatorSpecialty.sch (spécialisation du pattern dansJeuDeValeurs.sch)
    
    Contenu :
        Contrôle du code profession/spécialité d'un authenticator s'il est présent (nullFlavor autorisé)
        
    Paramètres d'appel :
        "path_jdv" : chemin relatif du fichier jeu de valeurs (ici jdv_authenticatorSpecialty a été valorisé à ../../jeuxDeValeurs/JDV_AuthorSpecialty-CISIS.xml dans le schématron CI-SIS_StructurationMinimale.sch)
        "vue_elt" : chemin de l'élément codé dans le CDA affiché dans le message d’erreur
        "xpath_elt" : contexte xpath de l'élément codé à contrôler dans le JDV
        "nullFlavor" : nullFlavor autorisé (1) ou non (0)
        
    Historique :
        28/10/20 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_authenticatorSpecialty" is-a="dansJeuDeValeurs">
    <p>Conformité de la profession/spécialité d'un authenticator</p>
    <param name="path_jdv" value="$jdv_authenticatorSpecialty"/>
    <param name="vue_elt" value="'authenticator/assignedEntity/code'"/>
    <param name="xpath_elt" value="cda:authenticator/cda:assignedEntity/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern>   
