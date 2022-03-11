<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    abstractTypeCode.sch :
    Contenu :
        Contrôle d'appartenance d'une valeur codée obligatoire à TRE : code, displayName et codeSystem
        L'élément n'est pas contrôlé s'il n'est pas de type CD ou CE.
    Paramètres d'appel :
        $path_jdv : chemin du TRE
        $vue_elt : chaine affichable représentant le chemin de l'élément codé à contrôler dans le document courant
        $xpath_elt : contexte xpath de l'élément codé dans le document courant
        $nullFlavor (0/1) : nullFlavor autorisé (1) ou non (0)
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="abstractTypeCode" abstract="true" 
    xmlns:svs="urn:ihe:iti:svs:2008">
    <p>Conformité d'un élément codé obligatoire par rapport à TRE du CI-SIS</p>
    <rule context="$xpath_elt">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or $nullFlavor)">
            [abstractTypeCode] L'élément "<value-of select="$vue_elt"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(
            (@code and @codeSystem) or
            (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))
            )">
            [abstractTypeCode] L'élément "<value-of select="$vue_elt"/>" doit avoir ses attributs 
            @code, @codeSystem renseignés, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(
            (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or 
            (document($path_jdv1)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])
            or  (document($path_jdv2)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem]))">
            [abstractTypeCode] L'élément <value-of select="$vue_elt"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$path_jdv1"/> ou <value-of select="$path_jdv2"/> .
        </assert>
    </rule>
</pattern>   
