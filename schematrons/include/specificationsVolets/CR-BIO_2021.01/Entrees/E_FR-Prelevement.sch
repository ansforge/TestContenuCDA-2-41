<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    E_FR-Prelevement.sch :
    
    Vérification de la conformité d'une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2)
    
    Historique :
    13/01/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_FR-Prelevement">
    <p>Vérification de la conformité d'une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2)</p>
    
    <rule context="cda:procedure[./cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1.2']">
        
        <assert test="./cda:participant[@typeCode = 'PRD' and ./cda:participantRole/@classCode = 'SPEC']"> 
            [E_FR-Prelevement] Erreur de conformité :
            Une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2) doit comporter un participant de typeCode 'PRD'
            avec un fils participantRole de classCode 'SPEC'. 
        </assert>
        
        <assert test="
            (count(./cda:entryRelationship/cda:act/cda:code[@code = 'SPRECEIVE' and @codeSystem = '1.3.5.1.4.1.19376.1.5.3.2']) = 1 and
            ./cda:entryRelationship/cda:act/cda:effectiveTime/@value) or
            not(./cda:entryRelationship/cda:act/cda:code[@code = 'SPRECEIVE'])">
            [E_FR-Prelevement] Erreur de conformité :
            Une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2), si elle comporte l'acte "Réception de l'échantillon au laboratoire"
            doit alors préciser la date et heure de réception de l'échantillon à l'aide d'un effectiveTime@value. 
        </assert>
        
        <assert test="
            ./cda:entryRelationship/cda:act[./cda:code/@code = 'SPRECEIVE' and 
                                            ./cda:code/@codeSystem = '1.3.5.1.4.1.19376.1.5.3.2' and
                                            ./cda:effectiveTime/@value] or
            not(./cda:entryRelationship/cda:act/cda:code[@code = 'SPRECEIVE'])">
            [E_FR-Prelevement] Erreur de conformité :
            Une entrée FR-Prelevement (1.3.6.1.4.1.19376.1.3.1.2), si elle comporte l'acte "Réception de l'échantillon au laboratoire"
            doit alors préciser la date et heure de réception de l'échantillon à l'aide d'un effectiveTime@value. 
        </assert>
        
    </rule>
</pattern>
