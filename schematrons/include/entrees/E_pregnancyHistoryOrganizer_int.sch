<?xml version="1.0" encoding="UTF-8"?>

<!-- E_pregnancyHistoryOrganizer_int.sch 
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Historique-de-la-grossesse (IHE PCC - Pregnancy History Organizer - 1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1)à IHE.
     ......................................................................................................................................................
     Historique :
     23/06/17 : Création E_pregnancyHistoryOrganizer_int.sch
     12/10/17 : Correction de l'assert sur la présence du sequenceNumber
     30/11/20 : Présence obligatoire d'au moins une des deux entrées suivantes [1..*] : 
                - FR-Observation-sur-la-grossesse [0..*] et/ou 
                - FR-Historique-de-la-grossesse [0..*] 
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_pregnancyHistoryOrganizer_int">
    <title>IHE PCC Pregnancy History Organizer (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1)</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1"]'>

        <!-- 30/11/2020 : Présence obligatoire d'au moins une des deux entrées suivantes [1..*] : 
            - FR-Observation-sur-la-grossesse [0..*] et/ou 
            - FR-Historique-de-la-grossesse [0..*] -->
        <let name="count_Comp_ObsGross" value="count(//cda:component/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5'])"/>
        <let name="count_Comp_naiss" value="count(//cda:component/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2'])"/>
        
        <assert test='self::cda:organizer[@classCode="CLUSTER" and @moodCode="EVN"]'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse est un cluster d'entrées Pregnancy Observations.
            Les attributs classCode et moodCode doivent obligatoirement être respectivement égaux à "CLUSTER" et "EVN"
        </assert>
        
        <assert test='cda:id'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse doit comporter un identifiant "id".
        </assert>
       
        <assert test='cda:code'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse doit comporter un code "code" .
        </assert>
        
        <assert test="cda:statusCode[@code='completed']"> 
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse décrit l'observation d'un fait clinique. 
            Son composant "statutCode" sera donc toujours fixé à la valeur code='completed'. </assert>
        <let name="count_statusCode" value="count(cda:statusCode)"/>
        
        <assert test="$count_statusCode=1">
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse ne peut avoir qu'un seul élément statusCode.
        </assert>
        
        <assert test='cda:effectiveTime'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse doit comporter un élément "effectiveTime" .
        </assert>
        
        <assert test='cda:component'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse doit comporter au moins un élément "component" pour représenter la personne ou le dispositif
        </assert>

        <!-- 30/11/2020 : Présence obligatoire d'au moins une des deux entrées suivantes [1..*] : 
            - FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) [0..*] et/ou 
            - FR-Historique-de-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2) [0..*] -->
        <assert test="($count_Comp_ObsGross&gt;=0) and ($count_Comp_naiss&gt;=0) and ($count_Comp_ObsGross+$count_Comp_naiss&gt;=1)">
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC :
            Une entrée FR-Historique-de-la-grossesse doit contenir au moins une des deux entrées suivantes (cardinalité [1..*]) : 
            - [0..*] FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) et/ou
            - [0..*] FR-Naissance (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2).
        </assert>
        
        <!-- 30/11/2020 : vérifier que les entrées utilisées dans cette section sont de type "Pregnancy Observation" ou "Pregnancy History Organizer" -->
        <assert test="(count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1']/cda:component/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5'])
            + count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1']/cda:component/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2']) 
            = count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1']/cda:component))">
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC :
            Une entrée FR-Historique-de-la-grossesse doit comporter uniquement des entrées de type :
            - FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) ou 
            - FR-Naissance (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2)
        </assert> 
        
        <assert test='not(cda:component//cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2"]) or (cda:component//cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2"] and cda:component/cda:sequenceNumber)'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée FR-Historique-de-la-grossesse comportant une entrée FR-Naissance (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2) doit contenir un élément "sequenceNumber".
        </assert>

    </rule>
</pattern>