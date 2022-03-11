<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_procedureEntry_OBP.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Procedures" (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/07/11 : CRI : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_procedureEntry_OBP">
    <title>IHE PCC v3.0 Procedures and Intervention Section</title>

        
        
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11"]'> 
        <assert test='cda:entry/cda:procedure/cda:code[@code="JQQP003"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Autopsie"
        </assert>          
         
        <assert test='cda:entry/cda:procedure/cda:code[@code="OBS_251"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Dépistage hyperphénylalaninémie"
        </assert>  
        <assert test='cda:entry/cda:procedure/cda:code[@code="OBS_252"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Dépistage hypothyroïdie"
        </assert>  
        <assert test='cda:entry/cda:procedure/cda:code[@code="OBS_253"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Dépistage hyperplasie congénitale des surrénales"
        </assert>  
        <assert test='cda:entry/cda:procedure/cda:code[@code="OBS_254"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Dépistage drépanocytose"
        </assert>  
        <assert test='cda:entry/cda:procedure/cda:code[@code="OBS_255"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Dépistage mucoviscidose"
        </assert>  
        <assert test='cda:entry/cda:procedure/cda:code[@code="OBS_256"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Dépistage MCAD"
        </assert>  
        <assert test='cda:entry/cda:procedure/cda:code[@code="OBS_257"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Test audition"
        </assert>   
        <assert test='cda:entry/cda:procedure/cda:code[@code="P2-47430"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Vaccination Hépatite Virale B"
        </assert> 
        <assert test='cda:entry/cda:procedure/cda:code[@code="P2-47020"]'>
            [S_procedureEntry_OBP]: Une section "Procedures and Interventions" 
            doit contenir une entrée "Vaccination par le BCG"
        </assert> 
        
    </rule>
</pattern>