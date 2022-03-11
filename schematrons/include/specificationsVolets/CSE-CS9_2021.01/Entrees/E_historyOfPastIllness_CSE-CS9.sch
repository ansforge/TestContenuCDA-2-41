<?xml version="1.0" encoding="UTF-8"?>

<!-- E_historyOfPastIllness_CSE-CS9.sch
    
    Vérification des entrées relatives aux antécédents médicaux du CSE-CS9.
    
    Historique :
    24/06/11 : Création
    30/06/11 : Adaptation aux modifications de structure du volet concernant les entrées Problem Concern de la section
    11/10/17 : Ajout du nom du schématron sur le nom des messages d'erreur
    22/11/17 : Mise à jour des codes TA_CS ==> TA_ASIP
    24/02/21 : Correction des contrôles
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_historyOfPastIllness_CSE-CS9">
    <title>Vérification des entrées relatives aux antécédents médicaux du CSE-CS9.</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.8"]'>         
        
        <!-- Prématurité inf. à 33 semaines MED-183 -->
        <assert          
            test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='MED-183'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité : 
            L'entrée FR-Probleme "Prématurité inf. à 33 semaines" est obligatoire. 
        </assert>
        
        <!-- Otites à répétition MED-211 -->
        <assert          
            test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='MED-211'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité :
            L'entrée FR-Probleme "Otites à répétition" est obligatoire. 
        </assert>
        
        <!-- Affections bronchopulmonaires à répétition MED-182 -->
        <assert          
            test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='MED-182'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité :
            L'entrée FR-Probleme "Affections bronchopulmonaires à répétition" est obligatoire.
        </assert>
        
        <!-- Affections bronchopulmonaires à répétition dont plus de trois sifflantes MED-184 -->
        <assert          
            test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='MED-184'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité : 
            L'entrée FR-Probleme "Affections bronchopulmonaires à répétition dont plus de trois sifflantes" est obligatoire.
        </assert>  
        
        <!-- Accident(s) domestique(s) avant le 9ème mois MED-186 -->        
        <assert          
            test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='MED-186'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité :
            L'entrée FR-Probleme 'Accidents domestiques avant le 9ème mois' est obligatoire.
        </assert>       
        <assert test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:value/@code='MED-186']/cda:entryRelationship/@typeCode='CAUS'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité : 
            La cause de l'accident domestique doit être indiquée dans un élément entryRelationship d'attribut typeCode='CAUS'
        </assert>
                
        <!-- Hospitalisation(s) en période néonatale ORG-091 -->
        <assert          
            test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='ORG-091'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité :
            L'entrée FR-Probleme "Hospitalisation(s) en période néonatale" est obligatoire.
        </assert>
        <assert test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:value/@code='ORG-091']/cda:entryRelationship/@typeCode='CAUS'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité : 
            Le motif d'hospitalisation doit être indiqué dans un élément entryRelationship d'attribut typeCode='CAUS'
        </assert>
        <assert test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:value/@code='ORG-091']/cda:entryRelationship/@typeCode='SUBJ'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité : 
            Le nombre d'hospitalisations doit être indiqué dans un élément entryRelationship d'attribut typeCode='SUBJ'
        </assert>
        
        <!-- Hospitalisations après la période néonatale ORG-093 -->
        <assert          
            test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5']/cda:value/@code='ORG-093'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité :
            Le test "Nombre d'hospitalisations après la période néonatale" doit être présent 
        </assert>
        <assert test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:value/@code='ORG-093']/cda:entryRelationship/@typeCode='CAUS'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité : 
            Le motif d'hospitalisation doit être indiqué dans un élément entryRelationship d'attribut typeCode='CAUS'
        </assert>
        <assert test="cda:entry/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']/cda:entryRelationship/cda:observation[cda:value/@code='ORG-093']/cda:entryRelationship/@typeCode='SUBJ'"> 
            [E_historyOfPastIllness_CSE-SC9] Erreur de conformité : 
            Le nombre d'hospitalisations doit être indiqué dans un élément entryRelationship d'attribut typeCode='SUBJ'
        </assert>        
        
    </rule> 
</pattern>

