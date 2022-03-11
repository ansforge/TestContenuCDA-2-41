<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    relatedDocument_fr.sch :
    Contenu :
       Vérifie la conformité  de l'élément relatedDocument contenu dans l'entête en fonction du volet de structuration minimale
    Paramètres d'appel :
        néant
    Historique :
        15/06/2017 : LBE : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="relatedDocument_fr">
    <p>
        Si l'élément relatedDocument est présent alors son attribut typeCode doit valoir RPLC 
    </p>
    <rule context="cda:relatedDocument">  
        <let name="count_id" value="count(cda:parentDocument/cda:id)"/>
        <assert test="@typeCode='RPLC'">
            [relatedDocument_fr.sch] Erreur de conformité CI-SIS : ClinicalDocument/relatedDocument ne contient pas l'attribut typeCode avec la seule valeur autorisée : RPLC.
        </assert>
       <assert test="$count_id = 1">
           [relatedDocument_fr.sch] Erreur de conformité CI-SIS : ClinicalDocument/relatedDocument/parentDocument/id doit être présent une seule fois
       </assert>
        <assert test="cda:parentDocument/cda:id[@root]">
            [relatedDocument_fr.sch] Erreur de conformité CI-SIS : ClinicalDocument/relatedDocument/parentDocument/id doit contenir un élément root 
        </assert>
    </rule>
</pattern>