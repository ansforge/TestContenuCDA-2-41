<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_patientTransfer_int.sch ]O@%#o>>=-
    
    Teste la conformité de l'élément "Patient Transfer" (1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1)
    aux spécifications du CI-SIS
    
    Historique :
   
   04/07/2017 : LBE : Création 
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_patientTransfer_fr">
    <title>IHE PCC v3.0 Patient Transfer - errors validation phase</title>
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.1.25.1.4.1&quot;]">
        
        <assert test="cda:code[@code = '80413-8']"> 
            [E_patientTransfer_fr] Erreur de conformité PCC : Le code utilisé pour un transfert est '80413-8'
        </assert>
        <assert test="cda:statusCode[@code = &quot;completed&quot; or @code=&quot;normal&quot;]"> 
            [E_patientTransfer_fr] Erreur de conformité PCC : Le statut du transfert est obligatoire. l'attribut @code prend la valeur
            @code='completed' si le transfert à eu lieu (moodCode='EVN') ou @code='normal' lorsque le
            tranfert est projeté (moodCode='INT')
        </assert>
        
        <assert test="not(cda:statusCode[@code = 'completed']) or 
            (cda:statusCode[@code = 'completed'] and (cda:effectiveTime/cda:low and cda:effectiveTime/cda:high))"> 
            [E_patientTransfer_fr] Erreur de conformité PCC : effectiveTime est obligatoire lorsque le transfert a eu lieu. 
            Le sous-élément 'low' indique l'heure de départ et le sous-élément 'high' indique celle d'arrivée.
        </assert>
        
        <assert
            test="not(self::cda:act[@negationInd='false']) or (self::cda:act[@negationInd='false' and @moodCode='EVN'] and cda:statusCode[@code = 'completed'])">
            [E_patientTransfer_fr] Erreur de conformité PCC : l'attribut @code prend la valeur @code='completed' si le transfert à eu lieu (moodCode='EVN'). </assert>
        
    </rule>
    
</pattern>
