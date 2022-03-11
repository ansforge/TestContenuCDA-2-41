<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_AllergiesAndIntoleranceConcern_fr.sch ]O@%#o>>=-
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entrée 
   allergies and Intolerance Concern (1.3.6.1.4.1.19376.1.5.3.1.4.5.3)  
    
    
    Historique :
    27/06/17 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_allergiesAndIntoleranceConcern_fr">
    <title>CI-SIS Allergies and Intolerance Concern</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.3']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert
            test="self::cda:act[@classCode='ACT' and @moodCode='EVN']">
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: Les attributs classCode et moodCode prennent respectivement les valeurs 'ACT' et 'EVN'</assert>
       
        <assert test="count(cda:id)=1">
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: Un élément "Allergies and Intolerance Concern" comporte un seul identifiant "id"
        </assert> 
        
        <assert test="cda:code[@nullFlavor='NA']">
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: L’élément code prend la valeur nullFlavor='NA' car l'identification du problème est faite à partir des éléments entryRelationship.
        </assert>
        
        <assert test="count(cda:code)=1">
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: Un élément "Allergies and Intolerance Concern" comporte un seul code
        </assert>
        
        <assert test='cda:statusCode[@code = "completed" or
            @code = "active" or
            @code = "aborted" or
            @code = "suspended"]'>
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: L'élément "statusCode" sera présent.
            Il prendra la valeur "completed" pour les problèmes résolus, ou "active" pour les problèmes 
            toujours en cours dinvestigation, "aborted" pour les problèmes ayant été stoppées avant la fin 
            et "suspended" pour ceux qui ont été mis en suspens.</assert>
        
        <report test="cda:effectiveTime/cda:width or cda:effectiveTime/cda:center"> 
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS: Bien que CDA permette de nombreuses modalités pour exprimer un intervalle de 
            temps (low/high, low/width, high/width, ou center/width), allergiesAndIntoleranceConcern sera contraint à l'utilisation
            exclusive de la forme low/high.</report>
        
        <assert test="cda:effectiveTime/cda:low[@value or @nullFlavor]"> 
            [E_allergiesAndIntoleranceConcern_fr] Erreur de conformité CI-SIS : La composante "low" de l'élément "effectiveTime" doit être exprimée dans 
            un élément "Allergies And Intolerance Concern".
           </assert>
        
    </rule>
    
</pattern>
