<?xml version="1.0" encoding="UTF-8"?>

<!--  Schématron E_product_int.sch -
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entrée 
    PCC Product Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7.2)  
    
    Historique :
    02/08/2011 : CRI : Création
    30/10/2017 : NMA : Renommage du schématron
    07/11/2017 : NMA : Mise à jour du test sur le ManufacturedMaterial
    15/10/2019 : APE : Mise à jour des libellés car cette entrée est utilisée pour les médicaments, les vaccins et les DM.
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_product_int">
    <title>IHE PCC v3.0 Product Entry</title>
       
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2"]'>
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.53"]'>
            [E_product_int] Erreur de Conformité PCC : Le template CCD parent 'Product' (2.16.840.1.113883.10.20.1.53) est obligatoire.</assert>
        
        <assert test='cda:manufacturedMaterial/cda:code[@nullFlavor] 
            or (cda:manufacturedMaterial/cda:code/cda:originalText/cda:reference)'>
            [E_product_int] Erreur de Conformité PCC : Les éléments 'code' et 'originalText/reference' sont obligatoires.
        </assert>

    </rule>
</pattern>
