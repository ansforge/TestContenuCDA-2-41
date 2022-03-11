<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ problemEntry.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "E_problemEntry_int" (1.3.6.1.4.1.19376.1.5.3.1.4.5)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/07/11 : CRI : Création
    21/06/17 : LBE :  Ajout des conventions de nommage
                        Ajout du compte des templateId
    21/06/17 : NMA : Correction des attributs des relationships
                    Suppression de deux asserts concernant la value car ces tests ne sont pas obligatoires
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_problemEntry_int">
    <title>IHE PCC v3.0 Problem Entry</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [E_problemEntry_int.sch] Erreur de conformité PCC : Dans l'élément "Problem Entry", le format de base utilisé pour 
            représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
            signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer 
            que l'événement a déjà eu lieu. </assert>

        <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.28']"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Dans l'élément "Problem Entry", les éléments &lt;templateId&gt; 
            identifient l'entrée comme répondant aux spécifications de PCC et de CCD (2.16.840.1.113883.10.20.1.28). 
            Cette déclaration de conformité est requise.</assert>
        
        <assert test="$count_templateId &gt;=1">
            [E_problemEntry_int.sch] Erreur de conformité PCC : Dans l'élément "Problem Entry", il doit y avoir au minimum deux templateId 
        </assert>
        
        <assert test="count(./cda:id) = 1"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC :  L'élément "Problem Entry" doit nécessairement avoir un identifiant (&lt;id&gt;) 
            qui est utilisé à des fins de traçage. Si la source d'information du SIS ne fournit pas d'identifiant, 
            un GUID sera affecté comme attribut "root", sans extension (ex: id root='CE1215CD-69EC-4C7B-805F-569233C5E159'). 
            Bien que CDA permette l'utilisation de plusieurs identifiants, "Problem Entry" impose qu'un identifiant 
            seulement soit présent. </assert>
        <assert test="cda:text/cda:reference[@value]">
            [E_problemEntry_int.sch] Erreur de conformité PCC : L'élément text doit être présent avec un élément reference qui contient une URI dans l'attribut @value
        </assert>
        
        <assert test="count(cda:value/cda:originalText)=1">
            [E_problemEntry_fr] Erreur de conformité CI-SIS : L'élément "originalText" doit être présent une fois dans l'élément value
        </assert>
        
        <assert test="cda:statusCode[@code='completed']"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Un élément "Problem Entry" décrit l'observation d'un fait clinique. 
            Son composant "statutCode" sera donc toujours fixé à la valeur code='completed'. </assert>

        <report test="cda:effectiveTime/cda:width or cda:effectiveTime/cda:center"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Bien que CDA permette de nombreuses modalités pour exprimer un intervalle de 
            temps (low/high, low/width, high/width, ou center/width), Problem Entry sera contraint à l'utilisation
            exclusive de la forme low/high.</report>

        <assert test="cda:effectiveTime/cda:low[@value or @nullFlavor = 'UNK'] or cda:effectiveTime/cda:low[@value or @nullFlavor = 'NAV']"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : La composante "low" de l'élément "effectiveTime" doit être exprimée dans 
            un élément "Problem Entry".
            Des exceptions sont cependant admises, comme dans le cas où le patient ne se souvient pas de 
            la date de survenue d'une affection (ex: rougeole dans l'enfance sans date précise).
            Dans ce cas, l'élément "low" aura pour attribut un "nullFlavor" fixé à la valeur 'UNK'. </assert>

        <assert test="cda:value[contains(@xsi:type,'CD')]"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : L'élément "value" correspond à l'état (clinique) décrit et est donc obligatoire.
            Cet élément est toujours codé et son type sera toujours de type 'CD'. </assert>

        <assert test="(cda:value[@code and @codeSystem]) or
                    (not(cda:value[@code]) and not(cda:value[@codeSystem]))"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Si l'élément "value" est codé, les attributs "code" et "codeSystem" 
            seront obligatoirement présents. </assert>
        
        
        <!-- Sévérité d'une affection -->
        <assert
            test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1']) &lt;= 1"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Un et un seul élément évaluant la sévérité d'une affection 
            sera présent (entryRelationship) pour une entrée "Problem Entry" </assert>

        <assert
            test="not(cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1']) or
                    (cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1'] and
                    cda:entryRelationship[@typeCode='SUBJ'])"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC :un élément "entryRelationship" optionnel peut être présent 
            et donner une indication sur la sévérité d'une affection. S'il est présent, cet élément 
            se conformera au template Severity Entry (1.3.6.1.4.1.19376.1.5.3.1.4.1).
            Son attribut 'typeCode' prendra alors la valeur 'SUBJ'. </assert>
        
        <!-- Statut d'une affection -->
        <assert
            test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1']) &lt;= 1"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Un et un seul élément évaluant le statut d'une affection (Problem Status Observation)
            sera présent par le biais d'une relation "entryRelationship" pour toute entrée "Problem Entry"</assert>

        <assert
            test="not(cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1']) or
                    (cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1'] and
                    cda:entryRelationship[@typeCode='REFR'])"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : un élément "entryRelationship" optionnel peut être présent 
            et donner une indication sur le statut clinique d'une affection -- cf. value set "PCC_ClinicalStatusCodes" (1.2.250.1.213.1.1.4.2.283.2). 
            S'il est présent, cet élément se conformera au template "Problem Status Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.1.1).
            Son attribut 'typeCode' prendra alors la valeur 'REFR'.</assert>

        <!-- Statut de l'état de santé du patient -->
        <assert
            test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2']) &lt;= 1"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : Un et un seul élément évaluant le statut de l'état de santé 
            d'un patient (Health Status Observation) sera présent par le biais d'une relation "entryRelationship" 
            pour toute entrée "Problem Entry". </assert>

        <assert
            test="not(cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2']) or
                    (cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2'] and
                    cda:entryRelationship[@typeCode='REFR'])"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : un élément "entryRelationship" optionnel peut être présent et donner
            une indication sur le statut de l'état de santé d'un patient -- cf. value set "PCC_HealthStatusCodes" (1.2.250.1.213.1.1.4.2.283.1). 
            S'il est présent, cet élément se conformera au template "Health Status Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.1.2).
            Son attribut 'typeCode' prendra alors la valeur 'REFR'.</assert>
        
        <!-- Commentaire(s) -->
        <assert
            test="not(cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.2']) or
                    (cda:entryRelationship/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.2'] and
                    cda:entryRelationship[@typeCode='REFR'])"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : un ou plusieurs éléments "entryRelationship" optionnels peuvent être présents et 
            permettre d'apporter des informations additionnelles sur le problème observé.
            S'il est présent, cet élément se conformera au template "Comment Entry" (1.3.6.1.4.1.19376.1.5.3.1.4.2).
            Son attribut 'typeCode' prendra alors la valeur 'REFR'.</assert>

        <assert test="cda:code">  
            [E_problemEntry_int.sch] Erreur de conformité PCC : L'élément code -- cf. jeu de valeurs "PCC_ProblemCodes" (1.2.250.1.213.1.1.4.2.283.3) 
            d'une entrée Problem Entry permet d'établir à quel stade diagnostique se positionne un problème : par exemple un diagnostic 
            est un stade plus évolué qu'un symptôme dans la description d'un problème. Cette évaluation est importante pour les cliniciens. </assert>
        
        
        <report test="cda:uncertaintyCode"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : CDA permet à la description d'un état clinique un certain degré d'incertitude avec 
            l'élément "uncertaintyCode". En l'absence actuelle de consensus clairement établi sur le bon usage de cet élément, 
            PCC déconseille de l'utiliser dans le cadre d'une entrée Problem Entry.</report>   
        
        <report test="cda:confidentialityCode"> 
            [E_problemEntry_int.sch] Erreur de conformité PCC : CDA permet l'utilisation de l'élément "confidentialtyCode" pour une observation.
            PCC déconseille cependant pour des raisons pratiques de l'utiliser dans le cadre d'une entrée Problem Entry.
            Il y a en effet d'autres manières d'assurer la confidentialité des documents, qui pourront être résolus au sein
            du domaine d'affinité.</report>
        

    </rule>
</pattern>
