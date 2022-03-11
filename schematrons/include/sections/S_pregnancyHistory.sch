<?xml version="1.0" encoding="UTF-8"?>

<!-- pregnancyHistorySection.sch 
    ......................................................................................................................................................
    vérification de la conformité de la section FR-Historique-des-grossesses (Pregnancy History Section - 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4) à IHE PCC
    ......................................................................................................................................................
    Historique :
    25/07/2011 : Création
    03/07/2017 : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : Suppression du test sur le nombre de templateId
    30/11/2020 : Présence obligatoire d'au moins une des deux entrées suivantes [1..*] : FR-Observation-sur-la-grossesse [0..*] et/ou FR-Historique-de-la-grossesse [0..*]
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_pregnancyHistory">
    
    <title>Section FR-Historique-des-grossesses (IHE PCC Pregnancy History Section)</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4"]'>
        <let name="count_E_ObsGross" value="count(//cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5'])"/>
        <let name="count_E_HistoGross" value="count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1'])"/>
        <let name="count_nb_entrees" value="count(//cda:entry)"/>        
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [1] [S_pregnancyHistory] Erreur de conformité PCC : Le templateId de 'Pregnancy History' ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "10162-6"]'> 
            [2] [S_pregnancyHistory] Erreur de conformité PCC : Le code de la section FR-Historique-des-grossesses doit être "10162-6" 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [3] [S_pregnancyHistory] Erreur de conformité PCC : Le codeSystem de la section FR-Historique-des-grossesses doit être "2.16.840.1.113883.6.1" (LOINC). 
        </assert> 
        
        <!-- vérifier que les entrées utilisées dans cette section sont de type "Pregnancy Observation" ou "Pregnancy History Organizer" -->
        <assert test="(count(//cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5'])
            + count(//cda:entry/cda:organizer[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1']) 
            = count(//cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4']/cda:entry))">
            [4] [S_pregnancyHistory] Erreur de conformité PCC : 
            Une section FR-Historique-des-grossesses doit comporter uniquement des entrées de type :
            - FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) ou 
            - FR-Historique-de-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1)
        </assert> 
        
        <!-- Présence obligatoire d'au moins une des deux entrées suivantes [1..*] : FR-Observation-sur-la-grossesse [0..*] et/ou FR-Historique-de-la-grossesse [0..*] -->
        <assert test="($count_E_ObsGross&gt;=0) and ($count_E_HistoGross&gt;=0) and ($count_E_ObsGross+$count_E_HistoGross&gt;=1)">
            [5] [S_pregnancyHistory] Erreur de conformité PCC : 
            La section FR-Historique-des-grossesses doit contenir au moins une des deux entrées suivantes (cardinalité [1..*]) :
            - [0..*] FR-Observation-sur-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) (conformité de l'entrée au format IHE PCC) et/ou
            - [0..*] FR-Historique-de-la-grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1) (conformité de l'entrée au format IHE PCC)
        </assert>        
      
    </rule>
    
</pattern>