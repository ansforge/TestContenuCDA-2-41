<?xml version="1.0" encoding="UTF-8"?>

<!-- E_allergiesAndIntolerances_int.sch
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entrée 
    PCC allergies and Intolerances (1.3.6.1.4.1.19376.1.5.3.1.4.6)  
    
    Historique :
    16/11/16 : NMA : Création
    26/06/17 : NMA : Ajout la contrainte sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_allergiesAndIntolerances_int">

    <title>IHE PCC v3.0 Allergies and Intolerances</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.6"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test='self::cda:observation[@classCode="OBS"]'>
            [E_AllergiesAndIntolerances_int] Erreur de Conformité PCC: Une entrée 'Allergies and intolerances' est un type particulier 
            de problème et sera de la même manière représentée comme une élément de type 'observation' 
            avec un attribut classCode='OBS'.</assert>
                
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.5"]'>
            [E_allergiesAndIntolerances_int] Erreur de Conformité PCC: Le template de l'entrée 'Allergies and intolerances' spécialise le template 
            de l'entrée 'Problem Entry'. A ce titre, le templateId de ce dernier (1.3.6.1.4.1.19376.1.5.3.1.4.5) sera déclaré.</assert>
        
        <assert test="$count_templateId&gt;2">
            [E_allergiesAndIntolerances_int] Erreur de conformité PCC : Dans l'élément "Allergies and intolerances", il doit y avoir au moins trois templateIds
        </assert>

        <assert test='cda:code[@code and @codeSystem]'>
            [E_allergiesAndIntolerances_int] Erreur de Conformité PCC: L'élément 'code' de l'entrée 'Allergies and Intolerances' indique le 
            type d'allergie provoqué (par un médicament, un facteur environnemental ou un aliment), 
            s'il s'agit d'une allergie, d'une intolérance sans manifestation allergique, ou encore un
            type inconnu de réaction (ni allergique, ni intolérance).
            L'élément 'code' doit obligatoirement comporter les attributs 'code' et 'codeSystem'.</assert>
        
        <assert test='(cda:value[@xsi:type="CD"]) and 
            (cda:value[@code and @codeSystem] or cda:value[not(@code) and not(@codeSystem)])'>
            [E_allergiesAndIntolerances_int] Erreur de Conformité PCC: L'élément 'value' décrit l'allergie ou la réaction adverse observée. 
            Alors que l'élément 'value' peut être un caractère codé ou non, son type sera 
            toujours 'coded value' (xsi:type='CD'). 
            Dans le cas de l'utilisation d'un code, les attributs les attributs 'code' et 'codeSystem'seront présents, 
            et dans le cas contraire, tout autre attribut que xsi:type='CD' seront absents.</assert>
    </rule>
</pattern>
