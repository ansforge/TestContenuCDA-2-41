<?xml version="1.0" encoding="UTF-8"?>
<!--                  -=<<o#%@O[ E_familyHistoryObservation_int.sch ]O@%#o>>=-
    
    Teste la conformité de l'élément "PCC Family History Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.13.3)
    aux spécifications d'IHE PCC v5.0
    
    Historique :
    23/07/12 : CRI : Création
    23/06/17 : NMA : Conformité avec le volet international
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->


<!-- errors -->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_familyHistoryObservation_int">
    <title>IHE PCC Family History Observation</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.3"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"] and 
            cda:templateId[@root="2.16.840.1.113883.10.20.1.22"]'>
            [E_familyHistoryObservation_int] : L'élément "Family History Observations" spécialise "Simple Observation" 
            et hérite ses contraintes de CCD. Il incluera deux template IDs additionnels : 
            1.3.6.1.4.1.19376.1.5.3.1.4.13 et 2.16.840.1.113883.10.20.1.22.
        </assert>
        <assert test="$count_templateId&gt;2">
            [E_familyHistoryObservation_int] Erreur de conformité PCC : Dans l'élément "Procedure Entry", il doit y avoir au minimum trois templateId
        </assert>
        
        <assert test='cda:code'>
            [E_familyHistoryObservation_int] : L'élément code doit être présent.
        </assert>
        
<!--        <assert test='cda:value[@xsi:type="CD"]'>
            [E_familyHistoryObservation_int] : L'élément value doit être de type xsi:type="CD".
        </assert>-->
    </rule>
    
    
</pattern>