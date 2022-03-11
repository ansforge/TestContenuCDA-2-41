<?xml version="1.0" encoding="UTF-8"?>

<!-- E_ProtheseValvulaireOrg_F-PRC.sch
    
    Teste la conformité de l'organizer "Dispositif Médical Implanté" (1.2.250.1.213.1.1.3.2)
    aux spécifications du volet 'Patients à riques en cardiologie' du CI-SIS concernant un dispositif 
    de prothèse valvulaire.    
    
    Historique :
    31/08/2011 : Création
    08/11/2017 : Mise à jour du templateID 1.2.250.1.213.1.1.3.1
    22/02/2021 : Renommage    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_ProtheseValvulaireOrg_F-PRC">
    <title>CI-SIS - Prothèse Valvulaire</title>
    
    <rule context='*[(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.2.1.5"]) 
        and (cda:code/@code="D0001-11")]'>       
        
        <!--=<<o#%@O[ Général ]O@%#o>>=-->
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code ="D0001-11"]'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le code de l'organizer 'Prothèse Valvulaire' doit être L0062
            pris dans le vocabulaire TA_PRC (1.2.250.1.213.1.1.4.2)</assert> 
        
        <assert test='cda:code[@codeSystem = "1.2.250.1.213.1.1.4.2"]'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: L'élément 'codeSystem' de l'organizer 'Prothèse Valvulaire'
            doit être codé dans dans le vocabulaire TA_PRC (1.2.250.1.213.1.1.4.2).</assert>
        
        <!-- Verifier que l'organizer contient au moins un élément de type Observation Dispositifs Médicaux -->
        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.3.1"]'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS : L'organizer 'Prothèse Valvulaire' doit au moins contenir une entrée 'Observation Dispositifs Médicaux'</assert> 
        
        <!--=<<o#%@O[ Contenu Organizer ]O@%#o>>=-->
        
        <!-- Date d'implantation -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0055"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: La date d'implantation du matériel est un élément obligatoire de l'organizer.</assert>
        
        <!-- Type de matériel implanté -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0056"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le 'Type de matériel implanté' est un élément obligatoire de l'organizer. 
        </assert>
        <!-- Modèle de l'implant -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0051"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le 'modèle' de l'implant est un élément obligatoire de l'organizer.
        </assert>
        <!-- Numéro de série -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0031"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le 'numéro de série' de l'implant est un élément obligatoire de l'organizer.
        </assert>
        <!-- Valve -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0031"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le 'valve' que la prothèse remplace est un élément obligatoire de l'organizer.
        </assert>
        <!-- Compposant -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0032"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le 'composant' de la prothèse est un élément obligatoire de l'organizer.
        </assert>
        <!-- Diamètre -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0033"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le 'diamètre' de la prothèse est un élément obligatoire de l'organizer.
        </assert>
        <!-- Gradient -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0034"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le 'gradient' mesuré est un élément obligatoire de l'organizer.
        </assert>
        <!-- Niveau d'anticoagulation souhaité -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0035"'> 
            [E_ProtheseValvulaireOrg_F-PRC] Erreur de Conformité CI-SIS: Le 'niveau d'anticoagulation souhaité' est un élément obligatoire de l'organizer.
        </assert>

    </rule>
</pattern>


