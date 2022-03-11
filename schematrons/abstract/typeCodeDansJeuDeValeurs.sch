<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    typeCodeDansJeuDeValeurs.sch :
    Contenu :
        Contrôle d'appartenance d'une valeur codée obligatoire à un jeu de valeurs externe : code, displayName et codeSystem
        L'élément n'est pas contrôlé s'il n'est pas de type CD ou CE.
    Paramètres d'appel :
        $path_jdv : chemin du jeu de valeurs externe (fichier conforme au schéma CI-SIS_jeuDeValeurs.xsd)
        $vue_elt : chaine affichable représentant le chemin de l'élément codé à contrôler dans le document courant
        $xpath_elt : contexte xpath de l'élément codé dans le document courant
        $nullFlavor (0/1) : nullFlavor autorisé (1) ou non (0)
    Historique :
        27/05/11 : FMY ASIP/PRAS : Création
        29/07/11 : FMY ASIP/PRAS : Protection contre les changements de type (xsi:type) de l'élément. Seuls les types CD et CE sont contrôlés.
        05/11/2013 : CR : extension des valeurs de nullFlavor aux valeurs permises par CDA : NI, OTH
        24/11/2020 : extension des valeurs de nullFlavor aux valeurs permises par CDA : NA
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="typeCodeDansJeuDeValeurs" abstract="true" 
    xmlns:svs="urn:ihe:iti:svs:2008">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="$xpath_elt">
        <let name="att_typeCode" value="@typeCode"/>        
        
        <assert test="
            (document($path_jdv)//svs:Concept[@code=$att_typeCode])
            ">
            [typeCodeDansJeuDeValeurs] L'élément <value-of select="$vue_elt"/>
            [<value-of select="$att_typeCode"/> 
            doit faire partie du jeu de valeurs <value-of select="$path_jdv"/>.
        </assert>
    </rule>
</pattern>   
