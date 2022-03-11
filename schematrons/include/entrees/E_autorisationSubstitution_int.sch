<?xml version="1.0" encoding="UTF-8"?>

<!-- E_autorisationSubstitution_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Autorisation-substitution à IHE PHARM PRE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_autorisationSubstitution_int">
        <title>IHE PHARM PRE Entrée FR-Autorisation-substitution</title>    
        
        <rule context="//cda:entryRelationship[@typeCode='COMP']/cda:act[@classCode='ACT'][@moodCode='DEF']">
            
            <!-- Test des templateId pour l'entrée "IHE PRE Substitution Permission" -->
            <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']">
                [1] [E_autorisationSubstitution_int.sch] Erreur de conformité IHE PRE : 
                L'entrée FR-Autorisation-substitution doit avoir un 'templateId' @root="1.3.6.1.4.1.19376.1.9.1.3.9.1".
            </assert>
            
            <!-- Test présence et format de l'élément 'code' -->
            <assert test="(count(cda:code[@code][@codeSystem='2.16.840.1.113883.5.1070'])=1)">
                [2] [E_autorisationSubstitution_int.sch] Erreur de conformité IHE PRE : 
                L'entrée FR-Autorisation-substitution doit comporter un élément 'code'. 
                Les attributs @code et @codeSystem sont obligatoires et doivent être issus du JDV_HL7_ActSubstanceAdminSubstitutionCode-CISIS (2.16.840.1.113883.5.1070).
            </assert>
            
            <!-- Test de la présence de l'élément 'statusCode' -->
            <assert test="(count(cda:statusCode[@code='completed'])=1)">
                [3] [E_autorisationSubstitution_int.sch] Erreur de conformité IHE PRE :  
                L'entrée FR-Autorisation-substitution doit comporter un élément 'statusCode' et son attribut @code="completed". 
            </assert>
    
        </rule>
            
    </pattern>
