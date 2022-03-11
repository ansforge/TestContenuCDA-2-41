<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    authenticator_fr.sch :
    Contenu :
        Contrôle de l'élément d'entête authenticator en fonction du volet de structuration minimale 
    Paramètres d'appel :
        Néant
    Historique :
       16/06/2017 : LBE : Création
   29/04/2019 : NMA : Autorisation du nullFlavor pour l'élément time
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="authenticator_fr">
    <rule context="cda:authenticator">
        <assert test="cda:time[@value] or cda:time[@nullFlavor]">
           [authenticator_fr.sch] Erreur de conformité CI-SIS :  L'élément time doit contenir l'attribut @value ou un attribut nullFlavor
        </assert>
        <assert test="cda:signatureCode[@code='S']"> 
            [authenticator] Erreur de conformité CI-SIS : L'élément code doit contenir l'attribut @code fixé à la valeur 'S' (pour signed)
        </assert>
    </rule>
</pattern>
