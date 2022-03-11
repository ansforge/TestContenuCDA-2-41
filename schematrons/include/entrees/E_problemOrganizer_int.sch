<?xml version="1.0" encoding="UTF-8"?>

<!--                   
     -=<<o#%@O[ problemOrganizer.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "E_problemOrganizer_int" (1.3.6.1.4.1.19376.1.8.1.3.6)
    aux spécifications d'IHE PaLM Suppl.APSR 2.0 (Rev 2.1 – 2018-09-28)
    
    Historique :
    04/01/2019 : NNA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_problemOrganizer_int">

    <title>Palm_Suppl_APSR V2.0 Problem Organizer Entry</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.8.1.3.6"]'>
                
        <assert test="@classCode='BATTERY' and @moodCode='EVN'">
            [E_problemOrganizer_int.sch] Erreur de conformité APSR : L'élément "organizer" de l'entrée "Problem organizer" doit avoir les attributs @classCode et @moodCode fixés respectivement aux valeurs suivante 'BATTERY' et 'EVN'
        </assert>
        
        <assert test="cda:statusCode[@code='completed' or @code='aborted']">
            [E_problemOrganizer_int.sch] Erreur de conformité APSR : L'entrée "Problem organizer" doit contenir un "statusCode" avec l'attribut @code qui prend les valeurs 'completed' ou 'aborted'
        </assert>
                 
        <assert test='cda:effectiveTime'>
            [E_problemOrganizer_int.sch] Erreur de conformité APSR : L'entrée "Problem organizer" doit comporter un élément "effectiveTime" .
        </assert>
    </rule>
    
</pattern>
