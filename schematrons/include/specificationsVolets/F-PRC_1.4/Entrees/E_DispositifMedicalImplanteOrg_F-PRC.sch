<?xml version="1.0" encoding="UTF-8"?>

<!--  E_DispositifMedicalImplanteOrg_F-PRC.sch    
    Teste la conformité de l'organizer "Dispositif Médical Implanté" (1.2.250.1.213.1.1.3.2)
    aux spécifications du volet 'Modèles de Contenu' du CI-SIS
    
    Historique :
    26/08/2011 : Création
    08/11/2017 : Mise à jour du templateID 1.2.250.1.213.1.1.3.1
    22/02/2021 : Renommage
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_DispositifMedicalImplanteOrg_F-PRC">
    <title>CI-SIS - Dispositif Médical Implanté</title>
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.3.2"]'>

        <!-- Verifier que l'organizer contient au moins un élément de type Observation Dispositifs Médicaux (S+D) -->
        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.3.1"]'>
            [E_DispositifMédicalImplanteOrg_F-PRC] Erreur de Conformité PCC: L'organizer doit au moins contenir une entrée 'Observation Dispositifs
            Médicaux'</assert>

        <!-- Présence des observations obligatoires -->

        <!-- Date d'implantation -->
        <assert
            test='
                (cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:code/@code = "L0055")
                and (cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]/cda:value/@value)'>
            [E_DispositifMédicalImplanteOrg_F-PRC] Erreur de Conformité CI-SIS: La date d'implantation est un élément obligtoire de
            l'organizer. </assert>
        <!-- Dispositif implanté -->
        <assert
            test='
                cda:component/cda:observation[cda:templateId/@root = "1.2.250.1.213.1.1.3.1"]
                /cda:code/@code = "L0056"'>
            [E_DispositifMédicalImplanteOrg_F-PRC] Erreur de Conformité CI-SIS: 'Dispositif implanté' est un élément obligtoire. </assert>

    </rule>
</pattern>
