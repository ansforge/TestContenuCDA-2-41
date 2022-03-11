<?xml version="1.0" encoding="UTF-8"?>

<!-- E_dispositifMedicalImplante_ANS.sch
    
     Vérification de la conformité de l'entrée "Dispositif Médical Implanté" (1.2.250.1.213.1.1.3.2) créée par l'ANS
     (Ancienne version - ne plus utiliser cette entrée)
    
    Historique :
    03/07/2017 : Création
    25/07/2019 : Les entrées Dispositif médical – complément (Entrée spécifique ASIP - 1.2.250.1.213.1.1.3.1) ne sont plus obligatoires. 
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_dispositifMedicalImplante_ANS">
   <title>Vérification de la conformité de l'entrée "Dispositif Médical Implanté" (1.2.250.1.213.1.1.3.2) créée par l'ANS</title>
   <rule context="*[cda:templateId/@root=&quot;1.2.250.1.213.1.1.3.2&quot;]">
      
      <assert test='@classCode="CLUSTER" and @moodCode="EVN"'>
         [E_dispositifMedicalImplante_ANS]: Erreur de conformité CI-SIS : L'élément 'organizer' doit comporter les attributs suivants : classCode="CLUSTER" et moodCode="EVN"
      </assert>
      
      <assert test='count(cda:templateId[@root="1.2.250.1.213.1.1.3.2"])=1'>
         [E_dispositifMedicalImplante_ANS]: Erreur de conformité CI-SIS : L'élément 'organizer' doit comporter un élément 'templateId' avec un attribut root='1.2.250.1.213.1.1.3.2'
      </assert>
      
      <assert test='count(cda:id)=1'>
         [E_dispositifMedicalImplante_ANS]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un élément "id".
      </assert>

      <assert test='count(cda:code)=1'>
         [E_dispositifMedicalImplante_ANS]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" ne doit comporter qu'un seul élément "code".
      </assert>
      
      <assert test="count(cda:statusCode)=1"> 
         [E_dispositifMedicalImplante_ANS] Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un élément "statutCode".
      </assert>

      <!-- Les entrées Dispositif médical – complément (Entrée spécifique ASIP - 1.2.250.1.213.1.1.3.1) ne sont plus obligatoires.
      <assert test="count(cda:component/cda:observation[cda:templateId[@root='1.2.250.1.213.1.1.3.1']]/cda:code[@code='L0056'])=1"> 
         [E_dispositifMedicalImplante_ANS] Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un component qui décrit le type du matériel implanté.
         Ce component est de type "Dispositif médical - Complément" avec un code="L0056"</assert>
      
      <assert test="count(cda:component/cda:observation[cda:templateId[@root='1.2.250.1.213.1.1.3.1']]/cda:code[@code='L0055'])=1"> 
         [E_dispositifMedicalImplante_ANS] Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un component qui décrit la date d'implantation.
         Ce component est de type "Dispositif médical - Complément" avec un code="L0055"</assert>
      -->
      
    </rule>
</pattern>
