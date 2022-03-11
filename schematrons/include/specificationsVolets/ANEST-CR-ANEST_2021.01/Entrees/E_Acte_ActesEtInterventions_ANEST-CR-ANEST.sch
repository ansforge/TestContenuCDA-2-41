<?xml version="1.0" encoding="UTF-8"?>

<!--                  
   E_Acte_ActesEtInterventions_ANEST-CR-ANEST.sch
    Teste la conformité du contenu des entrées FR-Acte sépcifiées dans le volet ANEST-CR-ANEST
    
    Historique :
    01/12/2020 :  SBM : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_Acte_ActesEtInterventions_ANEST-CR-ANEST">
    
    
    <rule context="cda:procedure[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.19' and (cda:code/@code='MED-581' or cda:code/@code='MED-582'
        or cda:code/@code='MED-583' or cda:code/@code='MED-584' or cda:code/@code='MED-585' or cda:code/@code='MED-586' or cda:code/@code='MED-587' or cda:code/@code='MED-588' or
        cda:code/@code='MED-658' or cda:code/@code='EPLF002' or cda:code/@code='MED-632'or cda:code/@code='GLLP003' or cda:code/@code='GDFA014'
        or cda:code/@code='GDFA014' or cda:code/@code='MED-876' or cda:code/@code='MED-885')]"> 

        <!-- Vérifier le code de la difficulté : entryRelationsip FR-Simple-Observation [0..1] -->
        <assert test="not(.//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']) 
            or (count(.//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and not(cda:code/@code='MED-594')])=1 and
            .//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code[@code='GEN-023'])">
            [E_Acte_ActesEtInterventions_CRANEST] Erreur de conformité : L'entryRelationsip FR-Simple-Observation '1.3.6.1.4.1.19376.1.5.3.1.4.13' de la difficulté doit avoir la cardinalité [0..1] et l'élément code doit avoir l'attribut @code='GEN-023'.
        </assert>
    </rule>
        
    <rule context="cda:procedure[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.19' and cda:code/@code='GELD004']"> 
        <!-- Vérifier le code du Score Cormack : entryRelationsip FR-Simple-Observation [0..1] -->
        <assert test="not(.//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']) or (count(.//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' and not(cda:code/@code='GEN-023')])=1 and .//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code/@code='MED-594')">
            [E_Acte_ActesEtInterventions_CRANEST] Erreur de conformité : L'entryRelationsip FR-Simple-Observation '1.3.6.1.4.1.19376.1.5.3.1.4.13' du Score Cormack doit avoir la cardinalité [0..1] et l'élément code doit avoir l'attribut @code='MED-594'. 
        </assert>
        
        <!-- Vérifier le code de la difficulté d'intubation: entryRelationsip FR-Simple-Observation [0..1] -->
        <assert test="not(.//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']) or (count(.//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'] and not(cda:code/@code='MED-594'))=1 and .//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']/cda:code[@code='GEN-023'])">
            [E_Acte_ActesEtInterventions_CRANEST] Erreur de conformité : L'entryRelationsip FR-Simple-Observation '1.3.6.1.4.1.19376.1.5.3.1.4.13' de la difficulté d'intubation doit avoir la cardinalité [0..1] et l'élément code doit avoir l'attribut @code='GEN-023'.
        </assert>
    </rule>
    
</pattern>