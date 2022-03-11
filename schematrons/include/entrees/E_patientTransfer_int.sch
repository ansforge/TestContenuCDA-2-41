<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_patientTransfer_int.sch ]O@%#o>>=-
    
    Teste la conformité de l'élément "Patient Transfer" (1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    24/10/2013 : CRI : Création
    27/06/2017 : LBE : Ajout de contraintes(compte de template, attributs, participant, etc...), et de conventions de nommage
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->



<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_patientTransfer_int">
    <title>IHE PCC v3.0 Patient Transfer - errors validation phase</title>
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&quot;]">
        
        <assert test="@classCode='ACT' and (@moodCode='INT' or @moodCode='EVN')">
            [E_patientTransfer_int] Erreur de conformité PCC : L'élément patientTransfer est un act, l'élément act doit contenir un attribut @classCode fixé à la valeur act et un attribut @moodCode prenant la valeur 'INT' ou 'EVN'
        </assert>   
        
        <assert test="not(cda:text) or (cda:text and cda:text/cda:reference/@value)">
            [E_patientTransfer_int] Erreur de conformité PCC : Si dans l'élément patientTransfer un élément text est présent, celui-ci doit contenir un élément 'reference' avec un attribut @value
        </assert>
        <!-- On ne vérfie pas les codes avec la SNOMED CT (pour l'instant) -->
        
        <!--  <assert test="cda:code[@code = '107724000'] and "> 
            [E_patientTransfer_int] Erreur de conformité PCC : Le code utilisé pour un transfert est 'OBS_005' (TA_OBS)
        </assert> -->
        
        <assert test="cda:statusCode[@code = &quot;completed&quot; or @code=&quot;normal&quot;]"> 
            [E_patientTransfer_int] Erreur de conformité PCC : Le statut du transfert est obligatoire. l'attribut @code prend la valeur
            @code='completed' si le transfert à eu lieu (moodCode='EVN') ou @code='normal' lorsque le
            tranfert est projeté (moodCode='INT')
        </assert>
        
        <assert test="not(cda:statusCode[@code = 'completed']) or 
            (cda:statusCode[@code = 'completed'] and (cda:effectiveTime/cda:low and cda:effectiveTime/cda:high))"> 
            [E_patientTransfer_int] Erreur de conformité PCC : effectiveTime est obligatoire lorsque le transfert a eu lieu. 
            Le sous-élément 'low' indique l'heure de départ et le sous-élément 'high' indique celle d'arrivée.
        </assert>
        
        <assert
            test="not(self::cda:act[@negationInd='false']) or (self::cda:act[@negationInd='false' and @moodCode='EVN'] and cda:statusCode[@code = 'completed'])">
            [E_patientTransfer_int] Erreur de conformité PCC : l'attribut @code prend la valeur @code='completed' si le transfert à eu lieu (moodCode='EVN'). </assert>
        
    </rule>
    
    <!-- Règle relative au participant -->
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&quot;]/cda:participant">
        <assert test="@typeCode='DST'">
            [E_patientTransfer_int] Erreur de conformité PCC : L'élément participant contenu dans patientTransfert doit contenir l'attribut @typeCode fixé à la valeur 'DST'
        </assert>
        <assert test="cda:templateId">
            [E_patientTransfer_int] Erreur de conformité PCC : L'élément participant contenu dans patientTransfert doit contenir un templateId
        </assert>
        <assert test="cda:participantRole/@classCode='SDLOC'">
            [E_patientTransfer_int] Erreur de conformité PCC : L'élément participant contenu dans patientTransfert doit contenir un élément 'participantRole' contenant un attribut @classCode dont la valeur est fixé à 'SDLOC'
        </assert>
        <assert test="not(cda:participantRole/cda:playingEntity) or ( cda:participantRole/cda:playingEntity and cda:participantRole/cda:playingEntity/@classCode='ENT')">
            [E_patientTransfer_int] Erreur de conformité PCC : Si l'élément participantRole contient un élément playingEntity, celui-ci doit contenir un attribut @classCode fixé à la valeur 'ENT'
        </assert>
        <assert test="not(cda:participantRole/cda:playingEntity) or ( cda:participantRole/cda:playingEntity and cda:participantRole/cda:playingEntity/cda:name)">
            [E_patientTransfer_int] Erreur de conformité PCC : Si l'élément participantRole contient un élément playingEntity, celui-ci doit contenir un élément 'name'
        </assert>
        
    </rule>
    
</pattern>
