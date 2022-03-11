<?xml version="1.0" encoding="UTF-8"?>

<!-- E_DefribrillateurOrg_F-PRC.sch     
    Teste la conformité de l'organizer "Dispositif Médical Implanté" (1.2.250.1.213.1.1.3.2)
    aux spécifications du volet 'Patients à riques en cardiologie' du CI-SIS concernant un dispositif 
    défibrillateur.   
    
    Historique :
    10/08/2011 : Création
    24/08/2011 : Inclusion de l'Organizer Dernières Mesures
    29/08/2011 : Regroupement des Organizers Stimulateurs et Défibrillateurs sous le même organizer (DMI)
    08/11/2017 : Mise à jour du templateID 1.2.250.1.213.1.1.3.1
    22/02/2021 : Renommage
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_DefribrillateurOrg_F-PRC">
    <title>CI-SIS - Défibrillateur</title>

    <rule
        context='
            *[(/cda:ClinicalDocument/cda:templateId[@root = "1.2.250.1.213.1.1.1.2.1.3"])
            and (cda:code/@code = "D0001-1")]'>

        <!--=<<o#%@O[ Général Organizer Défibrillateur ]O@%#o>>=-->

        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "D0001-1"]'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le code de
            l'organizer 'Défibrillateur' doit être L0062 pris dans le vocabulaire TA_PRC
            (1.2.250.1.213.1.1.4.2)</assert>

        <assert test='cda:code[@codeSystem = "1.2.250.1.213.1.1.4.2"]'> Erreur de Conformité CI-SIS:
            [E_DefribrillateurOrg_F-PRC] L'élément 'codeSystem' de l'organizer 'Défibrillateur' doit être codé dans dans le
            vocabulaire TA_PRC (1.2.250.1.213.1.1.4.2).</assert>

        <!-- Verifier que l'organizer contient au moins un élément de type Observation Dispositifs Médicaux -->
        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.3.1"]'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité PCC: L'élément 'Défibrillateur' doit au moins contenir une entrée 'Observation
            Dispositifs Médicaux'</assert>

        <!--=<<o#%@O[ Contenu Organizer Défibrillateur  ]O@%#o>>=-->

        <!-- Date d'implantation -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0055"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: La date d'implantation du matériel est un élément
            obligatoire de l'organizer.</assert>

        <!-- Type de matériel implanté -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0056"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le Type de matériel implanté est un élément obligatoire
            de l'organizer. </assert>
        <!-- Localisation de l'implant -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0054"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: La Localisation de l'implant est un élément obligatoire
            de l'organizer. </assert>
        <!-- Marque de l'implant -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0050"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: La marque de l'implant est l'un des éléments obligatoires
            constitutifs de l'organizer 'Défibrillateur'. </assert>
        <!-- Modèle de l'implant -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0051"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le modèle de l'implant est un élément obligatoire de
            l'organizer. </assert>
        <!-- Numéro de série -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0059"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le numéro de série de l'implant est un élément
            obligatoire de l'organizer. </assert>
        <!-- Tension de la pile à ERI -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0001"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: La tension de la pile à ERI est l'un des éléments
            obligatoires constitutifs de l'organizer 'Défibrillateur'. </assert>
        <!-- IRE -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0003"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: L'IRE est un élément obligatoire de l'organizer. </assert>
        <!-- Type défibrillateur -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0004"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le type du défibrillateur est un élément obligatoire de
            l'organizer. </assert>
        <!-- Asservissement -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0006"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le type d'asservissement est l'un des éléments
            obligatoires constitutifs de l'organizer 'Défibrillateur'. </assert>
        <!-- Télésuivi -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0007"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le télésuivi est un élément obligatoire de l'organizer. </assert>
        <!-- Télésuivi activé -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0008"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: L'activation du télésuivi est un élément obligatoire de
            l'organizer. </assert>

        <!--=<<o#%@O[ Evaluation fonctions physiques ]O@%#o>>=-->
        <!-- Stade NYHA -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0009"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le stade NYHA est un élément obligatoire de l'organizer. </assert>
        <!-- FEVG -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0010"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: La FEVG est l'un des éléments obligatoires constitutifs
            de l'organizer 'Défibrillateur'. </assert>

        <!--=<<o#%@O[ Dernière Mesure ]O@%#o>>=-->


        <!-- Date Dernière Mesure) -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0012"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: la date des dernières mesures est un élément obligatoire
            de l'organizer. </assert>
        <!-- Mode Programmé Dernière Mesure -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0013"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: le mode programmé est un élément obligatoire de
            l'organizer. </assert>
        <!-- Tension Dernière Mesure -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0014"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Tension est un élément obligatoire de l'organizer. </assert>
        <!-- Impédance Dernière Mesure -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0015"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Impédance est un élément obligatoire de l'organizer. </assert>
        <!-- Temps de charge Dernière Mesure -->
        <assert
            test='cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0016"'>
            [E_DefribrillateurOrg_F-PRC] Erreur de Conformité CI-SIS: Temps de charge est un élément obligatoire de
            l'organizer. </assert>
    </rule>
</pattern>
