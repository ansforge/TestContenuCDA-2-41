<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ VitalSignsObservation20131024.sch ]O@%#o>>=-
    
    Teste la conformité de l'élément "Vital Signs Observation" 1.3.6.1.4.1.19376.1.5.3.1.4.13.2)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    24/10/2013 : CRI : Création   
    20/06/2017 : LBE :  Mise à jour aux nouvelles spécifications
                        fusion avec le schématron contrôlant la valeur des éléments code et value
                        Changement de nom 
    03/07/2017 : LBE :  Corrections d'erreur, ajout de la vérification du code LOINC
    02/08/2017 : NMA : Suppression du test sur l'unité
    17/08/2017 : NMA : Ajout des codes APGAR à 1mn et APGAR à 5Mn
    02/04/2019 : APE : Mise à jour des codes LOINC  
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    30/11/2020 : APE : Suppression du contrôle des valeurs car vérifié par schématron JDV générique JDV_vitalSignCode.sch
    13/09/2021 : APE : Ajout du contrôle APGAR 10 mn et correction du contrôle de l'unité des APGAR (INT au lieu de PQ)
    16/09/2021 : APE : Suppression du contrôle APGAR car le type doit toujours être "PQ".
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_vitalSignsObservation_int.sch">
    
    <title>IHE PCC v3.0 Vital Signs Observation</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.2"]'>
        
        <!-- count des templateId -->
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <!-- Verifier que le templateId parent de l'observation est présent. --> 
        <assert test='cda:templateId[@root = "2.16.840.1.113883.10.20.1.31"]'> 
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : l'identifiant du template parent (2.16.840.1.113883.10.20.1.31) doit être présent. 
        </assert>
        
        <!-- Verifier que le templateId parent de l'observation est présent. --> 
        <assert test='cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'> 
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : l'identifiant du template parent (1.3.6.1.4.1.19376.1.5.3.1.4.13) doit être présent. 
        </assert>
        
        <assert test="$count_templateId&gt;2">
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : l'élément 'observation' doit contenir au minimum trois templateId.
        </assert>
            
        <assert test="cda:effectiveTime">
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : l'élément 'effectiveTime' doit être présent.
        </assert>
        
        <!-- 30/11/2020 : APE : Suppression du contrôle des valeurs car vérifié par schématron JDV générique JDV_vitalSignCode.sch 
        <assert test='cda:code[
            @code ="2708-6" or
            @code ="8280-0" or
            @code ="8287-5" or
            @code ="8302-2" or
            @code ="8306-3" or
            @code ="8310-5" or
            @code ="8462-4" or
            @code ="8480-6" or
            @code ="8867-4" or
            @code ="9272-6" or
            @code ="9274-2" or
            @code ="9279-1" or
            @code ="29463-7" or
            @code ="39156-5"
            ]'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : Le code de l'entrée 'Signe vital observé' doit être :
            2708-6	pour Saturation en Oxygène
            8280-0	pour Périmètre abdominal (à l'ombilic)           
            8287-5	pour Périmètre crânien
            8302-2	pour Taille
            8306-3	pour Taille (couché)
            8310-5	pour Température corporelle
            8462-4	pour Pression artérielle diastolique
            8480-6	pour Pression artérielle systolique
            8867-4	pour Fréquence cardiaque
            9272-6	pour APGAR à 1mn
            9274-2	pour APGAR à 5mn 
            9279-1	pour Fréquence respiratoire
            29463-7 pour Poids (Mesuré)
            39156-5	pour Index de masse corporelle (IMC)
        </assert>
        -->
        
<!--        <!-\- Type PQ des données Vital Signs -\->
        <assert test='cda:value[@xsi:type="PQ"]'>
            [VitalSignsObservationValues] Erreur de conformité PCC : La mesure d'un signe vital utilise le type de données PQ.
        </assert>-->
        
        <!-- Poids (Mesuré) -->
        <assert test='not(cda:code[@code="29463-7"]) or (cda:code[@code="29463-7"] and cda:value[@unit="kg" or @unit="g"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure du poids (29463-7) 
            est un nombre indénombrable s'exprimant en grammes (g) ou en kilogrammes (kg).
        </assert>
        
        <!-- Fréquence respiratoire -->
        <assert test='not(cda:code[@code="9279-1"]) or (cda:code[@code="9279-1"] and cda:value[@unit="/min"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la fréquence respiratoire (9279-1) 
            est un nombre indénombrable s'exprimant en min-1 (/min).
        </assert>
        
        <!-- Fréquence cardiaque -->
        <assert test='not(cda:code[@code="8867-4"]) or (cda:code[@code="8867-4"] and cda:value[@unit="/min"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la fréquence cardiaque (8867-4) 
            est un nombre indénombrable s'exprimant en min-1 (/min).
        </assert>
        
        <!-- Saturation en oxygène -->
        <assert test='not(cda:code[@code="2708-6"]) or (cda:code[@code="2708-6"] and cda:value[@unit="%"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la saturation en oxygène (2708-6)
            est un nombre indénombrable s'exprimant en pourçentage (%).
        </assert>
        
        <!-- Pression artérielle systolique -->
        <assert test='not(cda:code[@code="8480-6"]) or (cda:code[@code="8480-6"] and cda:value[@unit="mm[Hg]"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la pression artérielle systolique (8480-6)
            est un nombre indénombrable s'exprimant en millimètres de mercure (mm[Hg]).
        </assert>
        
        <!-- Pression artérielle diastolique -->
        <assert test='not(cda:code[@code="8462-4"]) or (cda:code[@code="8462-4"] and cda:value[@unit="mm[Hg]"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la pression artérielle diastolique (8462-4)
            est un nombre indénombrable s'exprimant en millimètres de mercure (mm[Hg]).
        </assert>
        
        <!-- Température corporelle -->
        <assert test='not(cda:code[@code="8310-5"]) or (cda:code[@code="8310-5"] and cda:value[@unit="Cel" or @unit="[degF]"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la Température corporelle (8310-5)
            est un nombre indénombrable s'exprimant en degrés Celsius (Cel) ou en degré Fahrenheit ([degF]).
        </assert>
        
        <!-- Taille -->
        <assert test='not(cda:code[@code="8302-2"]) or (cda:code[@code="8302-2"] and cda:value[@unit="m" or  @unit="cm" or @unit="[in_us]" or @unit="[in_uk]"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure de la Taille (8302-2)
            est un nombre indénombrable s'exprimant en degrés mètres (m), en centimètres (cm),
            en inches US ([in_us]) ou en inches UK [in_uk].
        </assert>
        
        <!-- Périmètre crânien (Mesuré) -->
        <assert test='not(cda:code[@code="8287-5"]) or (cda:code[@code="8287-5"] and cda:value[@unit="m" or  @unit="cm" or @unit="[in_us]" or @unit="[in_uk]"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure du Périmètre crânien (8287-5)
            est un nombre indénombrable s'exprimant en degrés mètres (m), en centimètres (cm),
            en inches US ([in_us]) ou en inches UK [in_uk].
        </assert>
        
        <!-- Poids -->
        <assert test='not(cda:code[@code="29463-7"]) or (cda:code[@code="29463-7"] and cda:value[@unit="kg" or @unit="g" or @unit="[lb_av]" or @unit="[oz_av]"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : la mesure du Poids corporel (29463-7)
            est un nombre indénombrable s'exprimant en kilogrammes (kg), en grammes (g),
            en livres avoirdupois ([lb_av]) ou en onces avoirdupois [oz_av].
        </assert>
        
        <!-- IMC -->
        <assert test='not(cda:code[@code="39156-5"]) or (cda:code[@code="39156-5"] and cda:value[@unit="kg/m2"])'>
            [E_vitalSignsObservation_int.sch] Erreur de conformité PCC : L'indice de masse corporelle (39156-5)
            est un nombre indénombrable s'exprimant en kilogrammes par m carré (kg/m2)
        </assert>
        
    </rule>
    
</pattern>
