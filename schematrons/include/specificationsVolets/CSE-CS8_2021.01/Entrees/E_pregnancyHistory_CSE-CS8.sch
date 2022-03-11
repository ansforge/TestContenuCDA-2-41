<?xml version="1.0" encoding="UTF-8"?>

<!-- E_pregnancyHistory_CSE-CS8.sch
    
    Vérification des entrées Observation sur la grossesse (1.3.6.1.4.1.19376.1.5.3.1.4.13.5) 
    de la section Historique des grossesses (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4) du CSE-CS8.
        
    Historique :
    25/07/2011 : Création
    21/11/2017 : Mise à jour des codes TA_CS ==> TA_ASIP
    23/02/2021 : Séparation des schématrons par document (ici CSE-CS8) et modification des messages d'erreur
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_pregnancyHistory_CSE-CS8">
    <title>Vérification des entrées Observation sur la grossesse du CSE-CS8</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5"]'> 
 
        <assert test='cda:code[@code="ORG-076" or            
            @code="11977-6" or
            @code="11996-6" or
            @code="11637-6" or
            @code="MED-159" or
            @code="MED-160" or
            @code="11636-8" or
            @code="D8-20432" or
            @code="MED-164" or
            @code="D8-11210" or
            @code="D8-11120" or
            @code="DB-61400" or
            @code="MED-165" or
            @code="ORG-077" or
            @code="D8-11000" or
            @code="D8-70110" or
            @code="D8-12000" or
            @code="ORG-078" or
            @code="29463-7" or
            @code="8302-2"
            ]'>            
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité : 
            L'attribut 'code' doit être codé selon les valeurs prévues dans le volet. 
        </assert>

        <assert test='not(cda:code[@code="ORG-076"]) or cda:value[@xsi:type="CD"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité : 
            L'élément "Date de la première consultation" est une donnée codée (@xsi:type="CD").           
        </assert>    
        <assert test='not(cda:code[@code="11977-6"]) or cda:value[@xsi:type="INT"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité : 
            L'élément "Parité" s'exprime en entier sans unité (@xsi:type="INT").           
        </assert>
        <assert test='not(cda:code[@code="11996-6"]) or cda:value[@xsi:type="INT"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Gestité" s'exprime en entier (@xsi:type="INT").           
        </assert>
        <assert test='not(cda:code[@code="11637-6"]) or cda:value[@xsi:type="INT"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Nb d'enfants nés avant 37 semaines" s'exprime en entier sans unité (@xsi:type="INT").           
        </assert>
        <assert test='not(cda:code[@code="MED-159"]) or cda:value[@xsi:type="INT"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Nb d'enfants pesant moins de 2500g" s'exprime en entier sans unité (@xsi:type="INT").           
        </assert>
        <assert test='not(cda:code[@code="MED-160"]) or cda:value[@xsi:type="INT"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Nb d'enfants morts-nés" s'exprime en entier sans unité (@xsi:type="INT").           
        </assert>
        <assert test='not(cda:code[@code="11636-8"]) or cda:value[@xsi:type="INT"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            l'élément "Nombre d'enfants nés vivants et décédés avant 28 jours" s'exprime en entier sans unité (@xsi:type="INT").
        </assert>
        <assert test='not(cda:code[@code="D8-20432"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Antécédents de Césarienne" est un booléen (@xsi:type="BL").
        </assert>
        <assert test='not(cda:code[@code="MED-164"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Pathologie en cours de grossesse" est un booléen (@xsi:type="BL").           
        </assert>
        <assert test='not(cda:code[@code="D8-11210"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Prééclampsie" est un booléen (@xsi:type="BL").
        </assert>        
        <assert test='not(cda:code[@code="D8-11120"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "HTA traitée" est un booléen (@xsi:type="BL").
        </assert> 
        <assert test='not(cda:code[@code="DB-61400"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Diabète gestationnel" est un booléen (@xsi:type="BL").
        </assert>
        <assert test='not(cda:code[@code="MED-165"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Autre pathologie en cours de grossesse" est un booléen (@xsi:type="BL").
        </assert>
        <assert test='not(cda:code[@code="ORG-077"]) or cda:value[@xsi:type="PQ"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Hospitalisation y compris à do-micile (nb de jours)" s'exprime en nb de jours (@xsi:type="PQ").
        </assert>
        <assert test='not(cda:code[@code="D8-11000"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "HTA (hypertension dans un con-texte obstétrical)" est un booléen (@xsi:type="BL").
        </assert>
        <assert test='not(cda:code[@code="D8-70110"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "PAG (petit poids pour l’âge ges-tationnel)" est un booléen (@xsi:type="BL").
        </assert>
        <assert test='not(cda:code[@code="D8-12000"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "MAP (menace d'accouchement prématuré)" est un booléen (@xsi:type="BL").
        </assert>
        <assert test='not(cda:code[@code="ORG-078"]) or cda:value[@xsi:type="BL"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Autre motif d'hospitalisation" est un booléen (@xsi:type="BL").
        </assert>        
        <assert test='not(cda:code[@code="29463-7"]) or cda:value[@xsi:type="PQ"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Poids habituel de la mère (en dehors de la grossesse)" s'exprime en kg (@xsi:type="PQ").
        </assert>     
        <assert test='not(cda:code[@code="8302-2"]) or cda:value[@xsi:type="PQ"]'>
            [E_pregnancyHistory_CSE-CS8] Erreur de conformité :
            L'élément "Taille (de la mère)" s'exprime en m ou cm (@xsi:type="PQ").
        </assert>
    </rule>
</pattern>