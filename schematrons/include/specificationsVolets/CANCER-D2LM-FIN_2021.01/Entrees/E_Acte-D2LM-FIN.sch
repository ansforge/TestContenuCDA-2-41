<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   E_Acte-D2LM-FIN
   Schématron de vérification de la conformité au modèle du CI-SIS d'une entrée FR-Acte-D2LM-FIN dans une section FR-Actes-et-interventions-D2LM-FIN 
   d'un document CANCER-D2LM-FIN 
   
   CANCER-D2LM-FIN : CR de seconde lecture de mammographie - Fiche d'interprétation nationale
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
       28/07/2020 : Création
       09/09/2021 : Modification
   ......................................................................................................................................................    
-->
    
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_Acte-D2LM-FIN">
        
        <rule context="*:section[*:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11']/*:entry/*:procedure[*:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.19']">
                            
            <!-- Début des assertions -->             
            
            <assert test="*:code/@code='MG'">
                [E_Acte-D2LM-FIN.sch] L'entrée FR-Acte-D2LM-FIN doit avoir le code "MG".
            </assert>
            
            <assert test="count(*:participant[@typeCode='IND'])&gt; 1">
                [E_Acte-D2LM-FIN.sch] L'entrée FR-Acte-D2LM-FIN doit contenir au minimum 2 éléments participant de @typeCode='IND'. 
            </assert>
            
            <assert test="count(*:participant[@typeCode!='IND']) =0">
                [E_Acte-D2LM-FIN.sch] Seule la valeur "IND" est autorisée dans l'attribut @typeCode du participant.
            </assert>         
            
            <!-- Fin des ssertions --> 
        </rule>
    </pattern>



