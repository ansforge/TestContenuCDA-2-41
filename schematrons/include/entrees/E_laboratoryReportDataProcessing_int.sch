<?xml version="1.0" encoding="UTF-8"?>

<!--                   
    E_laboratoryReportDataProcessing_int.sch
    Vérifie la conformité de l'entrée laboratory report data processing en fonction du profil PALM 
    Paramètres d'appel :
        Néant
    27/06/2017 : LBE : Création
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_laboratoryReportDataProcessing_int">

    <title>IHE PaLM laboratory Report Processing</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.3.1"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test="../cda:entry[@typeCode='DRIV']">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément entry de laboratory report data processing doit avoir un attribut @typeCode fixé à la valeur 'DRIV'
        </assert>
        
        <assert test="cda:act[@classCode='ACT' and @moodCode='EVN']">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément act de laboratory report data processing doit être présent et posséder les attributs @classCode et @moodCode prenant respectivement les valeurs 'ACT' et 'EVN'
        </assert>
        
       <!-- Vérification de l'élément code pas nécéssaire car vérifié par le schéma xsd -->
        
        <assert test="cda:act/cda:statusCode[@code ='completed' or @code='active' or @code='aborted']">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément statusCode doit être présent et possèder l'attribut @code prenant l'une des valeurs suivantes : completed, active ou aborted
        </assert>
        
        <assert test="cda:act/cda:entryRelationship[@typeCode='COMP']">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : l'entrée Laboratory Report Data processing doit contenir au moins une entryRelationship dont l'attribut @typeCode est fixé à 'COMP'.
        </assert>
        
    </rule>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1']/cda:act/cda:subject">
        
        <let name="count_adresse" value="count(cda:relatedSubject/cda:addr)"/>
        
        <assert test="@typeCode='SBJ'">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un attribut @typêCode fixé à la valeur 'SBJ' s'il est présent
        </assert>
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.3.3.1.2.1']">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un templateId ayant la valeur @root = '1.3.6.1.4.1.19376.1.3.3.1.2.1'
        </assert>
        <assert test="cda:templateId">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un templateId 
        </assert>
        <assert test="cda:relatedSubject">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément subject doit contenir un relatedSubject
        </assert>
        <assert test="cda:relatedSubject/cda:code">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément relatedSubject doit contenir un code
        </assert>
        <assert test="$count_adresse=1">
            [E_laboratoryReportDataProcessing.sch] Erreur de conformité PaLM : L'élément relatedSubject doit contenir une adresse (cardinalité [1..1])
        </assert>
        
    </rule>
</pattern>
