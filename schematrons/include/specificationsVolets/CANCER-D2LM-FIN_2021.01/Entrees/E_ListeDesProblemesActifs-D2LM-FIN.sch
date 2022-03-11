<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   E_ListeDesProblemesActifs-D2LM-FIN
   Schématron de vérification de la conformité au modèle du CI-SIS d'une entrée ListeDesProblemesActifs dans un document D2LM-FIN 
   
   D2LM_FIN : CR de seconde lecture de mammographie - Fiche d'interprétation nationale
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
       28/07/2020 : SBM : Création
   ......................................................................................................................................................    
-->
    
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_ListeDesProblemesActifs-D2LM-FIN">
        <rule context="/*:component/*:section[*:templateId/@root='1.2.250.1.213.1.1.2.58']/*:component/*:section[*:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6']/*:entry/*:act[*:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']">
            
            
           <!-- Variables  --> 
            <let name="EntréeMasseVal" value="*:observation/*:code[@code='MED-118']"/>
            <let name="EntréeCalcificationsVal" value="*:observation/*:code[@code='MED-119']"/>
            <let name="EntréeMasseEtCalcificationsVal" value="*:observation/*:code[@code='MED-026']"/>
            <let name="EntréeDistortionArchitecturaleVal" value="*:observation/*:code[@code='MED-027']"/>
            <let name="EntréeAsymétriefocaleVal" value="*:observation/*:code[@code='MED-028']"/>
            <let name="EntréeProblèmeCode" value="*:observation/*:templateId[@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']/*:code[@code='F-01000']"/>
            <let name="EntréeProblèmeVal" value="*:observation/*:templateId[@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']/*:value[@code='C00-D48']"/>
            
            <!-- Début des assertions --> 
            <!-- Vérifier l'existence de 10 entryRelationship FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) au maximum  -->
            <assert test="count(*:entryRelationship[@typeCode='REFR']/*:templateId[@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13']) &lt;= 10" >
                [E_ListeDesProblemesActifs-D2LM-FIN] 10 entryRelationship @typeCode='REFR' sont autorisées [0..10].
            </assert>
            <!-- Vérifier l'obligation de l'existence d'une seule entryRelationship portant l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5)-->
            <assert test="count(*:entryRelationship[@typeCode='SUBJ']/*:templateId[@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']) = 1" >
                [E_ListeDesProblemesActifs-D2LM-FIN] Une seule entryRelationship ayant un attribut @typeCode='SUBJ' et de type Problème (1.3.6.1.4.1.19376.1.5.3.1.4.5) est autorisée [1..1]
            </assert>
            
            <!-- Vérifier les valeurs "REFR" et "SUBJ" des attributs @typeCode des entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) et FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5) -->
            <assert test="count(*:entryRelationship[@typeCode!='REFR' or @typeCode!='SUBJ']) = 0">
                [E_ListeDesProblemesActifs-D2LM-FIN] Seules les valeurs "REFR" et "SUBJ" sont autorisées dans les attributs @typeCode de entryRelationship.
            </assert>
            
            <!-- vérifier que l'entrée FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) ayant toujours un templateId  "1.3.6.1.4.1.19376.1.5.3.1.4.13" -->
            <assert test="count(*:entryRelationship[@typeCode='REFR']/*:templateId[@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13'] ) = count(*:entryRelationship[@typeCode='REFR'])">
                [E_ListeDesProblemesActifs-D2LM-FIN] L'élement entryRelationship ayant un attribut @typeCode="REFR" doit avoir un templateId  "1.3.6.1.4.1.19376.1.5.3.1.4.13"
            </assert> 
            
            <!-- vérifier que l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5) est toujours de type Problème (1.3.6.1.4.1.19376.1.5.3.1.4.5) -->
            <assert test="count(*:entryRelationship[@typeCode='SUBJ']/*:templateId[@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5'] ) = count(*:entryRelationship[@typeCode='SUBJ'])">
                [E_ListeDesProblemesActifs-D2LM-FIN] l'élement entryRelationship ayant un attribut @typeCode="SUBJ" doit avoir un templateId  "1.3.6.1.4.1.19376.1.5.3.1.4.5"
            </assert> 
            
            <!-- Vérifier le code(@code='F-01000') de l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5)-->
            <assert test="*:entryRelationship[@typeCode='SUBJ']/$EntréeProblèmeCode">
                [E_ListeDesProblemesActifs-D2LM-FIN]  Le code de l'entrée Problème doit avoir l'attribut @code='F-01000'.
            </assert> 
            
            <!-- Vérifier la valeur value(@code='F-01000') de l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5) -->
            <assert test="*:entryRelationship[@typeCode='SUBJ']/$EntréeProblèmeVal">
                [E_ListeDesProblemesActifs-D2LM-FIN]  La valeur de l'entrée Problème doit avoir l'attribut @code='C00-D48'.
            </assert>
            
            <!-- Vérifier les codes des entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13)" -->
            <assert test="not(*:entryRelationship[@typeCode='REFR']) or (count(*:entryRelationship[@typeCode='REFR']/$EntréeMasseVal) &lt;= 1 or 
                count(*:entryRelationship[@typeCode='REFR']/$EntréeCalcificationsVal) &lt;= 1 or count(*:entryRelationship[@typeCode='REFR']/$EntréeMasseEtCalcificationsVal) &lt;= 1 or
                count(*:entryRelationship[@typeCode='REFR']/$EntréeDistortionArchitecturaleVal) &lt;= 1 or count(*:entryRelationship[@typeCode='REFR']/$EntréeAsymétriefocaleVal) &lt;= 1)">
                [E_ListeDesProblemesActifs-D2LM-FIN] Si elles existent, les entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) doivent avoir un élément code avec l'attribut @code='MED-118
                ou @code='MED-119' ou @code='MED-026' ou @code='MED-027' ou @code='MED-028'.
            </assert> 
            <!-- Fin des assertions --> 
            
        </rule>
    </pattern>
    

