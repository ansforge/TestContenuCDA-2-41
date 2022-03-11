<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    E_FR-Resultats-examens-de-biologie-medicale.sch :
    
    Vérification de la conformité d'une entrée FR-Resultats-examens-de-biologie-medicale (1.3.6.1.4.1.19376.1.3.1) 
    
    Historique :
    13/01/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_FR-Resultats-examens-de-biologie-medicale">
    <p>Vérification de la conformité d'une entrée FR-Resultats-examens-de-biologie-medicale (1.3.6.1.4.1.19376.1.3.1)</p>
    
    <rule context="cda:entry/cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']">

        <assert test="../@typeCode"> 
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité :
            un élément entry d'un CR de biologie doit comporter l'attribut typeCode. 
        </assert>
        
        <assert test="../cda:act and 
            (../cda:act/cda:code[@codeSystem = '2.16.840.1.113883.6.1'] or not(../cda:act/cda:code/@code))"> 
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité :
            Un élément entry doit avoir un élément fils act et le code de cet act s'il existe,
            doit appartenir à la terminologie LOINC. 
        </assert>
        
        <assert test="../cda:act/cda:statusCode[@code = 'completed'] or
                ../cda:act/cda:statusCode[@code = 'active'] or
                ../cda:act/cda:statusCode[@code = 'aborted']"> 
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité :
            Un élément entry doit avoir un élément fils act avec un statusCode@code valant 
            'completed', 'active' ou 'aborted'. 
        </assert>
        
        <assert test="../cda:act/cda:entryRelationship[@typeCode = 'COMP']">
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : 
            Un élément entry doit avoir au moins un petit fils act/entryRelationship
            avec un attribut typeCode valant 'COMP'. 
        </assert>
        
    </rule>
    
    <rule context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:observation">
        <assert test="cda:code[@code and @codeSystem='2.16.840.1.113883.6.1' and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])">
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </assert>
    </rule>
    
    <rule context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:observation/cda:code/cda:translation">
        <assert test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)">
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
        </assert>
    </rule>
    
    <rule context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation">
        <assert test="cda:code[@code and @codeSystem='2.16.840.1.113883.6.1' and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])">
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité CR-BIO : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </assert>
    </rule>
    
    <rule context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation/cda:code/cda:translation">
        <assert test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)">
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
        </assert>
    </rule>
    
    <rule context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation">
        <assert test="cda:code[@code and @codeSystem='2.16.840.1.113883.6.1' and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])">
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </assert>
    </rule>
    
    <rule context="cda:entry[cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1']]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation/cda:code/cda:translation">
        <assert test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)">
            [E_FR-Resultats-examens-de-biologie-medicale] Erreur de conformité : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
        </assert>
    </rule>
    
</pattern>
