<?xml version="1.0" encoding="UTF-8"?>

<!--  Schématron E_concernEntry_int.sch -
    
    vérifie la conformité des entrées "Etat clinique" (Concern Entry - 1.3.6.1.4.1.19376.1.5.3.1.4.5.1)
    
    25/07/11 : CRI : Création
    11/03/15 : JDS : Correction message affiché (erreur de frappe)
    26/06/17 : NMA : Ajout du test sur le nombre de templateIds
    04/11/19 : APE : Correction des messages d'erreurs
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_concernEntry_int">
    <title>IHE PCC v3.0 Concern Entry</title>
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5.1"]'>
            
            <let name="count_templateId" value="count(cda:templateId)"/>
            
            <assert test='../cda:act'>
                [E_concernEntry_int]  L'entrée "Etat clinique" (Concern Entry) ne peut être utilisée que comme un élément de type "act".</assert>
            
            <assert test='../cda:act[@classCode="ACT"] and ../cda:act[@moodCode="EVN"]'>
                [E_concernEntry_int] Une entrée "Etat clinique" (Concern Entry) est un acte ("act classCode='ACT'") qui consiste 
                à enregistrer un événement (moodCode='EVN') relatif à un problème, une allergie ou tout autre élément se rapportant
                à l'état clinique d'un patient.</assert>
            
            <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.27"]'>
                [E_concernEntry_int] Le templateId "2.16.840.1.113883.10.20.1.27" indique que l'entrée "Etat clinique" (Concern Entry) se conforme 
                au modèle HL7 CCD "problem acts".</assert>
            
            <assert test="$count_templateId&gt;=2">
                [E_concernEntry_int] Erreur de conformité PCC : Dans une entrée "Etat clinique" (Concern Entry), il doit y avoir au moins deux templateId.
            </assert>
            
            <assert test='cda:id'>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), il doit y avoir un élément "id".</assert>
            
            <assert test='cda:code[@nullFlavor="NA"]'>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), l'élément "code" prend la valeur nullFlavor='NA'.</assert>
            
            <assert test='cda:statusCode[@code="active" or 
                @code="suspended" or
                @code="aborted" or
                @code="completed"]'>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), l'élément "statusCode" doit prendre l'une des valeurs suivantes : 
                "active", "suspended", "aborted" ou "completed".</assert>
            
            <assert test='(cda:effectiveTime[@nullFlavor])or(cda:effectiveTime/cda:low)'>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), l'élément "effectiveTime" indique le début et la fin de l'élément décrit. 
                Une valeur nullFlavor est acceptée. Autrement, son composant "low" est obligatoire.</assert>
            
            <assert test='(cda:effectiveTime[@nullFlavor]) or ((cda:statusCode[@code="completed" or @code="aborted"] and cda:effectiveTime/cda:high) or
                (cda:statusCode[@code="active" or @code="suspended"] and not(cda:effectiveTime/cda:high)))'>
                [E_concernEntry_int] Dans une entrée "Etat clinique" (Concern Entry), l'élément "effectiveTime" indique le début et la fin de l'élément décrit.
                Une valeur nullFlavor est acceptée. Autrement, son composant "high" est obligatoire si le statutCode est "completed" ou "aborted" et absent si le statutCode est "active" ou "suspended".
            </assert>
            
            <assert test='(cda:entryRelationship[@typeCode="SUBJ"] and cda:entryRelationship/*/cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.5" or @root="1.3.6.1.4.1.19376.1.5.3.1.4.6"]) or  
                (cda:sourceOf[@typeCode="SUBJ" and @inversionInd="false"] and cda:sourceOf/*/cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.5" or @root="1.3.6.1.4.1.19376.1.5.3.1.4.6"]) '>
                [E_concernEntry_int] Une entrée "Etat clinique" (Concern Entry), permet de décrire une liste de problèmes ou une liste d'allergies.  et de regrouper. 
                Cette entrée regroupe, à l'aide d'entryRelationship ayant des attributs typeCode='SUBJ' et inversionInd='false', 
                une ou plusieurs entrées "Problème" ("1.3.6.1.4.1.19376.1.5.3.1.4.5") ou "Allergie ou intolerance" ("1.3.6.1.4.1.19376.1.5.3.1.4.6").
            </assert>
        </rule>
    </pattern>