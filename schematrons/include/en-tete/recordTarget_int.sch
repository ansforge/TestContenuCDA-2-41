<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    recordTarget_int.sch :
    Contenu :
      Contrôle de de conformité au profil IHE-XDS-SD de l'élément <recordTarget> de l'en-tête correspondant au patient 
    Paramètres d'appel :
        Néant
    Historique :
    12/06/2017 : LBE : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="recordTarget_int">
    <rule context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole">
     
        <assert test="cda:id[@root] and cda:id[@extension]">
            [recordTarget_int.sch] Erreur de conformité IHE_XDS-SD : L'élément recordTarget/patientRole/id  
            doit contenir les attributs 'root' et 'extension'
        </assert>
        
        <assert test="cda:patient/cda:administrativeGenderCode">
            [recordTarget_int.sch] Erreur de conformité IHE_XDS-SD :  l'élément recordTarget/patientRole/patient/administrativeGenderCode 
            doit être présent avec le code sexe ou un nullFlavor autorisé.
        </assert>
        
        <assert test="not(cda:id[@nullFlavor])">
            [recordTarget_int.sch] Erreur de conformité IHE_XDS-SD :  L'élément recordTarget/patientRole/id (obligatoire dans CDAr2), 
            doit être sans nullFlavor.
        </assert>
        <assert test="cda:patient/cda:name/cda:given">
            [recordTarget_int.sch] Erreur de conformité IHE_XDS-SD : l'élément recordTarget/patientRole/patient/name/given doit être présent avec le prénom du patient ou un nullFlavor.
        </assert>
        <assert test="cda:patient/cda:name/cda:family">
            [recordTarget_int.sch] Erreur de conformité IHE_XDS-SD : l'élément recordTarget/patientRole/patient/name/family doit être présent avec le nom du patient ou un nullFlavor.
        </assert>
        
    </rule>
</pattern>