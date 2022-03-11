<?xml version="1.0" encoding="UTF-8"?>

<!-- E_comments_int.sch
    
    Vérification de la conformité de l'entrée FR-Commentaire-ER (comments - 1.3.6.1.4.1.19376.1.5.3.1.4.2)
    
    25/07/11 : Création
    30/10/17 : Ajout du test de présence de l'élément text
    01/12/20 : Renommé
    
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_comments_int">
    
        <title>IHE PCC Comments</title>
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.2"]'>
            
            <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.40"]'>
                [E_comments_int] Erreur de Conformité PCC: Le templateId CCD (2.16.840.1.113883.10.20.1.40) de l'entrée
                Comments doit être déclaré.
            </assert>
            
            <assert test='cda:code[@code="48767-8" and
                @codeSystem="2.16.840.1.113883.6.1"]'>
                [E_comments_int] Erreur de Conformité PCC: L'élément "code" pour l'entrée "Comments" est requis. Ses attributs "code" et "codeSystem"
                sont obligatoires (cf. CI-SIS Volet de contenu CDA).
            </assert>
            
            <assert test='cda:statusCode[@code = "completed"]'>
                [E_comments_int] Erreur de Conformité PCC: La valeur de l'élément "code" de "statusCode" est toujours fixée à "completed". 
            </assert>
            
            <assert test='not(cda:author) or (
                cda:author/cda:time and
                cda:author/cda:assignedAuthor/cda:id and
                cda:author/cda:assignedAuthor/cda:addr and
                cda:author/cda:assignedAuthor/cda:telecom and
                cda:author/cda:assignedAuthor/cda:assignedPerson/cda:name and
                cda:author/cda:assignedAuthor/cda:representedOrganization/cda:name)'>
                [E_comments_int] Erreur de Conformité PCC: Un élément "Comment" peut avoir un auteur.
                L'horodatage de la création de l'élément "Comment" est réalisé à partir de l'élément "time" lorsque l'élément "author" est présent.
                L'identifiant de l'auteur (id), son adresse (addr) et son numéro de téléphone (telecom) sont dans ce cas obligatoires. 
                Le nom de l'auteur et/ou celui de l'organisation qu'il représente doit être présent.
            </assert>

            <assert test='cda:text'>
                [E_comments_int] Erreur de Conformité PCC (Alerte): L'élément "observation" d'une entrée "Comments" contiendra un composant "text"
                Celui-ci contiendra un élément "reference" qui pointera sur la partie narrative où est notifiée le commentaire, plutôt 
                que de dupliquer ce texte.
            </assert>
            
        </rule>
</pattern>