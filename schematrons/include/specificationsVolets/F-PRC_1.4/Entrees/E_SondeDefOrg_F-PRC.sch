<?xml version="1.0" encoding="UTF-8"?>

<!--  E_SondeDefOrg_F-PRC.sch
    
    Teste la conformité aux spécifications du volet 'Patients à riques en cardiologie' du CI-SIS 
    des Organizers 'sonde auriculaire', 'sonde ventriculaire droite', et 'sonde ventriculaire gauche'
    pour défibrillateurs.
    
    Historique :
    10/08/2011 : Création pour les sondes défibrillateurs
    24/08/2011 : Regroupement des éléments 'mesures à l'implantation' et 'mesures de dernier contrôle'
    dans les organizers 'sonde auriculaire', 'sonde ventriculaire droite', et 'sonde ventriculaire gauche'.
    31/08/2011 : Spécialisation des tests en Sondes pour défibrillateurs ( UFCV_SondeDefOrg.sch) et Stimulateurs ( UFCV_SondeStimOrg.sch)
    08/11/2017 : Mise à jour du templateID 1.2.250.1.213.1.1.3.1
    22/02/2021 : Renommage
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_SondeDefOrg_F-PRC">
    <title>CI-SIS - Défibrillateur/Stimulateurs</title>    
    
    <rule context='*[(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.2.1.3"]) 
        and ((cda:code/@code="D0001-3") or (cda:code/@code="D0001-4") or (cda:code/@code="D0001-5"))]'>        
        
        <!-- vérifier que les organizers concernant 
            les sondes A, VD, VG pour les défibrillateurs/stimulateurs sont présents--> 
        
        <assert test='cda:code[@code ="D0001-3" or
            @code ="D0001-4" or 
            @code ="D0001-5"]'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: Le code de l'organizer 'Sonde' doit être L0062
            pris dans le vocabulaire TA_PRC (1.2.250.1.213.1.1.4.2)
        </assert> 
        <!-- vérifier le vocabulaire du codage des organizers -->
        <assert test='cda:code[@codeSystem = "1.2.250.1.213.1.1.4.2"]'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: L'élément 'codeSystem' de l'organizer 'Défibrillateur'
            doit être codé dans dans le vocabulaire TA_PRC (1.2.250.1.213.1.1.4.2). 
        </assert>
             
        <!-- Date d'implantation -->
        <assert test='(cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0055") 
            and (cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:value/@value)'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: La date d'implantation est un élément obligtoire. 
        </assert>
        <!-- Dispositif implanté -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0056"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Dispositif implanté' est un élément obligtoire. 
        </assert>
        <!-- Localisation de l'implant -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0054"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Localisation de l'implant'est un élément obligtoire. 
        </assert>
        <!-- Marque de l'implant -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0050"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Marque de l'implant'est un élément obligtoire. 
        </assert>
        <!-- Modèle de l'implant -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0051"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Modèle de l'implant' est un élément obligtoire. 
        </assert>
        <!-- Numéro de série -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0059"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Numéro de série' est un élément obligtoire. 
        </assert>
        <!-- Polarité -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0053"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Polarité' est un élément obligtoire. 
        </assert>
        <!-- Connexions -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0017"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Connexions' est un élément obligtoire. 
        </assert>
        <!-- Adapteur -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0018"'> 
            [E_SondeDefOrg_F-PRC]  Erreur de Conformité CI-SIS: 'Adapteur'est un élément obligtoire. 
        </assert>
        <!-- Voie d'abord  -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0019"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Voie d'abord' est un élément obligtoire. 
        </assert>
       
        <!--=<<o#%@O[ Mesures à l'implantation ]O@%#o>>=-->
        
        <!-- Courant (D+S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0021"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Voie d'abord' est l'un des éléments obligatoires constitutifs de l'organizer 'Sonde'. 
        </assert>                       
        <!-- Détection (D+S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]
            /cda:code/@code="L0022"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Détection' est un élément obligatoire mesuré à l'implémentation des sondes.
        </assert>
        <!-- Impédance (D+S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0015"'> 
            [E_SondeDefOrg_F-PRC]  Erreur de Conformité CI-SIS: 'Impédance' est un élément obligatoire mesuré à l'implémentation des sondes. 
        </assert>
        <!-- Seuil à ms (D+S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0023"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Seuil à ms' est un élément obligatoire mesuré à l'implémentation des sondes.
        </assert>
        <!-- Défibrillation efficace (D) -->
        <assert test='not(cda:code/@code="D0001-4") 
            or (cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0024")'> 
            [E_SondeDefOrg_F-PRCF] Erreur de Conformité CI-SIS: 'Défibrillation efficace' est un élément obligatoire mesuré à l'implémentation de la sonde ventriculaire droite. 
        </assert>
        <!-- Impédance de choc (D) VD uniquement -->
        <assert test='not(cda:code/@code="D0001-4") 
            or (cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0025")'> 
            [E_SondeDefOrg_F-PRC]  Erreur de Conformité CI-SIS: 'Impédance de choc' est un élément obligatoire mesuré à l'implémentation de la sonde ventriculaire droite.
        </assert>
        <!-- Temps de Charge (D) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0016"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Temps de Charge' est un élément obligatoire mesuré à l'implémentation des sondes
        </assert>
        
        <!--=<<o#%@O[ Dernières Mesures ]O@%#o>>=-->
        
        <!-- Seuil de Stimulation (D+S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0026"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Seuil de Stimulation' est un élément obligatoire mesuré à l'implémentation des sondes</assert>
        <!-- Recueil (D)-->
        <assert test='not(cda:code/@code="D0001-4") 
            or (cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0027")'> 
            [E_SondeDefOrg_F-PRC]  Erreur de Conformité CI-SIS: 'Recueil' est un élément obligatoire  mesuré à l'implémentation des sondes
        </assert>
        <!-- Impédance (D+S) -->
        <assert test='cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0015"'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Impédance' est un élément obligatoire mesuré à l'implémentation des sondes
        </assert>
        <!-- Impédance de choc (VD uniquement) (D) -->
        <assert test='not(cda:code/@code="D0001-4") 
            or (cda:component/cda:observation[cda:templateId/@root="1.2.250.1.213.1.1.3.1"]/cda:code/@code="L0025")'> 
            [E_SondeDefOrg_F-PRC] Erreur de Conformité CI-SIS: 'Impédance de choc' est l'une des mesures  obligatoires constitutives de l'organizer 'Dernières Mesures du ventricule droit'.
        </assert>
    </rule>
</pattern>


