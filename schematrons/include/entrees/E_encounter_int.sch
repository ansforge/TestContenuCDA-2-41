<?xml version="1.0" encoding="UTF-8"?>

<!--  E_encounter_int.sch -
    
    Schématron de l'entrée PCC Encounter (1.3.6.1.4.1.19376.1.5.3.1.4.14)
    
    25/07/11 : CRI : Création
	12/12/16 : LBE : Suppression de la condition incohérente suivante : ' test="@moodCode='ARQ' and (cda:effectiveTime or cda:priorityCode"'
    17/01/17 : LBE : Ajout de la conformité du participant
    01/03/17 : NMA : Correction du test sur le participant
    20/07/17 : LBE : Mise en conformité avec les nouvelles spécifications (ajout compte templateId,..)
    05/10/17 : NMA : Correction du compte des templateIds
    30/11/17 : NMA : Correction des tests sur le moodCode en remplaçant les or par des and
    10/10/19 : APE : Mise à jour du contrôle du reference@value obligatoire
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_encounter_int">

    <title>IHE PCC v3.0 Encounter - errors validation phase</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.14']">
        
        <let name="count_templateId" value="count(cda:templateId)"/>

        <assert test="@classCode='ENC'"> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", l'attribut "classCode" sera fixé à la valeur "ENC". 
        </assert>

        <assert test="(not(@moodCode='EVN') and cda:templateId[@root='2.16.840.1.113883.10.20.1.25']) or (@moodCode='EVN' and cda:templateId[@root='2.16.840.1.113883.10.20.1.21'])"> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", le templateId indique que cet élément 
            se conforme aux contraintes de ce module de contenu.
            NOTE: Lorsque l'entrée "Encounter" est en mode événement (moodCode='EVN'), elle se conforme au template CCD 2.16.840.1.113883.10.20.1.21.
            Dans les autres modes, elle se conforme au template CCD 2.16.840.1.113883.10.20.1.25. 
        </assert>
        
        <assert test="$count_templateId&gt;1">
            [E_encounter_int] : Erreur de conformité PCC : Dans une entrée "Encounter", il doit y avoir au minimum deux templateId.
        </assert>
        
        <assert test="cda:id"> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", l'élément "id" est obligatoire. </assert>
        
          <!-- 
        <assert test="cda:code[@codeSystem='2.16.840.1.113883.5.4']"> 
        Error: In
            Encounter, code is a required element and shall contain a code from the HL7
            ActEncounterCode vocabulary describing the type of encounter (e.g., inpatient,
            ambulatory, emergency, et cetera). </assert>
          -->
        
        <assert test="cda:text/cda:reference[@value]">
            [E_encounter_int] Erreur de conformité PCC : L'élément 'text' doit être présent avec un élément 'reference' qui contient une URI dans un attribut @value.
        </assert>
        
        <assert test="not(@moodCode = 'EVN' or @moodCode = 'APT') or cda:effectiveTime"> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", l'élément "effectiveTime" 
            horodate l'événement (en mode EVN), ou la date désirée pour la rencontre (en mode ARQ or APT).
            En mode EVN ou APT, l'élément "effectiveTime" sera présent. En mode ARQ, l'élément "effectiveTime" 
            pourra être présent, mais si la date n'est pas présente, l'élément "priorityCode" coit être présent  
            pour indiquer qu'un rappel est nécessaire pour fixer la date de rendez-vous pour la rencontre. 
        </assert>
        
        <assert test="not(cda:participant[@typeCode='LOC']) or 
                cda:participant[@typeCode='LOC']/cda:participantRole[@classCode='SDLOC']"> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", un élément "participant" avec un attribut @typeCode='LOC' pourra être présent pour indiquer le lieu de la rencontre. 
            Cet élément aura un élément "participantRole" avec un attribut classCode='SDLOC' décrivant la localisation du service. </assert>
        
        <assert test="not(cda:particpant[@typeCode='LOC']) or
                cda:participant[@typeCode='LOC']/cda:playingEntity[@classCode='PLC']/cda:name"> 
            [E_encounter_int] : Erreur de Conformité PCC: Dans une entrée "Encounter", un élément "participant" avec un attribut @typeCode='LOC' 
            désignera un élément "playingEntity" avec son nom. </assert>
        

    </rule>
</pattern>
