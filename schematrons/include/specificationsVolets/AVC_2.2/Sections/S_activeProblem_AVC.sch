<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ activeProblemSection.sch ]O@%#o>>=-
    
    Teste la conformité de la section " Active Problems Section" (1.3.6.1.4.1.19376.1.5.3.1.3.6)
    aux spécifications du volet AVC AUNV
    
    Historique :
    17/04/2015 : JDS : Creation
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="AVC_activeProblemSection-errors">


    <title>CI-SIS AVC AUNV Active Problems Section</title>

    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.6&quot;]">
        
        <assert test='.//cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:value/@code="D3-02000"'>
            [AVC_activeProblemSection] L'entrée HTA doit être indiquée
        </assert>
        
        <assert test='.//cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:value/@code="DB-61000"'>
            [AVC_activeProblemSection] L'entrée Diabète doit être indiquée
        </assert>
        
        <assert test='.//cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:value/@code="DA-38000"'>
            [AVC_activeProblemSection] L'entrée Migraine doit être indiquée
        </assert>
        
        <assert test='.//cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:value/@code="D9-74320"'>
            [AVC_activeProblemSection]  L'entrée Syndrome d'apnée du sommeil doit être indiquée
        </assert>
    </rule>
</pattern>
