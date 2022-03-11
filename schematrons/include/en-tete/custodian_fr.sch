<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    custodian_fr.sch :
    Contenu :
        test la conformité du custodian dans l'entête en fonction de la conformité du volet de structuration minimale
    Paramètres d'appel :
        Néant
    Historique :
        16/06/2017 : LBE : Création
        18/10/17 : NMA : Ajout du nullFlavor sur le test
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="custodian_fr">
    <rule context="cda:representedCustodianOrganization">
        <let name="count_id" value="count(cda:id)"/>
        <assert test="cda:id[@root='1.2.250.1.71.4.2.2'] or cda:id[@root='1.2.250.1.213.4.1'] or cda:id[@nullFlavor]">
            [custodian_fr.sch] Erreur de conformité CI-SIS : L'élément representedCustodianOrganization/id doit être présent et doit contenir l'attribut @root soit à la valeur "1.2.250.1.71.4.2.2" ou "1.2.250.1.213.4.1"
        </assert>
        <assert test="$count_id = 1">
            [custodian_fr.sch] Erreur de conformité CI-SIS : L'élément representedCustodianOrganization/id doit être présent qu'une seule fois 
        </assert>
       
    </rule>
</pattern>
