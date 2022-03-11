<?xml version="1.0" encoding="UTF-8"?>
<!-- E_dispositifMedical-2_ANS.sch
       
     Vérification de la conformité de l'entrée FR-Dispositif-medical (1.2.250.1.213.1.1.3.20) créée par l'ANS
     (entrée FR-Dispositif-medical nouvelle version 16/10/2019 de type 'supply')
     
     Historique : 
     16/10/2019 : Création
     09/12/2021 : Ajout du moodCode INT
     
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_dispositifMedical-2_ANS">
    <title>Vérification de la conformité de l'entrée FR-Dispositif-medical (1.2.250.1.213.1.1.3.20) créée par l'ANS</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.20"]'>
        
        <assert
            test="self::cda:supply[@classCode='SPLY' and @moodCode='EVN' or 'INT']">
            [E_dispositifMedical-2_ANS.sch] Erreur de conformité CI-SIS : Les attributs @classCode et @moodCode de l'élément 'supply' doivent être fixés respectivement aux valeurs 'SPLY' et 'EVN'.
        </assert>
        
        <assert test='count(cda:templateId[@root="1.2.250.1.213.1.1.3.20"])=1'>
            [E_dispositifMedical-2_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée Dispositif médical, il doit y avoir un 'templateId' avec un attribut root='1.2.250.1.213.1.1.3.20'.
        </assert>
        
        <assert test='count(cda:templateId[@root="2.16.840.1.113883.10.20.1.34"])=1'>
            [E_dispositifMedical-2_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée Dispositif médical, il doit y avoir un 'templateId' avec un attribut root='2.16.840.1.113883.10.20.1.34'.
        </assert>
        
        <assert test="count(cda:effectiveTime)=1">
            [E_dispositifMedical-2_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée Dispositif médical, il doit y avoir un seul (et un seul) 'effectiveTime'. Si la date n’est pas connue, utiliser la valeur nullFlavor="UNK".
        </assert>
        
        <assert test="cda:participant">
            [E_dispositifMedical-2_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée Dispositif médical, au moins un élément 'participant' est obligatoire.
        </assert>
        
        <assert test="count(cda:participant/cda:participantRole[@classCode='MANU'])=1">
            [E_dispositifMedical-2_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée Dispositif médical, un (et un seul) élément 'participant/participantRole' est obligatoire avec un attribut classCode="MANU".
        </assert>
        
        <assert
            test="count(cda:participant/cda:participantRole/cda:playingDevice[@classCode='DEV' and @determinerCode='INSTANCE'])=1">
            [E_dispositifMedical-2_ANS.sch] Erreur de conformité CI-SIS : Dans l'entrée Dispositif médical, il doit y avoir un seul (et un seul) élément 'participant/participantRole/playingDevice' avec les attributs @classCode et @determinerCode respectivement fixés aux valeurs 'DEV' et 'INSTANCE'.
        </assert>
        
    </rule> 

</pattern>