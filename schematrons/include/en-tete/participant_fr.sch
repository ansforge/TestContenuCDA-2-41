<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    participant_fr.sch :
    Contenu :
        Contrôle du participant dans l'en-tête CDA en fonction du volet de structuration minimale  
    Paramètres d'appel :
        Néant
    Historique :
    16/06/2017 : Création
    26/07/2017 : Correction des asserts sur le low et le high de la balise time et du context
    09/08/2017 : Suppression du test sur le typeCode du participant et du classCode de l'associatedEntity
    22/02/2019 : Mise à jour du test sur l'attribut IVL_TS de time pour inclure les auto-présentables
    30/09/2019 : Suppression du test présence obligatoire de l'élément participant/associatedEntity/associatedPerson
                 Réactivation des contrôles sur participant@typeCode et associatedEntity@classCode
    15/01/2020 : Ajout du test de présence des attributs code et codeSystem dans l'élément functionCode
    17/02/2020 : Suppression du test des JDV pour le typeCode en dur
    
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="participant_fr">
    <!-- Règle sur les éléments de premier niveau de participant -->
    <rule context="cda:ClinicalDocument/cda:participant">
     
        <assert test="cda:time[contains(@xsi:type,':IVL_TS')] or cda:time[@xsi:type='IVL_TS'] or cda:time[@nullFlavor]">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/time doit être présent et avoir le type fixé à la valeur 'IVL_TS'
        </assert>
        
        <assert test="cda:time/cda:low[@value] or not(cda:time/cda:low)">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/time/low doit contenir l'attribut @value
        </assert>
        <assert test="cda:time/cda:high[@value] or not(cda:time/cda:high)">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/time/high doit contenir l'attribut @value
        </assert>
        <assert test="not(cda:functionCode) or (cda:functionCode/@code and cda:functionCode/@codeSystem) or cda:functionCode/@nullFlavor">
            [participant_fr.sch] Erreur de conformité CI-SIS : Les attributs code et codeSystem sont obligatoires dans un élément functionCode
        </assert>
        
    </rule>
    
    <!-- Règle sur l'associatedEntity contenue dans participant -->
    <rule context="cda:participant/cda:associatedEntity">
        
        <assert test="@classCode='PROV' or @classCode='AGNT' or @classCode='ECON' or @classCode='GUARD' or @classCode='QUAL' or @classCode='POLHOLD' or 
            @classCode='CON' or @classCode='CAREGIVER' or @classCode='PAT'">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/associatedEntity[@classCode] doit faire partie de TRE_R260-HL7RoleClass(2.16.840.1.113883.5.110).
        </assert>
        
        <assert test="not(cda:code) or (cda:code and cda:code[@code] and cda:code[@codeSystem] and cda:code[@displayName])">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/associatedEntity/code doit contenir les attributs @code, @codeSystem et @displayName lorsqu'il est présent
        </assert>
        <!-- <assert test="cda:associatedPerson">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/associatedEntity/associatedPerson doit être présent dans l'associatedEntity
        </assert> -->
    </rule>
    <rule context="cda:participant/cda:associatedEntity/associatedPerson">
        <let name="count_name" value="count(cda:name)"/>
        <let name="count_family" value="count(cda:name/cda:family)"/>
        <let name="count_given" value="count(cda:name/cda:given)"/>
        <let name="count_prefix" value="count(cda:name/cda:prefix)"/>
        
        
        <assert test="$count_name=1">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/associatedEntity/associatedPerson/name doit être présent, mais qu'une seule fois (cardinalité [1..1])
        </assert>
        <assert test="$count_family=1">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/associatedEntity/associatedPerson/name/family doit être présent, mais qu'une seule fois (cardinalité [1..1])
        </assert>
        <assert test="$count_given &lt;=1">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/associatedEntity/associatedPerson/name/given peut être présent au maximum qu'une seule fois (cardinalité [0..1])
        </assert>
        <assert test="$count_prefix &lt;=1">
            [participant_fr.sch] Erreur de conformité CI-SIS : L'élément participant/associatedEntity/associatedPerson/name/prefix peut être présent au maximum qu'une seule fois (cardinalité [0..1])
        </assert>
    </rule>
</pattern>