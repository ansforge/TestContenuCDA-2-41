<?xml version="1.0" encoding="UTF-8"?>

<!--  E_procedureEntry_int.sch -
      Schématron de l'entrée PCC Procedure Entry (1.3.6.1.4.1.19376.1.5.3.1.4.19)
    
    25/07/11 : CRI : Création
	12/12/16 : LBE : Suprresion de la condition imposant un attribut code à la balise <code></code> alors que la spécification ne le mentionne pas
	22/06/17 : NMA : Mise à jour du schematron avec plus de contraintes 
	10/10/19 : APE : Correction des libellés des erreurs
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_procedureEntry_int">

        <title>IHE PCC v3.0 Procedure Entry</title>
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.19"]'>
            <let name="count_templateId" value="count(cda:templateId)"/>
            <assert test='self::cda:procedure[@classCode="PROC"]'>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", l'attribut "classCode" est fixé à la valeur "PROC".</assert>
            
            <assert test='(self::cda:procedure[@moodCode="EVN"] and
                cda:templateId[@root="2.16.840.1.113883.10.20.1.29"]) or (self::cda:procedure[@moodCode="INT"] and
                cda:templateId[@root="2.16.840.1.113883.10.20.1.25"]) '>
                [E_procedureEntry_int]: Lorsque l'entrée "Procedure" est en mode événement (moodCode='EVN'), elle se conforme au template CCD 2.16.840.1.113883.10.20.1.29.
                Lorsque l'entrée "Procedure" est en mode intent (moodCode='INT'), elle se conforme au template CCD 2.16.840.1.113883.10.20.1.25.
            </assert>
            
            <assert test="$count_templateId&gt;1">
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", il doit y avoir au minimum deux templateIds.
            </assert>
            
            <assert test='cda:id'>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", il doit y avoir au moins un identifiant "id".</assert>
            
            <assert test='cda:code'>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", il doit y avoir un élément "code".
            </assert>

            
            <assert test="cda:text/cda:reference[@value]">
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure", l'élément 'text' doit être présent avec un élément 'reference' qui contient une URI dans l'attribut @value.
            </assert>
            
            <assert test='cda:statusCode[@code = "completed" or
                @code = "active" or
                @code = "aborted" or
                @code = "cancelled"]'>
                [E_procedureEntry_int]: Dans l'entrée "Procedure", l'élément "statusCode" est obligatoire.
                Il prendra la valeur "completed" pour les procédures réalisées, "active" pour les procédures 
                toujours en cours, "aborted" pour les procédures ayant été stoppées avant la fin 
                et "cancelled" pour les procédures qui ont été annulées (avant d'avoir débuté).</assert>
          

            <assert test='not(./@moodCode="INT") or 
                (cda:effectiveTime or cda:priorityCode)'>
                [E_procedureEntry_int] Erreur de conformité PCC : Dans l'entrée "Procedure" en mode "INT", si l'élément "effectiveTime" est omis alors l'élément "priorityCode" est obligatoire. 
                L'élément "priorityCode" peut être précisé dans d'autres modes pour indiquer le degré de priorité de la procédure.
            </assert>
    
        </rule>
</pattern>
        
