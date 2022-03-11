<?xml version="1.0" encoding="UTF-8"?>

<!-- E_allergiesAndIntolerances_fr.sch 
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entrée 
    allergies and Intolerances (1.3.6.1.4.1.19376.1.5.3.1.4.6)  
    
    Historique :
    16/11/2016 : NMA : Création
    26/06/2017 : NMA : Ajout la contrainte sur le nombre de templateId
    26/10/2017 : NMA : Suppression du test sur la terminologie pour coder le participant
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_allergiesAndIntolerances_fr">

    <title>CI-SIS Allergies and Intolerances</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.6"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
       
        <assert test='count(cda:id)=1'>
            [E_AllergiesAndIntolerances_fr] : Erreur de conformité CI-SIS : Un élément "Allergies and Intolerance" comporte obligatoirement un identifiant "id".
        </assert>
        <assert test="cda:templateId/@root='2.16.840.1.113883.10.20.1.18'">
            [E_AllergiesAndIntolerances_fr] : Erreur de conformité CI-SIS : L'élément de templatId de conformité CCD '2.16.840.1.113883.10.20.1.18' doit être présent
        </assert>
        <assert test='cda:code[@codeSystem="2.16.840.1.113883.5.4"]'>
            [E_AllergiesAndIntolerances_fr] Erreur de Conformité CI-SIS:
            L'élément 'codeSystem' doit obligatoirement être issu de l'ObservationIntoleranceType (2.16.840.1.113883.5.4).</assert>
        
        <report test="cda:effectiveTime/cda:width or cda:effectiveTime/cda:center"> 
            [E_allergiesAndIntolerances_fr] Erreur de conformité CI-SIS: Bien que CDA permette de nombreuses modalités pour exprimer un intervalle de 
            temps (low/high, low/width, high/width, ou center/width), allergiesAndIntolerances sera contraint à l'utilisation
            exclusive de la forme low/high.</report>
        
        <assert test="cda:effectiveTime/cda:low[@value or @nullFlavor]"> 
            [E_allergiesAndIntolerances_fr] Erreur de conformité CI-SIS : La composante "low" de l'élément "effectiveTime" doit être exprimée dans 
            un élément "Allergies And Intolerances".
        </assert>
        
        <assert test='cda:statusCode[@code = "completed"]'>
            [E_allergiesAndIntolerances_fr] Erreur de conformité CI-SIS: L'élément "statusCode" sera présent et prendra la valeur "completed"</assert>
        
        <assert test='cda:value/cda:originalText'>
            [E_allergiesAndIntolerances_fr] Erreur de conformité CI-SIS: L'élément "value" doit contenir un élément originalText</assert>
        
        <assert test='not(cda:participant) or (cda:participant/cda:participantRole/cda:playingEntity/cda:code/cda:originalText/cda:reference)'>
            [E_allergiesAndIntolerances_fr] Erreur de Conformité CI-SIS: Si l'élément participant est présent, le code de la playingEntity dans
            le paticipantRole devra être présent avec un originalText et une référence qui renvoit vers la partie narrative
        </assert>
        
        <assert test="count(cda:entryRelationship/*/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1'])&lt;2">
            [E_allergiesAndIntolerances_fr] Erreur de Conformité CI-SIS: une seule entryRelationship avec un templateId (1.3.6.1.4.1.19376.1.5.3.1.4.1) au maximum est autorisée, elle décrit la sévérité de l'allergie/intolérance
        </assert>
        
        <assert test="count(cda:entryRelationship/*/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.1'])&lt;2">
            [E_allergiesAndIntolerances_fr] Erreur de Conformité CI-SIS: une seule entryRelationship avec un templateId (1.3.6.1.4.1.19376.1.5.3.1.4.1.1) au maximum est autorisée, elle décrit le statut du problème
        </assert>
        
    </rule>
</pattern>
