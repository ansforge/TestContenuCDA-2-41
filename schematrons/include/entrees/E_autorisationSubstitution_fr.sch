<?xml version="1.0" encoding="UTF-8"?>

<!-- E_autorisationSubstitution_fr
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Autorisation-substitution (IHE-PRE - Substitution-Permission - 1.3.6.1.4.1.19376.1.9.1.3.9.1) au CI-SIS.
     ......................................................................................................................................................
     Historique :
        - 16/06/2020 : Création
        - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_autorisationSubstitution_fr">
        <title>CI-SIS Entrée "FR-Autorisation-substitution"</title>
        
        <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']">
            
            <!-- Test des templateId pour l'entrée "FR-Autorisation-substitution" -->
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.3.87']">
                [1] [E_autorisationSubstitution_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Autorisation-substitution" doit avoir un 'templateId' avec l'attribut @root="1.2.250.1.213.1.1.3.87"
            </assert>
            
            <!-- Test de la conformité du <code> -->
            <assert test="(count(cda:code[@code='N'][@codeSystem='2.16.840.1.113883.5.1070'])=1) or 
                          (count(cda:code[@code='G'][@codeSystem='2.16.840.1.113883.5.1070'])=1)">
                [2] [E_autorisationSubstitution_fr.sch] Erreur de conformité CI-SIS : 
                Dans l'entrée "FR-Autorisation-substitution", la valeur de l'attribut du code[@code] doit être obligatoirement 'N' ou 'G' et doit être issu du jeu de valeur JDV_HL7_ActSubstanceAdminSubstitutionCode-CISIS (2.16.840.1.113883.5.1070)
            </assert>
        </rule>
            
    </pattern>
