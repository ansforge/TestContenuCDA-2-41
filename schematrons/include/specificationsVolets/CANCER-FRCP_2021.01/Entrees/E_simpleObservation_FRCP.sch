<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    E_simpleObservation_FRCP.sch
    Teste la conformité du contenudes entrées simple obsevration sur-sépcifiées dans le voelt FRCP
    
    Historique :
    10/07/2017 :  LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_simpleObservation_FRCP">
   
        
      <!-- Règle vérifiant la simple Observation contenue dans ne code Reason for Referal -->  
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.2"]'> 
            
         
        <!-- Teste la cohérence RCP-Organe avec l'appareil concerné -->
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026']) or (./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_099'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : L'appareil concerné (RCP_099)doit être présent. 
        </assert>
        
        <!-- Teste le type d'entryRelationship de type 'SUBJ'-->       
        <assert test="not(./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship/cda:observation/cda:code[@code='RCP_099']) or 
            ./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:code[@code='RCP_099']">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : La valeur de @typeCode est @typeCode='SUBJ'. 
        </assert>
        
                             <!-- -=<<o#%@O[ Organe concerné ]O@%#o>>=-  -->        
        
        <!-- Teste la présence -->
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026']) 
            or (./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_093'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : Le type de d'organe concerné (RCP_093) doit être figuré. 
        </assert>
        <!-- Teste le type d'entryRelationship de type 'REFR'-->    
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026']) or 
            ./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship[@typeCode='REFR']/cda:observation/cda:code[@code='RCP_093']">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : La valeur de @typeCode est 'REFR'. 
        </assert>
        
        <!-- Cas 2: type RCP = RCP Transversale et de soins de support -->
        
        <!-- Teste la cohérence RCP Transversale et de soins de support avec les soins -->
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_027']) or (./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_110'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : Les soins et traitements (RCP_110) doivent être présents. 
        </assert>
        

        
    </rule>
</pattern>