<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_birthEventOrganizer_fr.sch ]O@%#o>>=-
    
    Teste la conformité des entrées de la section "Birth Event Organizer" (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2)
    aux spécifications du CI-SIS
    
    Historique :
    03/07/2017 : NMA : Création E_birthEventOrganizer_fr.sch
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_birthEventOrganizer_fr">
  
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2"]'>  

        <assert test="count(cda:id)=1">
            [E_birthEventOrganizer_fr] Erreur de conformité CI-SIS : Dans l'élément "Birth Event Organizer", un seul élément "id" doit être présent
        </assert>
       
        <assert test="cda:code[@codeSystem='1.2.250.1.213.2.12']">
            [E_birthEventOrganizer_fr] Erreur de conformité CI-SIS : Dans l'élément "Birth Event Organizer", le code doit être codé en SNOMED 3.5
        </assert>
        
        <assert test="cda:statusCode[@code='completed']"> 
            [E_birthEventOrganizer_fr] Erreur de conformité CI-SIS : L'élément statusCode d'un "Birth Event Organizer" sera donc toujours fixé à la valeur code='completed'. </assert>
        
        <assert test="count(cda:subject)=1">
            [E_birthEventOrganizer_fr] : Un organizer "Birth Event Organizer" ne doit contenir qu'un seul élément "subject" pour décrire le nouveau né
        </assert>
       
        <assert test="count(cda:subject/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.15.2'])=1">
            [E_birthEventOrganizer_fr] : Le templateId du sujet doit être '1.3.6.1.4.1.19376.1.5.3.1.4.15.2' et ne peut être présent qu'une seule fois
        </assert>
        
        <assert test="count(cda:subject/cda:relatedSubject/cda:code)=1">
            [E_birthEventOrganizer_fr] : L'élément relatedSubject du sujet doit obligatoirement contenir un code
        </assert>
        
        <assert test="count(cda:subject/cda:relatedSubject/cda:subject)=1">
            [E_birthEventOrganizer_fr] : L'élément relatedSubject du sujet doit obligatoirement contenir un élément 'subject' qui groupera les caractéristiques du nouveau né
        </assert>

        <assert test="count(cda:subject/cda:relatedSubject/cda:subject/cda:administrativeGenderCode)=1">
            [E_birthEventOrganizer_fr] : Le sexe du nouveau né doit obligatoirement être présent
        </assert>
        
        <assert test="count(cda:subject/cda:relatedSubject/cda:subject/cda:birthTime)=1">
            [E_birthEventOrganizer_fr] : La date de naissance du nouveau né doit obligatoirement être présente
        </assert>
                
    </rule>
</pattern>