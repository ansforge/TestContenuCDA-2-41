<?xml version="1.0" encoding="UTF-8"?>

<!--  E_StimulateurOrg_F-PRC.sch
    
    Teste la conformité de l'organizer "Dispositif Médical Implanté" (1.2.250.1.213.1.1.3.2)
    aux spécifications du volet 'Patients à riques en cardiologie' du CI-SIS concernant un dispositif 
    stimulateur.
    
    Historique :
    24/08/2011 : Création
    29/08/2011 : Regroupement des Organizers Stimulateurs et Défibrillateurs sous le même organizer (DMI)
    08/11/2017 : Mise à jour du templateID 1.2.250.1.213.1.1.3.1
    22/02/2021 : Renommage
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_StimulateurOrg_F-PRC">
    <title>CI-SIS - Stimulateur</title>
    
    <rule context='*[(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.2.1.4"]) and (cda:code/@code="D0001-2") ]'>
        
               <!--=<<o#%@O[ Appareillage  ]O@%#o>>=-->
     
        <!-- Date d'implantation -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0055"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: La date d'implantation du matériel est un élément obligatoire de l'organizer.</assert>
       
        <!-- Type de matériel implanté -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0056"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le Type de matériel implanté est un élément obligatoire de l'organizer. 
        </assert>
        
       <!-- Marque de l'implant (S+D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0050"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: La marque de l'implant est l'un 
            des éléments obligatoires constitutifs de l'organizer.</assert>    
        
        <!-- Modèle de l'implant (S+D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0051"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le modèle de l'implant est l'un 
            des éléments obligatoires constitutifs de l'organizer'.</assert>
       
        <!-- Numéro de série (S+D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0059"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le numéro de série de l'implant est l'un 
            des éléments obligatoires constitutifs de l'organizer'.</assert>
        
        <!-- Fréquence s/s aimant (S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0060"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: La Fréquence s/s aimant de l'implant est l'un 
            des éléments obligatoires constitutifs de l'organizer'.</assert>
        
        <!-- Tension batterie (S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0065"'> 
            [E_StimulateurOrg_F-PRC]  Erreur de Conformité CI-SIS: La Tension batterie de l'implant est l'un 
            des éléments obligatoires constitutifs de l'organizer'.</assert>  
             
        <!-- Type PM (S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0036"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le type de Pacemaker est l'un 
            des éléments obligatoires constitutifs de l'organizer'.</assert>
 
        <!-- Asservissement (S+D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0006"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: L'asservissement est l'un 
            des éléments obligatoires constitutifs de l'organizer. </assert>   
        
        <!-- Télésuivi (S+D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0007"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: La présence pou l'absence de télésuivi est l'un 
            des éléments obligatoires constitutifs de l'organizer. </assert>
        
        <!-- Télésuivi activé (S+D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0008"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: L'activation du télésuivi est l'un 
            des éléments obligatoires constitutifs de l'organizer'.</assert>
        
        <!--=<<o#%@O[ Evaluation des fonctions cliniques ]O@%#o>>=-->
        
        <!-- Stade NYHA (S+D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0009"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: Le stade NYHA est l'un 
            des éléments obligatoires constitutifs de l'organizer.</assert>
        
        <!-- FEVG (S+D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0010"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: La FEVG est l'un 
            des éléments obligatoires constitutifs de l'organizer.</assert>              
        
        <!--=<<o#%@O[ Dernières Mesures ]O@%#o>>=-->
        
        <!-- Date (Dernière Mesure) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0012"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: la date des dernières mesures est un élément obligatoire de l'organizer.
        </assert>
        
        <!-- Mode Programmé (Dernière Mesure) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0013"'> 
            [E_StimulateurOrg_F-PRC]  Erreur de Conformité CI-SIS: le mode programmé est un élément obligatoire de l'organizer.
        </assert>
        
        <!-- Fréquence sans aimant (S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0037"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: la fréquence sans aimant est un 
            élément obligatoire de l'organizer 'Dernières Mesures'. </assert>
        
        <!-- Fréquence sous aimant (S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0066"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: la fréquence sans aimant est un 
            élément obligatoire de l'organizer 'Dernières Mesures'. </assert>
        
        <!-- Tension (Dernière Mesure) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0014"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: Tension est un élément obligatoire de l'organizer.
        </assert>
        
        <!-- Impédance (Dernière Mesure) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0015"'> 
            [E_StimulateurOrg_F-PRC] Erreur de Conformité CI-SIS: Impédance est un élément obligatoire de l'organizer.
        </assert>

    </rule>
</pattern>


