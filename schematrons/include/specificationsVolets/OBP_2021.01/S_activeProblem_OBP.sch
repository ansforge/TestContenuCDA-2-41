<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_activeProblem_OBP.sch ]O@%#o>>=-
    
    Teste la conformité de la section " Active Problems Section" (1.3.6.1.4.1.19376.1.5.3.1.3.6)
    aux spécifications d'IHE PCC v3.0 dans le cadre de OBP
    
    
    Historique :
    28/10/13 : CRI : Création - OBP_activeProblemSectionEntries20131028.sch
    25/10/17 : NMA : Renommage du schématron en S_activeProblem_OBP.sch
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_activeProblem_OBP">


    <title>IHE PCC v3.0 Active Problems Section Entries</title>

    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.6&quot;]">

        <!--  Vérification de la présence des entrées obligatoires        -->

        <assert test=".//cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:value/@code='OBS_016'">
            [S_activeProblem_OBP] : Une section "Active Problems" 
            dans le contexte SAP doit contenir une entrée"Metrorragies du 2ème- 3ème trimestre"
        </assert>
        <assert test="//cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:value/@code='D8-12000'">
            [S_activeProblem_OBP] : Une section "Active Problems" 
            dans le contexte SAP doit contenir une entrée "MAP"
        </assert>
        <assert test="//cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:value/@code='OBS_017'">
            [S_activeProblem_OBP] : Une section "Active Problems" 
            dans le contexte SAP doit contenir une entrée "Rupture prématurée des membranes"
        </assert>
        <assert test="//cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:value/@code='D8-11000'">
            [S_activeProblem_OBP] : Une section "Active Problems" 
            dans le contexte SAP doit contenir une entrée "Hypertension artérielle"
        </assert>
        <assert test="//cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:value/@code='E14'">
            [S_activeProblem_OBP] : Une section "Active Problems" 
            dans le contexte SAP doit contenir une entrée "Diabète"
        </assert>
        <assert test="//cda:act/cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:value/@code='D7-10030'">
            [S_activeProblem_OBP] : Une section "Active Problems" 
            dans le contexte SAP doit contenir une entrée "Infection urinaire"
        </assert>
        <assert test="//cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:value/@code='OBS_132'">
            [S_activeProblem_OBP] : Une section "Active Problems" 
            dans le contexte SAP doit contenir une entrée "Infection cervico-vaginale"
        </assert>
    </rule>
</pattern>


 <!-- 
     
 
 -->