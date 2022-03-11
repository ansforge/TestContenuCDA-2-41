<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    E_imageIllustrative_int.sch :
    Contenu :
        Contrôle d'un élément observationMedia transportant une image illustrative
        dans un élément <observationMedia> selon template défini par le profil APSR
    Paramètres d'appel :
        Néant
    Historique :
        27/07/11 : Création
        30/10/17 : Changement du nom du schématron
        01/12/20 : Renommé
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_imageIllustrative_int">
    <p>Contrôle d'une image illustrative dans un élément observationMedia</p>
    <rule context="*[cda:templateId/@root = $templateObservationMedia]">
        
        <!-- Verifier que le templateId est utilisé à bon escient -->        
        <assert test="../cda:observationMedia[@classCode = 'OBS' and @moodCode = 'EVN' and @ID]"> 
            [E_imageIllustrative_int] Erreur de Conformité CI-SIS : 
            Le template d'image illustrative doit apparaître dans un élément observationMedia 
            de classCode 'OBS' et de moodCode 'EVN', et identifié par un attribut ID. </assert> 
        
        <!-- Vérifier la présence de l'élément value et la cohérence de ses attributs --> 
        <assert test="cda:value[(@mediaType = 'image/gif' or @mediaType = 'image/jpeg' or @mediaType = 'image/png') and @representation = 'B64']"> 
            [E_imageIllustrative_int] Erreur de Conformité CI-SIS : 
            L'image doit être un gif, un png ou un jpeg, encodé en base 64 dans le sous-élément value. </assert> 

    </rule>
</pattern>
