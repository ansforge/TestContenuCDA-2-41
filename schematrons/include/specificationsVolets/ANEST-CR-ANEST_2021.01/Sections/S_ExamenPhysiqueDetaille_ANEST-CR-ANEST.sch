<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................    
   S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Examen-physique-detaille-code (1.2.250.1.213.1.1.2.84) dans le document ANEST-CR-ANEST.
   
   ANEST-CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    25/11/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ExamenPhysiqueDetaille_ANEST-CR-ANEST">
    <title>CI-SIS ANEST-CR-ANEST Examen physique détaillé</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15"]'> 
        
        <!-- Examen cardiovasculaire -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.29"]'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section 'Coeur'.
        </assert> 
        
        <!-- Système respiratoire voir CSE -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.30"]'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section'Système respiratoire'.
        </assert>
        
        <!-- Système Neurologique voir CSE-->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.35"]'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section'Système nerveux'.
        </assert>
        
        
        <!-- Système Oculaire  -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.19"]'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section 'Système oculaire'.
        </assert> 
        
        <!-- Système tégumentaire  -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.17"]'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section 'Système tégumentaire'.
        </assert> 
        
        <!-- Vaisseaux -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.33"]'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section 'Vaisseaux'.
        </assert> 
        
        <!-- Système uro-génital  -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.36"]'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section 'Système uro-génital'.
        </assert> 
        
        <!-- État général -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.16"]'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La section 'FR-Examen-physique-detaille-code' ne contient pas de sous-section 'État général'.
        </assert>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.29"]'> 
        <assert test='count(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="I46.9") &lt;=1'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La sous-section 'Coeur' ne contient pas l'entrée FR-Probleme : Arrêt cardiaque.
        </assert>
        <assert test='not(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5" and cda:value/@code="I46.9"]) or 
            (count(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5" and cda:value/@code="I46.9"])=1 and .//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5" and cda:value/@code="I46.9"]//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.1.2"]/cda:code/@code="11323-3")'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: Si l'entrée FR-Probleme(Arrêt cardiaque avec issue létale) existe, elle doit contenir l'entrée FR-Statut-clinique-du-patient(cause du décès) ayant comme code @code="11323-3".
        </assert>
        
        <assert test='count(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="T81.0")&lt;=1'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La sous-section 'Coeur' ne contient pas l'entrée FR-Probleme : Saignement peropératoire.
        </assert>
        <assert test='not(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="T81.0") or
            (count(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="T81.0")=1 and .//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5" and cda:value/@code="T81.0"]//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="GEN-167")'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: Si l'entrée FR-Probleme(Saignement peropératoire) existe, elle doit contenir l'entrée FR-Simple-Observation(quantité) ayant comme code @code="GEN-167".
        </assert>
        
        <assert test='count(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="T80")&lt;=1'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: La sous-section 'Coeur' ne contient pas l'entrée FR-Probleme : Transfusion.
        </assert>
        <assert test='not(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="T80") or 
            (count(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="T80")=1 and .//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5" and cda:value/@code="T80"]//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="933-2")'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: Si l'entrée FR-Probleme(Transfusion) existe, elle doit contenir l'entrée FR-Simple-Observation(type de produit sanguin labile) ayant comme code @code="933-2".
        </assert>
        <assert test='not(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="T80") or 
            (count(.//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5"]/cda:value/@code="T80")=1 and .//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.5" and cda:value/@code="T80"]//cda:observation[cda:templateId/@root ="1.3.6.1.4.1.19376.1.5.3.1.4.13"]/cda:code/@code="GEN-167")'>
            [S_ExamenPhysiqueDetaille_ANEST-CR-ANEST.sch] Erreur de Conformité au volet ANEST-CR-ANEST: Si l'entrée FR-Probleme(Transfusion) existe, elle doit contenir l'entrée FR-Simple-Observation(quantité) ayant comme code @code="GEN-167".
        </assert>
        
    </rule>
</pattern>