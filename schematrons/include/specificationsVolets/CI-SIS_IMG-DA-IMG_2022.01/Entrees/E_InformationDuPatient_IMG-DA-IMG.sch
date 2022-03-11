<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  E_InformationDuPatient_IMG-DA-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de l'entrée FR-Simple-Observation(11.3.6.1.4.1.19376.1.5.3.1.4.13) dans le document IMG-DA-IMG qui décrit 
   la documentation d’une demande d'acte d’imagerie.
   
   IMG-DA-IMG : Demande d'acte d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    10/01/2022 : ANS : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_InformationDuPatient_IMG-DA-IMG">
    <title>CI-SIS IMG-DA-IMG Entrée Simple Observation</title>
    
    <rule context='cda:section[cda:templateId/@root="1.2.250.1.213.1.1.2.107"]//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
        
        <!-- Vérifier le code de l'entrée 'FR-Simple-Observation' -->
        <assert test="cda:code[@code='MED-1130' and @codeSystem='1.2.250.1.213.1.1.4.322']">
            [E_DirectiveAnticipee_IMG-DA-IMG] Erreur de conformité au modèle IMG-DA-IMG : l'entrée FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13.7) doit obligatoirement avoir comme code : @code='MED-1131' et @codeSystem='1.2.250.1.213.1.1.4.322'
        </assert>
    </rule>
    
</pattern>