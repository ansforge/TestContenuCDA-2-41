<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_procedureIntervention_SNM.sch ]O@%#o>>=-
    
    Teste la conformité des valeurs de la section "Procedures" (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11)
    
    
    Historique :
    24/10/2013 : CRI : Création
    25/10/2017 : NMA : Renommage du schématron
    
    cda:entry/cda:procedure/cda:entryRelationship/cda:procedure/cda:code[1]
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_procedureIntervention_SNM">
    <title>IHE PCC v3.0 Procedures and Intervention Section</title>
        
        
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11"]'> 
            
        <assert test='not(cda:entry/cda:procedure[cda:code/@code="F-84610"]) 
            or (cda:entry/cda:procedure/cda:entryRelationship/cda:act/cda:code[
            @code="D8-12200" or
            @code="D8-22120" or
            @code="F-88450" or
            @code="OBS_002" or
            @code="OBS_205" or
            @code="OBS_206" or
            @code="XX-MCH170" or
            @code="XX-MCH171"
            ])'> 
            <!-- Vérifier que la section contient des éléments Procedure Entry -->
            [S_procedureIntervention_SNM]: Les valeurs possibles pour cet éléments sont
            contenues dans le jeu de valeurs 'SAP_MotifDeclenchementTravail'</assert>
        <!--        <assert test='not(cda:entry/cda:procedure[cda:code/@code="OBS_029"]) 
            or (cda:entry/cda:procedure[cda:code/@code="OBS_029"] 
            and cda:entry/cda:procedure/cda:entryRelationship/cda:procedure/cda:code[
            @code="OBS_207" or
            @code="OBS_208" or
            @code="P1-C0010" or
            @code="P1-C0200" or
            @code="P1-C0400" or
            @code="XX-MCH165"
            ])'> 
        -->
        
        
        <assert test='not(cda:entry/cda:procedure[cda:code/@code="OBS_029"]) 
            or cda:entry/cda:procedure/cda:entryRelationship/cda:procedure/cda:code[
            @code="OBS_207" or
            @code="OBS_208" or
            @code="P1-C0010" or
            @code="P1-C0200" or
            @code="P1-C0400" or
            @code="XX-MCH165"
            ]'> 
            <!-- Vérifier que la section contient des éléments Procedure Entry -->
            [S_procedureIntervention_SNM]: Les valeurs possibles pour cet éléments sont
            contenues dans le jeu de valeurs 'SAP_TypeAnesthesieAvantNaissance'</assert>
        
        <assert test='not(cda:entry/cda:procedure[cda:code/@code="OBS_031"]) 
            or cda:entry/cda:procedure/cda:entryRelationship/cda:procedure/cda:code[
            @code="OBS_209" or
            @code="P1-C0010" or
            @code="P1-C0200" or
            @code="P1-C0400" or
            @code="XX-MCH165"
            ]'> 
            <!-- Vérifier que la section contient des éléments Procedure Entry -->
            [S_procedureIntervention_SNM]: Les valeurs possibles pour cet éléments sont
            contenues dans le jeu de valeurs 'SAP_TypeAnesthesieAprèsNaissance'</assert>
        
        <assert test='not(cda:entry/cda:procedure[cda:code/@code="OBS_033"]) 
            or cda:entry/cda:procedure/cda:entryRelationship/cda:procedure/cda:code[
            @code="JNFA001" or
            @code="JPGD001" or
            @code="OBS_210" or
            @code="OBS_211" or
            @code="OBS_212" or
            @code="P1-30530" or
            @code="P1-86EA8" 
            ]'> 
            <!-- Vérifier que la section contient des éléments Procedure Entry -->
            [S_procedureIntervention_SNM]: Les valeurs possibles pour cet éléments sont
            contenues dans le jeu de valeurs 'SAP_TypeAnesthesieAprèsNaissance'</assert>
        
    
    </rule>
</pattern>