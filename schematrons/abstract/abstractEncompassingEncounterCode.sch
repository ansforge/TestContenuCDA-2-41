<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    abstractEncompassingEncounterCode.sch :
    Contenu :
        Contrôle de l'élement code par rapport aux TREs définis dans CI-SIS_StructurationMinimale.sch
        
    Paramètres d'appel :
        $path_jdv1 : chemin du jeu de valeurs externe (fichier conforme au schéma CI-SIS_jeuDeValeurs.xsd)
        $path_jdv2 : chemin du jeu de valeurs externe (fichier conforme au schéma CI-SIS_jeuDeValeurs.xsd)
        $vue_elt : chaine affichable représentant le chemin de l'élément codé à contrôler dans le document courant
        $xpath_elt : contexte xpath de l'élément codé dans le document courant
        $nullFlavor (0/1) : nullFlavor autorisé (1) ou non (0)
    Historique :
        13/10/2021 : SBM : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="abstractEncompassingEncounterCode" abstract="true" 
    xmlns:svs="urn:ihe:iti:svs:2008">
    <p>Contrôle de l'appartenance du componentOf/encompassingEncounterCode/code aux TREs du CI-SIS</p>
    <rule context="$xpath_elt">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
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
            [abstractEncompassingEncounterCode] L'élément "<value-of select="$vue_elt"/>" doit avoir ses attributs 
            @code et @codeSystem renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(
            @nullFlavor or
            (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or 
            (document($path_jdv1)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem]) or  (document($path_jdv2)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])
            )">
            [abstractEncompassingEncounterCode] L'élément <value-of select="$vue_elt"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$path_jdv1"/> ou <value-of select="$path_jdv2"/>.
        </assert>
    </rule>
</pattern>   
