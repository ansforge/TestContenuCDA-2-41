<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    serviceEventLabStatusCode.sch :
    Contenu : contrôle extension XD-LAB serviceEvent/lab:statusCode autorisée uniquement dans CR de biologie ou CR-ACP
    Paramètres d'appel : néant
    Historique :
        08/04/13 : FMA : Création 
        17/03/15 : JDS : Ajout des contraintes sur l'attribut code de l'élément lab:statusCode (obligatoire et valeurs permises) 
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="serviceEventLabStatusCode">
    <p>
        Contrôle d'utilisation à bon escient de l'extension serviceEvent/lab:statusCode autorisée dans les profils XD-LAB, APSR 
    </p>
    <rule context="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/lab:statusCode">
        <assert test="../../../cda:code[@code='11502-2' or @code='11526-1']"> 
            Erreur de conformité CI-SIS : L'extension documentationOf/serviceEvent/lab:statusCode n'est autorisée 
            que dans les CR de biologie ou les CR d'anatomie et de cytologie pathologiques
        </assert>
        <assert test="@code = 'active' or @code = 'completed' "> 
            Erreur de conformité CI-SIS : L'élément documentationOf/serviceEvent/lab:statusCode doit posséder un attribut @code.
        </assert>

        
    </rule>
</pattern>