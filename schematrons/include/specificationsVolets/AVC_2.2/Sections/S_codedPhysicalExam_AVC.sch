<?xml version="1.0" encoding="UTF-8"?>



<!--                  -=<<o#%@O[ AVCcodedPhysicalExam.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Coded Physical Exam" (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1)
    aux spécifications du volet AVC AUNV    du CI-SIS de l'ASIP Santé 
    concernant le contenu de la section.    
    Sont rendues obligatoires les sous-sections suivantes:
    - Signes Vitaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2) 
    - Examen Neurologique (1.3.6.1.4.1.19376.1.5.3.1.1.9.35)
    - Examen cardiovasculaire (1.3.6.1.4.1.19376.1.5.3.1.1.9.29)
    - Examen Pulmonaire  (1.3.6.1.4.1.19376.1.5.3.1.1.9.26)
    
    Historique :
    15/04/2015 : JDS : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedPhysicalExam_AVC">
    <title>ASIP CI-SIS AVC AUNV Physical Exam Section</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1"]'> 
       
        <!-- Signes Vitaux -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2"]'>
          [S_codedPhysicalExam.sch] Erreur de Conformité au volet AVC: La section 'Coded physical exam' ne contient pas de sous-section'Coded Vital Signs'.
        </assert>
        <!-- Examen Neurologique -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.35"]'>
            [S_codedPhysicalExam.sch]  Erreur de Conformité au volet AVC: La section 'Coded physical exam' ne contient pas de sous-section'Examen Neurologique'.
        </assert>
        <!-- Examen cardiovasculaire -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.29"]'>
            [S_codedPhysicalExam.sch]  Erreur de Conformité au volet AVC: La section 'Coded physical exam' ne contient pas de sous-section 'Examen cardiovasculaire'.
        </assert> 
        <!-- Examen Pulmonaire  -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.1.9.26"]'>
            [S_codedPhysicalExam.sch]  Erreur de Conformité au volet AVC: La section 'Coded physical exam' ne contient pas de sous-section 'Examen Pulmonaire'.
        </assert> 
    </rule>
</pattern>