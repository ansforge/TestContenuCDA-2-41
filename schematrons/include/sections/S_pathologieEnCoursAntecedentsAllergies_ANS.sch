<?xml version="1.0" encoding="UTF-8"?>

<!-- S_pathologieAntecedentsAllergies_ANS.sch
    
     Vérification de la conformité de la section FR-Pathologies-antecedents-allergies (1.2.250.1.213.1.1.2.30) créée par l'ANS
    
    Historique :
    17/08/2017 : LBE : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    03/09/2020 : Mise à jour des messages d'erreur    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_pathologieAntecedentsAllergies_ANS">
    
    <title>Vérification de la conformité de la section FR-Pathologies-antecedents-allergies (1.2.250.1.213.1.1.2.30) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.30"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_pathologieAntecedentsAllergies_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_pathologieAntecedentsAllergies_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "34117-2"]'>
            [S_pathologieAntecedentsAllergies_ANS.sch] Erreur de conformité CI-SIS : Le code de la section Pathologie, antécédents, allergies doit être '34117-2'
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_pathologieAntecedentsAllergies_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des sous-sections optionnelles -->
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.8'
            or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.12' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.13'">
            [S_pathologieAntecedentsAllergies_ANS.sch] Erreur de conformité CI-SIS : Les sous-sections optionnelles possibles sont :  
            Problèmes actifs (Active problems - 1.3.6.1.4.1.19376.1.5.3.1.3.6)
            Antécédents médicaux (History of past illness - 1.3.6.1.4.1.19376.1.5.3.1.3.8)
            Antécédents chirurgicaux (Coded List of Surgeries - 1.3.6.1.4.1.19376.1.5.3.1.3.12)
            Allergies et intolérances (Allergies and intolerances - 1.3.6.1.4.1.19376.1.5.3.1.3.13)            
        </assert>
        
        <assert test="(not(cda:component/cda:section) and cda:text) or (count(cda:component/cda:section)=4 and not(cda:text)) or (count(cda:component/cda:section)&lt;4 and cda:component/cda:section)">
            [S_pathologieAntecedentsAllergies_ANS.sch] Erreur de conformité CI-SIS : 
            Si aucune des 4 sous-sections optionnelles n’est présente : l’élément text est requis. Dans ce cas le contenu de la section est intégralement non structuré.
            Si les 4 sous-sections optionnelles sont présentes : l’élément text est interdit. En effet, chacune est porteuse de son propre texte en plus de ses données structurées. Ce cas correspond à la structuration maximale de cette section.
            Dans les autres cas, l’élément text peut être présent et il porte le texte correspondant à une ou plusieurs sous-sections optionnelles absentes.
        </assert>

    </rule>

</pattern>
