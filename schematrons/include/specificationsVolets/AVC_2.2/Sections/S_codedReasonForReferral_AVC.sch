<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ AVC_CodedReasonForReferralEntries.sch ]O@%#o>>=-
    
    Teste les entrées de la section "CodedReason For Referral Section" dans le cadre du volet AVC
    
    Historique :
    04/11/2013 : CRI : Création AVC_CodedReasonForReferralEntries20131030.sch
    17/04/2015 : JDS : Vérification de la présence obligatoire de l'entrée Motif de consultation (code D3-89550) 
                       et de l'entrée Persistance des signes à l'admission (code AVC-170)

    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_CodedReasonForReferral_AVC">

    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.2"]'>
    
        <assert test='.//cda:entry/cda:observation/cda:value/@code="F-A5400"'>
            [S_CodedReasonForReferral_AVC.sch] Erreur de conformité AVC : La latéralité manuelle du patient doit être indiquée
        </assert>
        <assert test='.//cda:entry/cda:observation/cda:value/@code="DA-21100"'>
            [S_CodedReasonForReferral_AVC.sch] Erreur de conformité AVC : L'absence ou la présence de déficits moteurs 
            doit obligatoirement être indiquée
        </assert>
        <assert test='.//cda:entry/cda:observation/cda:value/@code="F-A2200"'>
            [S_CodedReasonForReferral_AVC.sch] Erreur de conformité AVC : L'absence ou la présence de troubles sensitif s
            doit obligatoirement être indiquée
        </assert>
        <assert test='.//cda:entry/cda:observation/cda:value/@code="F-A4580"'>
            [S_CodedReasonForReferral_AVC.sch] Erreur de conformité AVC :L'absence ou la présence d'ataxie
            doit obligatoirement être indiquée
        </assert>
        <assert test='.//cda:entry/cda:observation/cda:value/@code="DA-70080"'>
            [S_CodedReasonForReferral_AVC.sch] Erreur de conformité AVC : L'absence ou la présence de troubles visuels
            doit obligatoirement être indiquée
        </assert>
        

        <assert test='.//cda:entry/cda:observation/cda:value/@code="D3-89550"'>
            [S_CodedReasonForReferral_AVC.sch] Erreur de conformité AVC : Le motif de consultation doit être indiqué
        </assert>
        <assert test='.//cda:entry/cda:observation/cda:value/@code="AVC-170"'>
            [S_CodedReasonForReferral_AVC.sch] Erreur de conformité AVC : La persistance des signes à l'admission doit être indiquée
        </assert>

    </rule>
</pattern>


