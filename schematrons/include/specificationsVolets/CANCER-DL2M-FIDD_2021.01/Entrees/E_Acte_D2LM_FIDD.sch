<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   E_Acte_D2LM_FIN
   Schématron de vérification de la conformité au modèle du CI-SIS d'une entrée Acte dans un document D2LM-FIN 
   
   D2LM_FIN : CR de seconde lecture de mammographie - Fiche d'interprétation nationale
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
       06/09/2021 : SBM : Création
   ......................................................................................................................................................    
-->
    
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_Acte_D2LM_FIDD">
        <rule context="*:section[*:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.28']/*:entry/*:procedure[*:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.19']">
            <!-- Début des assertions --> 
            
            <assert test="*:code/@code='MG'">
                [E_Acte_D2LM_FIDD.sch] L'entrée Acte doit avoir le code "MG".
            </assert>
            
            <!-- Fin des ssertions --> 
        </rule>
    </pattern>



