<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    E_transport_int.sch
    Test la conformité de l'entrée transport (1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1) en fonction du profil IHE PCC
       
    27/06/2017 : LBE : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_transport_int">

    <title>IHE PCC v3.0 transport</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.10.4.1"]'>
      <assert test="@classCode='ACT' and (@moodCode='INT' or @moodCode='EVN')">
          [E_transport_int.sch] Erreur de conformité PCC : L'élément transport act doit avoir un attribut @classCode fixé à 'ACT' et un attribut @moodCode prenant les valeurs 'INT' ou 'EVN'
      </assert>
       
       <assert test="cda:id[@root]">
           [E_transport_int.sch] Erreur de conformité PCC : L'élément transport doit avoir au moins un élément id
       </assert>
        
        <assert test="cda:effectiveTime">
            [E_transport_int.sch] Erreur de conformité PCC : L'élément transport doit contenir un élément effectiveTime
        </assert>
        <assert test="cda:effectiveTime/cda:low[@value] or cda:effectiveTime/cda:high[@value]">
            [E_transport_int.sch] Erreur de conformité PCC : L'élément effectiveTime doit contenir un élément low et/ou un élément high avec l'attribut @value
        </assert>
        
        
    </rule>
</pattern>
