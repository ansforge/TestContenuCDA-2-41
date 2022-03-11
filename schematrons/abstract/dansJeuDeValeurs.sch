<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    dansJeuDeValeurs.sch :
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
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="dansJeuDeValeurs" abstract="true" 
         xmlns:svs="urn:ihe:iti:svs:2008">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="$xpath_elt">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or $nullFlavor)">
           [dansJeuDeValeurs] L'élément "<value-of select="$vue_elt"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(
            (@code and @codeSystem) or
            ($nullFlavor and 
            (@nullFlavor='UNK' or 
            @nullFlavor='NA' or 
            @nullFlavor='NASK' or 
            @nullFlavor='ASKU' or 
            @nullFlavor='NI' or 
            @nullFlavor='NAV' or 
            @nullFlavor='MSK' or 
            @nullFlavor='OTH')) or
            (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))
            )">
            [dansJeuDeValeurs] L'élément "<value-of select="$vue_elt"/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(
            @nullFlavor or
            (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or 
            (document($path_jdv)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])
            )">
        <!--  débrayage du contrôle sur le displayName qui risque de générer un trop grand nombre d'assert-failed en raison d'une différence 
              non significative de libellé (pb de casse d'un caractère, un espace en trop, un caractère "'" mal codé ...
        <assert test="@nullFlavor or 
                     (document($path_jdv)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem and @displayName=$att_displayName])">
        -->
            [dansJeuDeValeurs] L'élément <value-of select="$vue_elt"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$path_jdv"/>.
        </assert>
    </rule>
</pattern>   
