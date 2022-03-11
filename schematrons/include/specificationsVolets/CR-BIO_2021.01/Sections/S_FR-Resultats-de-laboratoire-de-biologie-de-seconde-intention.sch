<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    S_FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention.sch :
    
    Vérification de la conformité d'une section de 1er niveau FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60)  
    
    Historique :
    13/01/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention">
    <p>Vérification de la conformité d'une section de 1er niveau FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60)</p>
    
    <!-- Contrôles des sections FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60) -->
    <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.60']">
        <assert test="cda:code"> [S_FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention] Erreur de conformité :
            Une section FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60) doit comporter un élément code. </assert>
    </rule>
</pattern>
