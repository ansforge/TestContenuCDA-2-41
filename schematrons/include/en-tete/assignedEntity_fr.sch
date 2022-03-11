<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    assignedEntity_fr.sch :
    Contenu :
        Contrôle d'un élément assignedEntity  
    Paramètres d'appel :
        Néant
    Historique :
        14/06/2017 : LBE : Création
        04/08/2017 : NMA : Ajout de l'attribut nullFlavor pour l'ID
        12/10/2021 : SBM : Modification sur le controle de l'élément cda:name/cda:prefix pour faire partie de l'un des deux TREs TRE_R81-Civilite
            ou TRE_R11-CiviliteExercice
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="assignedEntity_fr">

    <rule context="cda:assignedEntity">
        <let name="count_id" value="count(cda:id)"/>
        <assert test="$count_id = 1"> [assignedEntity_fr.sch] Erreur de conformité CI-SIS :
            L'élément "id" ne doit être présent qu'une seule et unique fois dans une assignedEntity </assert>
        <assert test="(cda:id[@root] and cda:id[@extension]) or cda:id[@nullFlavor]">
            [assignedEntity_fr.sch] Erreur de conformité CI-SIS : L'élément "id" doit comportant les
            attibuts @root et @extension </assert>

    </rule>

    <!-- Règle concernant l'élément representedOrganization  -->
    <rule context="cda:assignedEntity/cda:representedOrganization">
        <let name="count_representedOrganization_id" value="count(cda:id)"/>
        <let name="count_representedOrganization_name" value="count(cda:name)"/>

        <!-- Vérification de representedOrganization -->
        <assert test="not(cda:id) or (cda:id and cda:id[@root = '1.2.250.1.71.4.2.2'])">
            [assignedEntity_fr.sch] Erreur de conformité CI-SIS : Lorsqu'il est présent, l'élément
            representedOrganization/id doit avoir l'attribut@root='1.2.250.1.71.4.2.2' </assert>
        <assert test="$count_representedOrganization_name &lt;= 1"> [assignedEntity_fr.sch] Erreur
            de conformité CI-SIS : L'élément representedOrganization/name ne peut être présent
            qu'une seule fois (cardinalité [0..1]) </assert>

    </rule>
    <!-- Règle concernant l'élément assignedPerson  -->
    <rule context="cda:assignedEntity/cda:assignedPerson">
        <let name="count_assignedPerson_name" value="count(cda:name)"/>
        <let name="count_assignedPerson_family" value="count(cda:name/cda:family)"/>
        <let name="count_assignedPerson_given" value="count(cda:name/cda:given)"/>
        <let name="count_assignedPerson_prefix" value="count(cda:name/cda:prefix)"/>
        <let name="count_assignedPerson_suffix" value="count(cda:name/cda:suffix)"/>
        <!-- Vérification de l'assigned Person -->
        <assert test="cda:name or @nullFlavor"> [assignedEntity_fr.sch] Erreur de conformité CI-SIS
            : Si l'élément assignedPerson n'est pas vide avec un nullFlavor, alors il doit comporter
            un élément fils "name" (nullFlavor autorisé). </assert>
        <assert test="$count_assignedPerson_name = 1"> [assignedEntity_fr.sch] Erreur de conformité
            CI-SIS : L'élément assignedPerson doit contenir un seul et unique élément name </assert>
        <assert test="$count_assignedPerson_family = 1"> [assignedEntity_fr.sch] Erreur de
            conformité CI-SIS : L'élément assignedPerson/name/family doit être présent et qu'une
            seule fois (cardinalité [1..1]) </assert>
        <assert test="$count_assignedPerson_given &lt;= 1"> [assignedEntity_fr.sch] Erreur de
            conformité CI-SIS : l'élément assignedPerson/name/given ne peut être présent qu'une
            seule fois (cardinalité [0..1]) </assert>
        <assert test="$count_assignedPerson_prefix &lt;= 1"> [assignedEntity_fr.sch] Erreur de
            conformité CI-SIS : l'élément assignedPerson/name/prefix ne peut être présent qu'une
            seule fois (cardinalité [0..1]) </assert>
        <assert test="$count_assignedPerson_suffix &lt;= 1"> [assignedEntity_fr.sch] Erreur de
            conformité CI-SIS : l'élément assignedPerson/name/suffix ne peut être présent qu'une
            seule fois (cardinalité [0..1]) </assert>
        <assert test="not(cda:name/cda:prefix) or (cda:name/cda:prefix and cda:name/cda:prefix = 'M' or cda:name/cda:prefix = 'MLLE' or cda:name/cda:prefix = 'MME'
            or cda:name/cda:prefix = 'DR' or cda:name/cda:prefix = 'MC' or cda:name/cda:prefix = 'MG' or cda:name/cda:prefix = 'PC' or cda:name/cda:prefix = 'PG' or cda:name/cda:prefix = 'PR' )"> [assignedAuthor_fr.sch] Erreur de
            conformité CI-SIS : l'élément assignedPerson/name/prefix doit faire partie de la table de référence  TRE_R81-Civilite ('M' ou 'MLLE' ou 'MME')
            ou TRE_R11-CiviliteExercice ('DR' ou 'MC' ou 'MG' ou 'PC' ou 'PG' ou 'PR')</assert>
        <assert test="not(cda:name/cda:suffix) or (cda:name/cda:suffix and cda:name/cda:suffix = 'DR' or cda:name/cda:suffix = 'MC' or cda:name/cda:suffix = 'MG'
            or cda:name/cda:suffix = 'PC' or cda:name/cda:suffix = 'PG' or cda:name/cda:suffix = 'PR')"> [assignedEntity_fr.sch] Erreur de
            conformité CI-SIS : l'élément  assignedPerson/name/suffix doit faire partie de la table de référence TRE_R11-CiviliteExercice ('DR' ou 'MC' ou 'MG' ou 'PC' ou 'PG' ou 'PR')
        </assert>
    </rule>
</pattern>
