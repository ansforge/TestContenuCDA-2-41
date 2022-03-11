<?xml version="1.0" encoding="UTF-8"?>

<!-- Schématron E_severity_int.sch 
     Teste la conformité d'une entrée "Sévérité" utilisée dans un document du CI-SIS aux spécifications de l'entryRelationship PCC severity (1.3.6.1.4.1.19376.1.5.3.1.4.1)      
    
    Historique :
    22/06/2017 : Création
    22/06/2017 : Ajout des contraintes internationales 
    05/10/2017 : Modification du test sur la value
    30/01/2020 : Mise à jour du test sur le nombre de templateId
    02/10/2020 : Suppression du JDV utilisé car non obligatoire
    01/12/2020 : Renommé
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_severity_int">

    <title>IHE PCC v3.0 Severity</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.1"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test='../../cda:entryRelationship[@typeCode="SUBJ" and @inversionInd="true"]'>
            [ER_severity_int]Erreur de Conformité PCC: Une entrée 'severity' représente la sévérité et sera de la même manière représentée comme une élément de type 'observation' 
            avec un attribut typeCode='SUBJ' et un inversionIND='true'.
        </assert>
        
        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [ER_severity_int] Erreur de conformité PCC : Dans l'élément "severity", le format de base utilisé pour 
            représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
            signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer 
            que l'événement a déjà eu lieu.
        </assert>
        
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.55"]'>
            [ER_severity_int]Erreur de Conformité PCC: Le template parent (2.16.840.1.113883.10.20.1.55) sera déclaré.
        </assert>
        
        <assert test="$count_templateId&gt;1">
            [ER_severity_int] Erreur de conformité PCC : Dans l'élément "Severity", il doit y avoir au minimum deux templateId
        </assert>

        <assert test='cda:code[@code and @codeSystem]'>
            [ER_severity_int] Erreur de Conformité PCC: L'élément 'code' de l'entrée 'severity' indique la 
            sévérité de l'allergie provoquée.
            L'élément 'code' doit obligatoirement comporter les attributs 'code' et 'codeSystem'.
        </assert>
        
        <assert test="cda:text/cda:reference[@value]">
            [ER_severity_int] Erreur de conformité PCC : L'élément text doit être présent avec un élément reference qui contient une URI dans l'attribut @value
        </assert>
        
        <assert test="cda:statusCode[@code='completed']"> 
            [ER_severity_int] Erreur de conformité PCC : Le composant "statutCode" d'un élément "health Status Observation" sera toujours fixé à la valeur code='completed'.
        </assert>
        
        <!-- [ANS 02/10/2020] Suppression du JDV utilisé car non obligatoire -->
        <!-- <assert test='(cda:value[@xsi:type="CD"]) and 
            (cda:value[@codeSystem="2.16.840.1.113883.5.1063"] or cda:value[not(@code) and not(@codeSystem)])'>
            [ER_severity_int] Erreur de Conformité PCC: Alors que l'élément 'value' peut être un caractère codé ou non, son type sera 
            toujours 'coded value' (xsi:type='CD'). 
            Dans le cas de l'utilisation d'un code, les attributs  'code' et 'codeSystem'seront présents, 
            et dans le cas contraire, tout autre attribut que xsi:type='CD' seront absents.
            Si présents, le codeSystem sera égal à '2.16.840.1.113883.5.1063' et le code à 'H|M|L'
        </assert> -->
        
        <assert test='(cda:value[@xsi:type="CD"]) and 
            (cda:value[(@code) and (@codeSystem)] or cda:value[not(@code) and not(@codeSystem) and not(@displayName) and not(@codeSystemName)])'>
            [ER_severity_int] Erreur de conformité PCC : Alors que l'élément 'value' peut être codé ou non, son type sera 
            toujours 'coded value' (xsi:type='CD'). 
            S'il est codé, les attributs  'code' et 'codeSystem' sont obligatoires, sinon, tout attribut autre que xsi:type='CD' est interdit.
        </assert>
        
    </rule>
</pattern>
