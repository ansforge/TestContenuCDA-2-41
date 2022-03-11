<?xml version="1.0" encoding="UTF-8"?>

<!--                   
     -=<<o#%@O[ specimenProcedureStep.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "E_specimenProcedureStep_int" (1.3.6.1.4.1.19376.1.3.10.4.1)
    aux spécifications d'IHE PaLM Suppl.APSR 2.0 (Rev 2.1 – 2018-09-28)
    
    Historique :
    04/01/2019 : NNA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_specimenProcedureStep_int">

    <title>Palm_Suppl_APSR V2.0 Specimen Procedure Step Entry</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.3.10.4.1"]'>
        
        <let name="count_text" value="count(cda:text)"/>
        <let name="count_statusCode" value="count(cda:statusCode)"/>
        <let name="count_effectiveTime" value="count(cda:effectiveTime)"/>
        <let name="count_approachSiteCode" value="count(cda:approachSiteCode)"/>
        <let name="count_targetSiteCode" value="count(cda:targetSiteCode)"/>
        <let name="count_specimen" value="count(cda:specimen)"/>
        <let name="count_performer" value="count(cda:performer)"/>
        <let name="count_participant" value="count(cda:participant)"/>
        <let name="count_entryRelationShip_act" value="count(cda:entryRelationship/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.3.1.3'])"/>
                
        <assert test="self::cda:procedure[@classCode='PROC'] and self::cda:procedure[@moodCode='EVN']">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "procedure" de l'entrée "Specimen Procedure Step" doit avoir les attributs @classCode et @moodCode fixés respectivement aux valeurs suivante 'PROC' et 'EVN'
        </assert>
        
        <assert test='count(cda:code)=1'>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'entrée "Specimen Procedure Step" doit contenir un élément "code" permettant de la coder(cardinalité [1..1]).
        </assert>
       
        <assert test="$count_text &lt;=1">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "text" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
        
        <assert test="$count_statusCode &lt;=1">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "statusCode" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
        
        <assert test="$count_effectiveTime &lt;=1" >
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "effectiveTime" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
        
        <!--assert test='cda:effetiveTime[@xsi:type="IVL_TS"]'>
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "effectiveTime" doit être de type xsi:type="IVL_TS".
        </assert-->
        
        <assert test="$count_approachSiteCode &lt;=1">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "approachSiteCode" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
                    
        <assert test="$count_targetSiteCode &lt;=1">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "targetSiteCode" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
        
        <assert test="$count_specimen &lt;=1">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "specimen" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
        
        <assert test="$count_performer &lt;=1">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "performer" ne peut être présent qu'une seule fois (cardinalité [0..1])
        </assert>
        
        <assert test="$count_participant &gt;=1">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'élément "participant" doit être présent au minimum une fois (cardinalité [1..*])
        </assert>
        
        <assert test="$count_entryRelationShip_act &lt;=1">
            [E_specimenProcedureStep_int.sch] Erreur de conformité APSR : L'entryRelationship act de templateId '1.3.6.1.4.1.19376.1.3.1.3' (pour décrire le spécimen reçu) ne peut être présente qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
    </rule>
    
</pattern>
