<?xml version="1.0" encoding="UTF-8"?>

<!--                   
     -=<<o#%@O[ updateInformationOrganizer.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "E_updateInformationOrganizer_int" (1.3.6.1.4.1.19376.1.3.10.4.5)
    aux spécifications d'IHE PaLM Suppl.APSR 2.0 (Rev 2.1 – 2018-09-28)
    
    Historique :
    04/01/2019 : NNA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_updateInformationOrganizer_int">

    <title>Palm_Suppl_APSR V2.0 Update Information Organizer Entry</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.3.10.4.5"]'>
        
        <let name="count_statusCode" value="count(cda:statusCode)"/>
                
        <assert test="@classCode='BATTERY' and @moodCode='EVN'">
            [E_updateInformationOrganizer_int.sch] Erreur de conformité APSR : L'élément "organizer" de l'entrée "Update Information Organizer" doit avoir les attributs @classCode et @moodCode fixés respectivement aux valeurs suivante 'BATTERY' et 'EVN'
        </assert>
        
        <assert test="$count_statusCode = 1">
            [E_updateInformationOrganizer_int.sch] Erreur de conformité APSR : L'entrée "Update Information Organizer" doit contenir obligatoirement un élément statusCode (cardinalité [1..1])
        </assert>
        
        <assert test="cda:statusCode[@code='completed']">
            [E_updateInformationOrganizer_int.sch] Erreur de conformité APSR : L'attribut "code" de l'élément "statusCode" doit prendre la valeur 'completed'.
        </assert>
                 
       
    </rule>
    
</pattern>
