<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    E_transport_fr.sch
    Test la conformité de l'entrée transport (1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1) en fonction du CI-SIS
       
    27/06/2017 : LBE : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_transport_fr">

    <title>IHE PCC v3.0 transport</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1"]'>
        <let name="count_Id" value="count(cda:id)"/>
      
        
      <assert test="$count_Id = 1">
          [E_transport_fr.sch] Erreur de conformité CI-SIS : L'élément transport ne doit avoir qu'un seul id (cardinalité [1..1])
      </assert>  
       
      <assert test="cda:effectiveTime/cda:low[@value] and cda:effectiveTime/cda:high[@value]">
          [E_transport_fr.sch] Erreur de conformité CI-SIS : L'élément transport doit avoir un élément effectiveTime/low avec un attribut @value et un élément effectiveTime/high avec un attribut @value
      </assert> 
    
    </rule>
</pattern>
