<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_familyHistoryOrganizer_int.sch ]O@%#o>>=-
    
    Teste la conformité de l'élément "PCC Family History Organizer" (1.3.6.1.4.1.19376.1.5.3.1.4.15)
    aux spécifications d'IHE PCC v5.0
    
    Historique :
    23/07/12 : CRI : Création
    16/02/17 : NMA : le test sur l'élément cda:administrativeGenderCode a été supprimé
    07/11/17 : NMA : Autorisation du nullFlavor sur le lien de parenté et supression du test sur l'administrativeGenderCode
    30/11/17 : NMA : Ajout de la contrainte du typeCode sur le component
    
-->

<!--  IHE PCC Family History Organizer: 1.3.6.1.4.1.19376.1.5.3.1.4.15 -->

<!-- errors -->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_familyHistoryOrganizer_int">
    
    <title>IHE PCC Family History Organizer - errors validation phase</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.15"]'>
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test='self::cda:organizer[@moodCode="EVN" and @classCode="CLUSTER"]'>
            [E_familyHistoryOrganizer_int]: Les attributs moodCode et classCode de l'élément organizer doivent être respectivement 'EVN' et 'CLUSTER' </assert>
        
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.23"]'>
            [E_familyHistoryOrganizer_int] Erreur PCC : l'élément template du parent CCD 
            doit être présent (2.16.840.1.113883.10.20.1.23).
        </assert>
        
        <assert test="$count_templateId&gt;1">
            [E_familyHistoryOrganizer_int] Erreur de conformité PCC : Dans l'élément "Procedure Entry", il doit y avoir au minimum deux templateIds
        </assert>
        
        <assert test ='cda:subject[@typeCode="SBJ"]'>
            [E_familyHistoryOrganizer_int] Erreur PCC: L'élément "subject" élément doit être présent avec un attribut typeCode="SUBJ"
        </assert>
        
        <assert test='cda:subject/cda:relatedSubject[@classCode="PRS"]'>
            [E_familyHistoryOrganizer_int] Erreur PCC: L'élément "subject" contiendra un élément "relatedSubject"
            qui identifie les relations personnelles du patient (classCode='PRS').
        </assert>   
        <assert test='cda:subject/cda:relatedSubject[@classCode="PRS"]/cda:code[@code and @codeSystem="2.16.840.1.113883.5.111"] or cda:subject/cda:relatedSubject[@classCode="PRS"]/cda:code[@nullFlavor]'>
            [E_familyHistoryOrganizer_int] Erreur PCC : L'élément "code" de relatedSubject sera présent et donne 
            le lien entre l'élément "subject" au  patient. L'attribut @code sera présent et contiendra une valeur du vocabulaire HL7 FamilyMember.
            L'attribut "codeSystem" prendra la valeur 2.16.840.1.113883.5.111.
            Le nullFlavor est autorisé
        </assert>
        
        <assert test='not(cda:participant) or cda:participant/cda:participantRole[@classCode="PRS"]'>
            [E_familyHistoryOrganizer_int] Erreur PCC : Un élément participant doit contenir un élément participantRole identifiant
            la relation de l'élément "subject" aux autres membres de la famille (classCode='PRS').
        </assert>
        <assert test='not(cda:participant) or 
            cda:participant/cda:participantRole[@classCode="PRS"]/cda:code[@code and @codeSystem="2.16.840.1.113883.5.111"]'>
            [E_familyHistoryOrganizer_int] Erreur PCC :  L'élément "code" sera présent et identifie le lien entre le participant et l'élément "subject".
            L'attribut @code sera présent et contiendra une valeur du vocabulaire HL7 FamilyMember. l'attribut @codeSystem sera présent
            et prendra la valeur "2.16.840.1.113883.5.111". 
        </assert>
        <assert test='not(cda:participant) or
            cda:participant/cda:participantRole[@classCode="PRS"]/cda:playingEntity[@classCode="PSN"]'>
            [E_familyHistoryOrganizer_int] Erreur PCC : L'élément "playingEntity" est présent et identifie la relation.
            Il prendra la valeur &lt;playingEntity classCode='PSN'&gt;.
        </assert>
        <assert test='.//cda:component[@typeCode="COMP"]/cda:observation/cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.3"]'>
            [E_familyHistoryOrganizer_int] Erreur PCC : L'organizer Family History contient un ou plusieurs éléments component avec un typeCode fixé à "COMP". 
            Ces éléments se conforment au template "Family History Observation".
        </assert>     

        
    </rule>
</pattern>

