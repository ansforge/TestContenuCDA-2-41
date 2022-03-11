<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    legalAuthenticator_fr.sch :
    Contenu :
        Contrôle du legalAuthenticator dans l'en-tête CDA  par rapport au volet de structuration minimale
    Paramètres d'appel :
        Néant
    Historique :
        31/05/11 : FMY ASIP/PRAS : Création
   29/04/2019 : NMA : Autorisation du nullFlavor pour l'élément time
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="legalAuthenticator_fr">
    <rule context="cda:ClinicalDocument/cda:legalAuthenticator">
       
        <assert test="cda:time[@value] or cda:time[@nullFlavor]">
            [legalAuthenticator_fr.sch] Erreur de conformité CI-SIS : L'élément legalAuthenticator/time doit être présent avec l'attribut @value ou un attribut nullFlavor
        </assert>
        <assert test="cda:signatureCode[@code='S']">
            [legalAuthenticator_fr.sch] Erreur de conformité CI-SIS : L'élément "signatureCode" doit être présent et contenir l'attribut @code fixé à la valeur 'S'
        </assert>
        <assert test="cda:assignedEntity">
            [legalAuthenticator_fr.sch] Erreur de conformité CI-SIS : L'élément "assignedEntity" doit être présent 
        </assert>       
        <!-- Vérification de l'assignedEntity propre à l'élément legal authenticator -->
        <assert test="cda:assignedEntity/cda:assignedPerson">
            [legalAuthenticator_fr.sch] Erreur de conformité CI-SIS : L'élément "assignedEntity/assignedPerson" doit être présent 
        </assert>
    </rule>
</pattern>   