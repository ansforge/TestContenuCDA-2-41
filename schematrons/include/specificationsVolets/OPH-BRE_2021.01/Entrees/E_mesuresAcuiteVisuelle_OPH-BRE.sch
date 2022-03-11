<?xml version="1.0" encoding="UTF-8"?>

<!--                 
   E_mesuresAcuiteVisuelle_OPH-BRE
   Teste la conformité de l'entrée FR-Liste-des-mesures-acuite-visuelle aux spécifications OPH-BRE du CI-SIS.
   
   05/10/2021 : Création
   
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_mesuresAcuiteVisuelle_OPH-BRE">
    <title>Vérification de la conformité de l'entrée FR-Liste-des-mesures-acuite-visuelle</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.2']">
        
        <assert test=".//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.6']/cda:code/@code='95320-8'">
            [E_mesureDeRefractionObservation_OPH-BRE] Erreur de conformité :
            L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenir une entrée FR-Mesure-acuite-visuelle (1.3.6.1.4.1.19376.1.12.1.3.6) pour la puissance de la sphère (code="95320-8").
        </assert>
        
        <assert test=".//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.6']/cda:code/@code='95322-4'">
            [E_mesureDeRefractionObservation_OPH-BRE] Erreur de conformité :
            L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenir une entrée FR-Mesure-acuite-visuelle (1.3.6.1.4.1.19376.1.12.1.3.6) pour la puissance du cylindre (code="95322-4").
        </assert>
        
        <assert test=".//cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.6']/cda:code/@code='95321-6'">
            [E_mesureDeRefractionObservation_OPH-BRE] Erreur de Conformité :
            L'entrée FR-Liste-des-mesures-acuite-visuelle doit contenir une entrée FR-Mesure-acuite-visuelle (1.3.6.1.4.1.19376.1.12.1.3.6) pour l'axe (code="95321-6").
        </assert>
        
    </rule>  
    
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.12.1.3.6']">
        <assert test=".//cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1']/cda:code/@code='70938-6'">
            [E_mesureDeRefractionObservation_OPH-BRE] Erreur de Conformité :
            L'entrée FR-Mesure-acuite-visuelle (1.3.6.1.4.1.19376.1.12.1.3.6) doit contenir une entryRelationship avec le code @code='70938-6' pour faire la liaison entre les mesures de réfraction et de l'acuité visuelle.
        </assert>
    </rule>
    
</pattern>

