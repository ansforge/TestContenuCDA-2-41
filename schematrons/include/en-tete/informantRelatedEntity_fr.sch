<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    informantRelatedEntity.sch :
    Contenu :
        Contrôle d'un proche du patient  
    Paramètres d'appel :
        Néant
    Historique :
    05/06/2011 : Création
    15/06/2017 : Ajout de la vérification de relatedPerson
    30/09/2019 : Mise à jour de la liste des @classCode
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="informantRelatedEntity_fr">
    <rule context="cda:informant/cda:relatedEntity">
        <let name="count_name" value="count(cda:relatedPerson/cda:name)"/>
        <let name="count_family" value="count(cda:relatedPerson/cda:name/cda:family)"/>
        <let name="count_given" value="count(cda:relatedPerson/cda:name/cda:given)"/>
        
        <assert test="((name(@*) = 'classCode') and 
            (@* = 'ECON' or @* = 'NOK' or @* = 'CON' or @*='CAREGIVER' or @*='PAT')
                    )">
            [informantRelatedEntity_fr.sch] Erreur de conformité CI-SIS : L'élément informant/relatedEntity doit avoir un attribut classCode dont la valeur est dans l'ensemble :
            (ECON, NOK, CON, CAREGIVER, PAT).
        </assert>
        <assert test="count(./cda:addr) &gt;= 0">
            [informantRelatedEntity_fr.sch] Erreur de conformité CI-SIS : L'élément informant/relatedEntity peut comporter [0..*] adresse géographique (nullFlavor autorisé)
        </assert>
        <assert test="count(./cda:telecom) &gt;= 0">
            [informantRelatedEntity_fr.sch] Erreur de conformité CI-SIS : L'élément informant/relatedEntity peut comporter [0..*] adresse telecom (nullFlavor autorisé)
        </assert>
        <assert test="$count_name = 1">
            [informantRelatedEntity_fr.sch] Erreur de conformité CI-SIS : L'élément informant/relatedEntity/relatedPerson/name doit être présent, mais qu'une seule fois (cardinalité [1..1])
        </assert>
        <assert test="$count_family = 1">
            [informantRelatedEntity_fr.sch] Erreur de conformité CI-SIS : L'élément informant/relatedEntity/relatedPerson/name/family doit être présent, mais qu'une seule fois (cardinalité [1..1])      
        </assert>
        <assert test="$count_given &lt;= 1">
            [informantRelatedEntity_fr.sch] Erreur de conformité CI-SIS : L'élément informant/relatedEntity/relatedPerson/name/family doit être présent au maximum qu'une seule fois (cardinalité [0..1])
        </assert>
    </rule>
</pattern>