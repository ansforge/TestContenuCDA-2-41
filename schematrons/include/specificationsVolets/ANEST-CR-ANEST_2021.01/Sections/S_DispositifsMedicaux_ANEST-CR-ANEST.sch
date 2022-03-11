<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DispositifsMedicaux_ANEST-CR-ANEST.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Dispositifs-medicaux (1.2.250.1.213.1.1.2.1) dans le document ANEST-CR-ANEST 
   
   ANEST-CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    23/11/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DispositifsMedicaux_ANEST-CR-ANEST">
    <title>CI-SIS ANEST-CR-ANEST Section Dispositifs Médicaux </title>
    
  
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.1"]'>
        
        <!-- Vérifier le title de la section 'FR-Dispositifs-medicaux' -->
        <assert test=".//cda:title/text()='Dispositifs médicaux'">
            [S_DispositifsMedicaux_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Une section FR-Dispositifs-medicaux (1.2.250.1.213.1.1.2.1) doit obligatoirement contenir le title 'Dispositifs médicaux'
        </assert>
        
        <!-- Vérifier le code de la taille du dispositif supraglottique si l'enrée FR-Dispositif-Medical '1.2.250.1.213.1.1.3.20' existe-->
        <assert test='not(.//cda:supply[cda:participant/cda:participantRole/cda:playingDevice/cda:code/@code="R51DC01"]) or
            (count(.//cda:supply[cda:participant/cda:participantRole/cda:playingDevice/cda:code/@code="R51DC01"])&gt;=1 and .//cda:supply[cda:participant//cda:code/@code="R51DC01"]/cda:entryRelationship/cda:observation/cda:code/@code="GEN-234")'>
            [S_DispositifsMedicaux_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : 
            Si elle existe, l'entryRelationship de la taille du DM supraglottique doit avoir un élément code avec l'attribut @code='GEN-234'.
        </assert>
        
        
        <!-- Vérifier le code de la taille de la sonde d'intubation si l'enrée FR-Dispositif-Medical '1.2.250.1.213.1.1.3.20' -->
        <assert test='not(.//cda:supply[cda:participant/cda:participantRole/cda:playingDevice/cda:code/@code="R51AE"]) or
            (count(.//cda:supply[cda:participant/cda:participantRole/cda:playingDevice/cda:code/@code="R51AE"])&gt;=1 and .//cda:supply[cda:participant//cda:code/@code="R51AE"]/cda:entryRelationship/cda:observation/cda:code/@code="GEN-234")'>
            [S_DispositifsMedicaux_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : 
            Si elle existe, l'entryRelationship de la taille de la sonde d'intubation doit avoir un élément code avec l'attribut @code='GEN-234'.
        </assert>
    </rule>
    
</pattern>