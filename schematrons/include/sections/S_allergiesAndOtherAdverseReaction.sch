<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ allergiesAndOtherAdverseReaction.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "allergies And Other Adverse Reaction" (1.3.6.1.4.1.19376.1.5.3.1.3.13)
    aux spécifications d'IHE PCC v3.0
    - Vérifie que les entrées sont de type Procedure
    
    Historique :
    24/06/11 : CRI : Création
    19/03/15 : JDS : Correction d'une erreur sur le message d'erreur 
                    (code de la section Allergies and Intolerance erroné)
    29/06/2017 : LBE : Ajout du compte TemplateId et conventions de nommage
    29/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_allergiesAndOtherAdverseReactions">
    <title>IHE PCC v3.0 Allergy and Other Adverse Reactions Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.13"]'> 
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;1">
            [S_allergiesAndOtherAdverseReaction.sch] Erreur de conformité PCC : Allergies and Other Adverse Reactions doit contenir au minimum deux templateIds (cardinalité [2..*])
        </assert>
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_allergiesAndOtherAdverseReaction.sch] : Allergies and Other Adverse Reactions ne peut être utilisé que dans une section. 
        </assert> 
        <!-- Vérifier la présence des templateId parents. -->
        <assert test="cda:templateId[@root=&quot;2.16.840.1.113883.10.20.1.2&quot;]"> 
            [S_allergiesAndOtherAdverseReaction.sch] : Le templateId parent CCD 3.8 de la section 'Allergies and Other Adverse Reactions' (2.16.840.1.113883.10.20.1.2) doit être présent</assert>
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "48765-2"]'> 
            [S_allergiesAndOtherAdverseReaction.sch] : Le code de la section Allergies and Other Adverse Reactions doit être 48765-2
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_allergiesAndOtherAdverseReaction.sch] : L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.5.3"]'> 
            <!-- Vérifie que les entrées sont de type Problem Concern Entry -->
            [S_allergiesAndOtherAdverseReaction.sch] : Allergies and Other Adverse Reactions doit contenir des éléments Allergy Concern Entry.
        </assert> 
    </rule> 
</pattern>

