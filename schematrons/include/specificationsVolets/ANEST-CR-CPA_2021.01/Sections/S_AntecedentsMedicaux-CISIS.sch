<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_AntecedentsMedicaux-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Antecedents-medicaux(1.3.6.1.4.1.19376.1.5.3.1.3.8) dans le document ANEST-CR-CPA 
   Section FR-Antecedents-medicaux : Antécédents médicaux
   
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    04/01/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_AntecedentsMedicaux-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Antécédents médicaux </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.8"]'>
        <!-- Vérifier le title de la section 'FR-Antecedents-medicaux' -->
        <assert test='.//cda:title/text()="Antécédents médicaux"'>
            [S_AntecedentsMedicaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe,
            une section FR-Antecedents-medicaux (1.3.6.1.4.1.19376.1.5.3.1.3.6) doit obligatoirement contenir le title 'Antécédents médicaux'
        </assert>
        
        <!-- Vérifier la cardinalité de l'entrée 'FR-Liste-des-problemes' -->
        <assert test='count(./cda:entry[cda:act/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5.2"]) &lt;= 1'>
            [S_AntecedentsMedicaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Antecedents-medicaux doit obligatoirement contenir [0..1] entrée FR-Liste-des-problemes(1.3.6.1.4.1.19376.1.5.3.1.4.5.2).
        </assert>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.8"]/cda:entry/cda:act[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5.2"]'>
        
        <!-- Vérifier les cardinalités des entryRelationships FR-Probleme[0..*] dans l'entrée 'FR-Liste-des-problemes' -->
        <assert test='count(./cda:entryRelationship[cda:observation/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5"]) &gt;= 0'>
            [S_AntecedentsMedicaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Liste-des-problemes(1.3.6.1.4.1.19376.1.5.3.1.4.5.2) doit obligatoirement contenir [0..*] entryRelationship FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5).
        </assert>
        
        <!-- Vérifier la cardinalité de l'entryRelationship FR-Commentaire-ER [0..1] dans l'entrée 'FR-Probleme' -->
        <assert test='./cda:entryRelationship[cda:observation/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:observation/count(cda:entryRelationship[cda:act/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.2"])&lt;= 1'>
            [S_AntecedentsMedicaux-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Probleme doit obligatoirement contenir [0..1] entryRelationship FR-Commentaire-ER '1.3.6.1.4.1.19376.1.5.3.1.4.2'.
        </assert>
        
    </rule>
    
</pattern>

