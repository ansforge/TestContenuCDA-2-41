<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   E_ListeDesProblemesActifs-D2LM-FIDD
   Schématron de vérification de la conformité au modèle du CI-SIS d'une entrée ListeDesProblemesActifs dans un document D2LM-FIDD 
   
   D2LM_FIDD : Liste des problèmes actifs
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
       28/07/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_ListeDesProblemesActifs-D2LM-FIDD">
        <rule context="cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6']/cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']">
            
            
            <!-- Variables --> 
            <let name="EntréeMasseVal" value="cda:observation/cda:code[@code='MED-118']"/>
            <let name="EntréeCalcificationsVal" value="cda:observation/cda:code[@code='MED-119']"/>
            <let name="EntréeMasseEtCalcificationsVal" value="cda:observation/cda:code[@code='MED-026']"/>
            <let name="EntréeDistortionArchitecturaleVal" value="cda:observation/cda:code[@code='MED-027']"/>
            <let name="EntréeAsymétriefocaleVal" value="cda:observation/cda:code[@code='MED-028']"/>
            <let name="EntréeProblèmeCode" value="cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:code/@code='F-01000'"/>
            <let name="EntréeProblèmeVal" value="cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='D48.6'"/>
            
            <!-- Début des assertions --> 
            <!-- Vérifier l'existence de 10 entryRelationship FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) au maximum  -->
            <assert test="count(cda:entryRelationship[@typeCode='REFR']/cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13') &lt;= 10" >
                [E_ListeDesProblemesActifs-D2LM-FIDD] 10 entryRelationship @typeCode='REFR' sont autorisées [0..10].
            </assert>
            <!-- Vérifier l'obligation de l'existence d'une seule entryRelationship portant l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5)-->
            <assert test="count(cda:entryRelationship[@typeCode='SUBJ']/cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5') = 1" >
                [E_ListeDesProblemesActifs-D2LM-FIDD] Une seule entryRelationship ayant un attribut @typeCode='SUBJ' et de type Problème (1.3.6.1.4.1.19376.1.5.3.1.4.5) est autorisée [1..1]
            </assert>
            
            <!-- Vérifier les valeurs "REFR" et "SUBJ" des attributs @typeCode des entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) et FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5) -->
            <assert test="count(cda:entryRelationship[@typeCode!='REFR' and @typeCode!='SUBJ']) = 0">
                [E_ListeDesProblemesActifs-D2LM-FIDD] Seules les valeurs "REFR" et "SUBJ" sont autorisées dans les attributs @typeCode de entryRelationship.
            </assert>
            
            <!-- Vérifier le code(@code='F-01000') de l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5)-->
            <assert test="cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:code/@code='F-01000'">
                [E_ListeDesProblemesActifs-D2LM-FIDD] Le code de l'entrée Problème doit avoir l'attribut @code='F-01000'
            </assert> 
            
            <!-- Vérifier la valeur value(@code='D48.6') de l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5) -->
            <assert test="cda:entryRelationship/cda:observation[cda:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='D48.6'">
                [E_ListeDesProblemesActifs-D2LM-FIDD] La valeur de l'entrée Problème doit avoir l'attribut @code='D48.6'
            </assert>
            
            <!-- Vérifier les codes des entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13)" -->
            <assert test="not(cda:entryRelationship[@typeCode='REFR']) or (count(cda:entryRelationship[@typeCode='REFR']/cda:observation/cda:code/@code='MED-118') &lt;= 2 or 
                count(cda:entryRelationship[@typeCode='REFR']/cda:observation/cda:code/@code='MED-119') &lt;= 2 or count(cda:entryRelationship[@typeCode='REFR']/cda:observation/cda:code/@code='MED-026') &lt;= 2 or
                count(cda:entryRelationship[@typeCode='REFR']/cda:observation/cda:code/@code='MED-027') &lt;= 2 or count(cda:entryRelationship[@typeCode='REFR']/cda:observation/cda:code/@code='MED-028') &lt;= 2)">
                [E_ListeDesProblemesActifs-D2LM-FIDD] Si elles existent, les entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) doivent avoir un élément code avec l'attribut @code='MED-118
                ou @code='MED-119' ou @code='MED-026' ou @code='MED-027' ou @code='MED-028'.
            </assert> 
            <!-- Fin des assertions --> 
            
        </rule>
    </pattern>
    
