<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_codedListOfSurgeries.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "Coded List of Surgeries" (1.3.6.1.4.1.19376.1.5.3.1.3.12)
    aux spécifications d'IHE PCC v3.0
    - Vérifie que les entrées sont de type Procedure
    
    Historique :
    24/06/11 : CRI : Création
    19/03/15 : JDS : Suppression de la contrainte fixée sur l'élément title
    03/07/2017 : LBE : Ajout convention de nommage + compte des templateId
    13/01/2020 : NMA : Ajout du template de conformité CCD
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    15/04/2020 : APE : Vérifier la présence de l'identifiant de la section
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedListOfSurgeries">
    <title>IHE PCC v3.0Coded List of Surgeries Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.12"]'> 
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;2">
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Coded List of Surgeries doit contenir au moins 3 templateIds
        </assert>
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Coded List of Surgeries ne peut être utilisé que dans une section. 
        </assert>
        
        <!-- Vérifier la présence des templateId parents. -->
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.11']"> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Le templateId parent de la section 'Coded List of Surgeries' (1.3.6.1.4.1.19376.1.5.3.1.3.11) doit être présent
        </assert>
        
        <!-- Vérifier la présence des templateId parents. -->
        <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.12']"> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Le templateId parent de la section 'Coded List of Surgeries' (2.16.840.1.113883.10.20.1.12) doit être présent
        </assert>
        
        <!-- Vérifier la présence de l'identifiant de la section -->
        <assert test='cda:id'>
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : La section doit avoir un identifiant unique.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "47519-4"]'> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC :  Le code de la section Coded List of Surgeries doit être 47519-4 
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC :  L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19"]'> 
            <!-- Vérifie que les entrées sont de type Problem Concern Entry -->
            [S_codedListOfSurgeries.sch] Erreur de conformité PCC : Coded List of Surgeries doit contenir des éléments Procedure Entry.
        </assert>
        
    </rule> 
</pattern>

