<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    patient.sch :
    Contenu :
        Contrôle du patient dans l'en-tête CDA  
    Paramètres d'appel :
        Néant
    Historique :
    31/05/11 : FMY ASIP/PRAS : Création
    28/07/11 : FMY ASIP/PRAS : Contrôle de la présence d'adresse géographique (addr) et télécom (telecom)
    10/03/20 : ANS : Correction du contrôle de la présence de l'élément guardian [0..*]
    17/12/20 : ANS : Suppression des contrôles de présence obligatoire des éléments « addr » et « telecom »
    17/12/20 : ANS : Ajout d'un contrôle sur « given/@qualifier» afin de tester les valeurs à respecter si l’élément existe.
    19/04/21 : ANS : Ajout d'un contrôle sur les valeurs possibles des éléments "given/@qualifier" et "family/@qualifier"
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="recordTarget_fr">
    <rule context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole">
        <let name="count_name_patient" value="count(cda:patient/cda:name)"/>
        <let name="count_patient_name_qualifier" value="count(cda:patient/cda:name/cda:given/@qualifier)"/>
        <assert test="not(cda:id[@nullFlavor])">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément recordTarget/patientRole/id (obligatoire dans CDAr2), 
            doit être sans nullFlavor. 
        </assert>
        <assert test="$count_name_patient = 1">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément recordTarget/patientRole/patient/name ne doit être présent qu'une fois
        </assert>
        <assert test="$count_patient_name_qualifier = 0 or ($count_patient_name_qualifier &gt;0 and (cda:patient/cda:name/cda:given/@qualifier='BR' or cda:patient/cda:name/cda:given/@qualifier='CL'))">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : S'il existe, l'attribut @qualifier de l'élement name/given doit etre @qualifier='BR' ou @qualifier='CL'.
        </assert>
        
        <assert test="
            not(cda:patient/cda:religiousAffiliationCode) and
            not(cda:patient/cda:raceCode) and
            not(cda:patient/cda:ethnicGroupCode) 
            ">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : Un élément recordTarget/patientRole/patient 
            ne doit contenir ni race ni religion ni groupe ethnique.
        </assert>
        <assert test="cda:patient/cda:birthTime">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : l'élément recordTarget/patientRole/patient/birthTime doit être présent 
            avec une date de naissance ou un nullFlavor autorisé.
        </assert>
        <assert test="(not(cda:id/@root='1.2.250.1.213.1.4.8') and not(cda:id/@root='1.2.250.1.213.1.4.9') and not(cda:id/@root='1.2.250.1.213.1.4.10') and not(cda:id/@root='1.2.250.1.213.1.4.11'))
            and cda:id/@extension
            or (cda:patient/cda:name/cda:family/@qualifier
            and cda:patient/cda:name/cda:given
            and cda:patient/cda:birthTime
            and cda:patient/cda:administrativeGenderCode
            )">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : Dans le cadre de l'INS, les traits de l'INS (Nom de naissance, premier prénom, date de naissance et sexe) sont obligatoires
        </assert>
        <assert test="cda:patient/cda:name/cda:family/@qualifier='BR' or cda:patient/cda:name/cda:family/@qualifier='SP' or cda:patient/cda:name/cda:family/@qualifier='CL'">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément patient/name/family/@qualifier prend l'une des valeurs suivantes : "BR" pour le nom de famille
            "SP" pour le nom d’usage
            "CL" pour le nom utilisé (RNIV)
        </assert>
        <assert test="cda:patient/cda:name/cda:given/@qualifier='BR' or cda:patient/cda:name/cda:given/@qualifier='CL' or not(cda:patient/cda:name/cda:given/@qualifier)">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : Si présent, l'élément patient/name/given/@qualifier prend l'une des valeurs suivantes :
            "BR" pour le premier prénom extrait de la liste des prénoms de l’acte de naissance
            "CL" pour pour le prénom utilisé (RNIV)
        </assert>
    </rule>
    <rule context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:family">
        <assert test="@qualifier">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'attribut @qualifier est obligatoire d'ans l'élément family
        </assert>
        <assert test='@qualifier="BR" or @qualifier="CL" or @qualifier="SP"'>
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément patient/name/family/@qualifier prend l'une des valeurs suivantes : "BR" pour le nom de famille
            "SP" pour le nom d’usage
            "CL" pour le nom utilisé (RNIV)
        </assert>
    </rule>
    
    <rule context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:given">
        <assert test="@qualifier='BR' or @qualifier='CL' or not(@qualifier)">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : Si présent, L'élément patient/name/given/@qualifier prend l'une des valeurs suivantes :
            "BR" pour le premier prénom extrait de la liste des prénoms de l’acte de naissance
            "CL" pour pour le prénom utilisé (RNIV)
        </assert>
    </rule>

    <!-- ajouté par HKA le 10/03/20 -->
    <rule context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:guardian">
        <let name="count_name_guardianPerson" value="count(cda:guardianPerson/cda:name)"/>
        <assert test="$count_name_guardianPerson &lt;=1">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément recordTarget/patientRole/patient/guardian/guardianPerson/name ne doit être présent qu'une fois (cardinalité [0..1])
        </assert>
        <let name="count_name_guardianOrganization" value="count(cda:guardianOrganization/cda:name)"/> 
        <assert test="$count_name_guardianOrganization &lt;=1">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément recordTarget/patientRole/patient/guardian/guardianOrganization/name ne doit être présent qu'une fois (cardinalité [0..1])
        </assert>
    </rule> 
    
</pattern>
