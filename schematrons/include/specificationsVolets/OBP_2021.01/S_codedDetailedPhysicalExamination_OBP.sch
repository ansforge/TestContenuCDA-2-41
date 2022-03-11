<?xml version="1.0" encoding="UTF-8"?>

<!--                 
    S_CodedDetailedPhysicalExamination_OPB.sch
    test la conformité de la section code detailed examination en fonction du volet obstétrique
    
    Historique :
    10/07/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_CodedDetailedPhysicalExamination_OPB.sch">
    <title>IHE PCC Coded Detailed Physical Examination</title>

    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1"]'> 
      
         <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.9.20"]'> 
            <!-- Note any missing optional elements -->
                    [S_CodedDetailedPhysicalExamination_OPB.sch] : Erreur de conformité au volet Obstétrique : Cette section doit contenir une sous-section 'Examen ORL'.
        </assert>
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.9.37"]'> 
            <!-- Note any missing optional elements -->
                    [S_CodedDetailedPhysicalExamination_OPB.sch] : Erreur de conformité au volet Obstétrique : Cette section doit contenir une sous-section ' Examen du rectum'.
        </assert>
    </rule> 
        
    </pattern>