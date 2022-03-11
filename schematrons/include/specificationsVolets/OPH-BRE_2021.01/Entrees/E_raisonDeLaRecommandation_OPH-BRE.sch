<?xml version="1.0" encoding="UTF-8"?>

<!--                  
   E_raisonDeLaRecommandation_OPH-BRE.sch
    Teste la conformité du contenu des entrées FR-Simple-Observation( 1.3.6.1.4.1.19376.1.5.3.1.4.13) sépcifiées dans le volet OPH-BRE
    
    Historique :
    14/06/2021 :  SBM : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_raisonDeLaRecommandation_OPH-BRE">
    
    
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"> 
       
        <assert test="count(cda:code)=1">
            [E_raisonDeLaRecommandation_OPH-BRE.sch] Erreur de conformité : Dans l'entrée FR-Simple-Observation, il doit y avoir un élément code (cardinalité [1..1])
        </assert>
        <assert test='cda:code[@code = "42349-1"]'>
            [E_raisonDeLaRecommandation_OPH-BRE.sch] Erreur de conformité : Le code de cette entrée doit être '42349-1'
        </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [E_raisonDeLaRecommandation_OPH-BRE.sch] Erreur de conformité : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <assert test="cda:statusCode/@code='completed'">
            [E_raisonDeLaRecommandation_OPH-BRE.sch] Erreur de conformité : Dans l'entrée FR-Simple-Observation, le statusCode doit présent et fixé à la valeur @code='completed'
        </assert>
        <assert test="cda:effectiveTime">
            [E_raisonDeLaRecommandation_OPH-BRE.sch] Erreur de conformité : Dans l'entrée FR-Simple-Observation, un élément effectiveTime doit être présent 
        </assert>
        <assert test="count(cda:value)=1">
            [E_raisonDeLaRecommandation_OPH-BRE.sch] Erreur de conformité : Dans l'entrée FR-Simple-Observation, il doit y avoir un élément value (cardinalité [1..1])
        </assert>
    </rule>
    
</pattern>