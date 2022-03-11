<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    E_FR-Resultat-examens-de-biologie-element-clinique-pertinent.sch :
    
    Vérification de la conformité d'une entrée FR-Resultat-examens-de-biologie-element-clinique-pertinent (1.3.6.1.4.1.19376.1.3.1.6)
    
    Historique :
    13/01/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_FR-Resultat-examens-de-biologie-element-clinique-pertinent">
    <p>Vérification de la conformité d'une entrée FR-Resultat-examens-de-biologie-element-clinique-pertinent (1.3.6.1.4.1.19376.1.3.1.6)</p>
    <rule context="cda:observation[./cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.1.6']">
        
        <assert test="@moodCode = 'EVN'"> 
            [E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            Un résultat dans une entry (avec templateId '1.3.6.1.4.1.19376.1.3.1.6')
            doit avoir un @moodCode 'EVN'. 
        </assert>

        <assert test="./cda:statusCode[@code = 'completed'] or ./cda:statusCode[@code = 'aborted']"> 
            [E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            Un résultat doit avoir un statusCode@code valant 'completed' ou 'aborted'. 
        </assert>
        
        <assert test="./cda:entryRelationship[@typeCode = 'REFR']/cda:observation/cda:effectiveTime or
                      not(./cda:entryRelationship[@typeCode = 'REFR'])"> 
            [[E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            L'antériorité d'un résultat doit obligatoirement être horodatée avec un élément effectiveTime. 
        </assert>
        
        <assert test="./cda:entryRelationship[@typeCode = 'REFR']/cda:observation/cda:statusCode[@code = 'completed'] or
            not(./cda:entryRelationship[@typeCode = 'REFR'])"> 
            [E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            L'antériorité d'un résultat est obligatoirement au statusCode 'completed'. 
        </assert>

        <assert test="count(./cda:referenceRange) =1 or not(./cda:referenceRange)"> 
            [E_FR-Resultat-examens-de-biologie-element-clinique-pertinent] Erreur de conformité :
            L'intervalle de référence d'un résultat doit être présente au maximum une fois 
        </assert>
    </rule>
</pattern>
