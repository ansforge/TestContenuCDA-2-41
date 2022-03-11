<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_codedEventOutcome.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Event Outcome" (1.3.6.1.4.1.19376.1.7.3.1.1.13.7)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    codedEventOutcomeSection20131024.sch : CRI : Création
    06/05/15 : JDS : Correction d'un commmentaire ( fonctionnalités inchangées) 
    03/07/2017 : LBE :  Ajout des comptes de templateId + conventions de nommage + vérification du templateId parent
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedEventOutcome">
    
    <title>IHE PCC v3.0 Coded Event Outcome Section</title>
        
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.7"]'> 
        
        <let name="count_templateId" value="count(cda:templateId)"/>
            
            <assert test="$count_templateId &gt;1">
                [S_codedEventOutcome.sch] Erreur de conformité PCC : coded Event Outcome doit contenir au minimum deux tempalteIds
            </assert>
            
            <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9'">
                [S_codedEventOutcome.sch] Erreur de conformité PCC : coded Event Outcome doit contenir le templateId parent 1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9             
            </assert>
            
            <!-- Verifier que le templateId est utilisé correctement --> 
            <assert test='../cda:section'> 
                [S_codedEventOutcome.sch] Erreur de conformité PCC : 'Event Outcome' ne peut être utilisé que comme section
            </assert> 
        
            <!-- Vérifier le code de la section --> 
            <assert test='cda:code[@code = "42545-4"]'> 
                [S_codedEventOutcome.sch] Erreur de conformité PCC : Le code de la section 'Event Outcome' doit être '42545-4'              
            </assert> 
        
            <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
                [S_codedEventOutcome.sch] Erreur de conformité PCC :  L'élément 'codeSystem' de la section 
                'Event Outcome' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
            </assert> 
            
            <!-- Vérifier que la section contient des éléments Simple Observations -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'> 
                [S_codedEventOutcome.sch] Erreur de conformité PCC :  Une section "Event Outcome"
                doit contenir des entrée de type "Simple observations"
            </assert> 
        </rule> 
        
    </pattern>