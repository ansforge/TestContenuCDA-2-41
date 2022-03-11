<?xml version="1.0" encoding="UTF-8"?>

<!-- E_periodeRenouvellement_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Periode-de-renouvellement (IHE PHARM PRE - Renewal-Period - 1.3.6.1.4.1.19376.1.9.1.3.15) à IHE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_periodeRenouvellement_int">
        <title>IHE PHARM PRE "Renewal Period"</title>

        <rule context="//cda:entryRelationship[@typeCode='COMP']/cda:supply[@classCode='SPLY'][@moodCode='RQO']/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.15']">
            
            <!-- Test présence et format de l'élément 'effectiveTime' -->
            <assert test="(count(cda:effectiveTime)=1)">
                [1] [E_periodeRenouvellement_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Periode-de-renouvellement doit comporter un élément 'effectiveTime'.
            </assert>
            
            <!-- Test du format des éléments fils de l'élément 'effectiveTime' -->
            <!-- Il reste à ajouter le contrôle sur le dataType en fonction de l'option choisie-->
            <assert test="(cda:effectiveTime/cda:high) or (cda:effectiveTime/cda:width)">
                [2] [E_periodeRenouvellement_int.sch] Erreur de conformité IHE Pharm PRE :  
                Dans l'entrée FR-Periode-de-renouvellement, l'élément 'effectiveTime' doit comporter soit un élément 'high' soit un élément 'width'. 
            </assert>
    
        </rule>
            
    </pattern>
