<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    associatedEntity_fr.sch :
    Contenu :
        Contrôle d'un élément associatedEntity  
    Historique :
        13/12/2020 : SBM : Création
        12/10/2021 : SBM : Modification sur le controle de l'élément cda:name/cda:prefix pour faire partie de l'un des deux TREs TRE_R81-Civilite
            ou TRE_R11-CiviliteExercice
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="associatedEntity_fr">
    
    <rule context="cda:associatedEntity">
        <let name="count_id" value="count(cda:id)"/>
        <assert test="$count_id &lt;= 1"> [associatedEntity_fr.sch] Erreur de conformité CI-SIS :
            L'élément "id" ne peut être présent qu'une seule fois (cardinalité [0..1]) dans une associatedEntity </assert>
        <assert test="not(cda:id) or(cda:id and (cda:id[@root] and cda:id[@extension]) or cda:id[@nullFlavor] or cda:id)">
            [associatedEntity_fr.sch] Erreur de conformité CI-SIS : S'il existe, l'élément "id" doit comportant les
            attibuts @root et @extension </assert>
    </rule>
    
    <!-- Règle concernant l'élément scopingOrganization  -->
    <rule context="cda:associatedEntity/cda:scopingOrganization">
        <let name="count_scopingOrganization_name" value="count(cda:name)"/>
        
        <!-- Vérification de scopingOrganization -->
        <assert test="not(cda:id) or (cda:id and cda:id[@root])">
            [associatedEntity_fr.sch] Erreur de conformité CI-SIS : Lorsqu'il est présent, l'élément
            scopingOrganization/id doit avoir l'attribut @root</assert>
        <assert test="$count_scopingOrganization_name &lt;= 1"> [associatedEntity_fr.sch] Erreur
            de conformité CI-SIS : L'élément scopingOrganization/name ne peut être présent
            qu'une seule fois (cardinalité [0..1]) </assert>
        
    </rule>
    <!-- Règle concernant l'élément associatedPerson  -->
    <rule context="cda:associatedEntity/cda:associatedPerson">
        <let name="count_associatedPerson_name" value="count(cda:name)"/>
        <let name="count_associatedPerson_family" value="count(cda:name/cda:family)"/>
        <let name="count_associatedPerson_given" value="count(cda:name/cda:given)"/>
        <let name="count_associatedPerson_prefix" value="count(cda:name/cda:prefix)"/>
        <let name="count_associatedPerson_suffix" value="count(cda:name/cda:suffix)"/>
        <!-- Vérification de l'assigned Person -->
        <assert test="cda:name or @nullFlavor"> [associatedEntity_fr.sch] Erreur de conformité CI-SIS
            : Si l'élément associatedPerson n'est pas vide avec un nullFlavor, alors il doit comporter
            un élément fils "name" (nullFlavor autorisé). </assert>
        <assert test="$count_associatedPerson_name = 1"> [associatedEntity_fr.sch] Erreur de conformité
            CI-SIS : L'élément associatedPerson doit contenir un seul et unique élément name </assert>
        <assert test="$count_associatedPerson_family = 1"> [associatedEntity_fr.sch] Erreur de
            conformité CI-SIS : L'élément associatedPerson/name/family doit être présent et qu'une
            seule fois (cardinalité [1..1]) </assert>
        <assert test="$count_associatedPerson_given &lt;= 1"> [associatedEntity_fr.sch] Erreur de
            conformité CI-SIS : l'élément associatedPerson/name/given ne peut être présent qu'une
            seule fois (cardinalité [0..1]) </assert>
        <assert test="$count_associatedPerson_prefix &lt;= 1"> [associatedEntity_fr.sch] Erreur de
            conformité CI-SIS : l'élément associatedPerson/name/prefix ne peut être présent qu'une
            seule fois (cardinalité [0..1]) </assert>
        <assert test="$count_associatedPerson_suffix &lt;= 1"> [associatedEntity_fr.sch] Erreur de
            conformité CI-SIS : l'élément associatedPerson/name/suffix ne peut être présent qu'une
            seule fois (cardinalité [0..1]) </assert>
        <assert test="not(cda:name/cda:prefix) or (cda:name/cda:prefix and cda:name/cda:prefix = 'M' or cda:name/cda:prefix = 'MLLE' or cda:name/cda:prefix = 'MME'
            or cda:name/cda:prefix = 'DR' or cda:name/cda:prefix = 'MC' or cda:name/cda:prefix = 'MG' or cda:name/cda:prefix = 'PC' or cda:name/cda:prefix = 'PG' or cda:name/cda:prefix = 'PR' )"> [assignedAuthor_fr.sch] Erreur de
            conformité CI-SIS : l'élément assignedPerson/name/prefix doit faire partie de la table de référence  TRE_R81-Civilite ('M' ou 'MLLE' ou 'MME')
            ou TRE_R11-CiviliteExercice ('DR' ou 'MC' ou 'MG' ou 'PC' ou 'PG' ou 'PR')</assert>
        <assert test="not(cda:name/cda:suffix) or (cda:name/cda:suffix and cda:name/cda:suffix = 'DR' or cda:name/cda:suffix = 'MC' or cda:name/cda:suffix = 'MG'
            or cda:name/cda:suffix = 'PC' or cda:name/cda:suffix = 'PG' or cda:name/cda:suffix = 'PR')"> [associatedEntity_fr.sch] Erreur de
            conformité CI-SIS : l'élément associatedPerson/name/suffix doit faire partie de la table de référence TRE_R11-CiviliteExercice ('DR' ou 'MC' ou 'MG' ou 'PC' ou 'PG' ou 'PR')
        </assert>
    </rule>
</pattern>
