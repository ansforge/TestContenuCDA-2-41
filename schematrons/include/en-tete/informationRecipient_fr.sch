<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    informationRecipient_fr.sch :
    Contenu :
        Contrôle de la conformité de l'élément informationRecipient de l'en-tête en fonction du volet de structuration minimale
    Paramètres d'appel :
        Néant
    Historique :
        28/07/11 : FMY ASIP/PRAS : Création
        12/10/2021 : SBM : Modification sur le controle de l'élément cda:name/cda:prefix pour faire partie de l'un des deux TREs TRE_R81-Civilite
            ou TRE_R11-CiviliteExercice
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="informationRecipient_fr">
    <rule context="cda:informationRecipient/cda:intendedRecipient">
        <let name="count_id" value="count(cda:id)"/>
        <let name="count_informationRecipient" value="count(cda:informationRecipient)"/>
        <assert test="cda:id[@root='1.2.250.1.71.4.2.1'] and cda:id[@extension]">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/id doit être présent avec l'attribut @root fixé à "1.2.250.1.71.4.2.1" et l'attribut @extension doit être présent
        </assert>
        <assert test="$count_id &gt;= 0">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendRecipient/id peut être présent 0 ou plusieurs fois (cardinalité [0..*])
        </assert>
        <assert test="$count_informationRecipient &lt;= 1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient ne peut être présent qu'une seule fois au maximum(cardinalité [0..1])
        </assert>
    </rule>
    <!-- règle testant l'élément receivedOrganization -->
    <rule context="cda:informationRecipient/cda:intendedRecipient/cda:receivedOrganization">
        <let name="count_id" value="count(cda:id)"/>
        <let name="count_name" value="count(cda:name)"/>
        <assert test="$count_id &gt;= 0">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/receivedOrganization/id peut être présent 0 ou plusieurs fois (cardinalité [0..*])
        </assert>
        <assert test="$count_name &gt;= 0">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/receivedOrganization/name peut être présent 0 ou plusieurs fois (cardinalité [0..*])
        </assert>
        
    </rule>
    <!-- règle testant l'élément informationRecipient -->
    <rule context="cda:informationRecipient/cda:intendedRecipient/cda:informationRecipient">
        <let name="count_name" value="count(cda:name)"/>
        <let name="count_family" value="count(cda:name/cda:family)"/>
        <let name="count_given" value="count(cda:name/cda:given)"/>
        <let name="count_prefix" value="count(cda:name/cda:prefix)"/>
        <let name="count_suffix" value="count(cda:name/cda:suffix)"/>
        
        <assert test="$count_name &gt;= 0">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendRecipient/informationRecipient/name peut être présent 0 ou plusieurs fois (cardinalité [0..*])
        </assert>
        <assert test="$count_family=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient/name/family doit être présent, mais qu'une seule fois (cardinalité [1..1])
        </assert>
        <assert test="$count_given &lt;=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient/name/given ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_prefix &lt;=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient/name/prefix ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_suffix &lt;=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient/name/suffix ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="not(cda:name/cda:prefix) or (cda:name/cda:prefix and cda:name/cda:prefix = 'M' or cda:name/cda:prefix = 'MLLE' or cda:name/cda:prefix = 'MME'
            or cda:name/cda:prefix = 'DR' or cda:name/cda:prefix = 'MC' or cda:name/cda:prefix = 'MG' or cda:name/cda:prefix = 'PC' or cda:name/cda:prefix = 'PG' or cda:name/cda:prefix = 'PR' )"> [assignedAuthor_fr.sch] Erreur de
            conformité CI-SIS : l'élément assignedPerson/name/prefix doit faire partie de la table de référence  TRE_R81-Civilite ('M' ou 'MLLE' ou 'MME')
            ou TRE_R11-CiviliteExercice ('DR' ou 'MC' ou 'MG' ou 'PC' ou 'PG' ou 'PR')</assert>
        <assert test="not(cda:name/cda:suffix) or (cda:name/cda:suffix and cda:name/cda:suffix = 'DR' or cda:name/cda:suffix = 'MC' or cda:name/cda:suffix = 'MG'
            or cda:name/cda:suffix = 'PC' or cda:name/cda:suffix = 'PG' or cda:name/cda:suffix = 'PR')"> [informationRecipient_fr.sch] Erreur de
            conformité CI-SIS : l'élément  assignedPerson/name/suffix doit faire partie de la table de référence TRE_R11-CiviliteExercice ('DR' ou 'MC' ou 'MG' ou 'PC' ou 'PG' ou 'PR')
        </assert>
    </rule>
</pattern>