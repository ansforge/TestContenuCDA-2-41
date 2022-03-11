<?xml version="1.0" encoding="UTF-8"?>

<!-- E_produitDeSantePrescrit_int 
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Produit-de-sante-prescrit (IHE PHARM PRE - Prescription-Item -1.3.6.1.4.1.19376.1.9.1.3.2) à IHE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_produitDeSantePrescrit_int">
        <title>IHE PHARM PRE "Prescription-Item"</title>        
    
        <rule context="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable">   
            
            <!-- Test des templateId pour l'entrée "Medicine Entry Content Module" -->
            <assert test="cda:manufacturedProduct/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2']">
                [1] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Produit-de-sante-prescrit doit avoir un 'templateId' dont l'attribut @root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2".
            </assert>
            
            <assert test="cda:manufacturedProduct/cda:templateId[@root='2.16.840.1.113883.10.20.1.53']">
                [2] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Produit-de-sante-prescrit doit avoir un 'templateId' dont l'attribut @root="2.16.840.1.113883.10.20.1.53".
            </assert>        
            
            <!-- Test du format et de la présence de l'élément 'manufacturedMaterial' -->
            <assert test="cda:manufacturedProduct/cda:manufacturedMaterial[@classCode='MMAT' and @determinerCode='KIND']">
                [3] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'entrée FR-Produit-de-sante-prescrit doit comporter un élément 'manufacturedMaterial' avec les attributs :
                - @xmlns:pharm="urn:ihe:pharm"
                - @classCode="MMAT"
                - @determinerCode="KIND"
            </assert>
            
        </rule>
    
        <rule context="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial">
            
            <!-- Count de l'élémént 'pharm:formCode' -->
            <let name="count_formCode" value="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:formCode)"/>
            <!-- Count de l'élémént 'lotNumberText' -->
            <let name="count_lotNumberText" value="count(//cda:manufacturedProduct/cda:manufacturedMaterial/cda:lotNumberText)"/>    
            <!-- Count de l'élémént 'pharm:expirationTime' -->
            <let name="count_expirationTime" value="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:expirationTime)"/>
            <!-- Count de l'élémént 'pharm:asContent' -->
            <let name="count_asContent" value="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:asContent[@classCode='CONT'])"/>
            <!-- Count de l'élémént 'pharm:asSpecializedKind' -->
            <let name="count_asSpecializedKind" value="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:asSpecializedKind[@classCode='GRIC'])"/>
            <!-- Count de l'élémént 'pharm:ingredient' -->
            <let name="count_ingredient" value="count(//cda:manufacturedProduct/cda:manufacturedMaterial/pharm:ingredient[@classCode='ACTI'])"/>
    
            <!-- Test présence du templateId situé sous le 'manufacturedMaterial' -->
            <assert test="//cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.1']">
                [4] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'manufacturedMaterial' doit avoir un templateId dont l'attribut @root="1.3.6.1.4.1.19376.1.9.1.3.1" (cardinalité [1..1]).
            </assert>
           
            <!-- Test de la présence et du format de l'élément 'code' -->
            <assert test="(//cda:code[@codeSystem]) or (//cda:code[@nullFlavor='NA'])">
                [5] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                - Si le médicament est codé, alors le code doit provenir d'une terminologie (ATC, CIP, CIS, ...).
                - Si le médicament n'est pas codé (ex : préparations magistrales, médecine composée, ...), alors l'attribut @nullFlavor="NA" DOIT être utilisé.
            </assert>
            
            <!-- Test de la présence de l'élément 'name' -->
            <assert test="//cda:name">
                [6] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément 'name' dans le 'manufacturedMaterial' est obligatoire (cardinalité [1..1]).
            </assert>
            
            <!-- Test du nombre max de 'pharm:formCode' -->
            <assert test="(($count_formCode =1) or ($count_formCode =0))">
                [7] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:formCode' ne peut être présent plus d'une fois (cardinalité [0..1])
            </assert>
            
            <!-- Test du nombre max de 'pharm:lotNumberText' -->
            <assert test="(($count_lotNumberText =1) or ($count_lotNumberText =0))">
                [8] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:lotNumberText' ne peut être présent plus d'une fois (cardinalité [0..1])
            </assert>
            
            <!-- Test du nombre max de 'pharm:expirationTime' -->
            <assert test="(($count_expirationTime =1) or ($count_expirationTime =0))">
                [9] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:expirationTime' ne peut être présent plus d'une fois (cardinalité [0..1])
            </assert>
            
            <!-- Test de la présence potentielle et du format de 'pharm:asContent' si présent -->
            <assert test="(($count_asContent =1) or ($count_asContent=0))">
                [10] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:asContent' ne peut être présent plus d'une fois (cardinalité [0..1]) et son attribut @classCode="CONT".
            </assert>
            
            <!-- Test de la présence potentielle et du format de 'pharm:asSpecializedKind' si présent -->
            <assert test="(($count_asSpecializedKind &gt;=1) or ($count_asSpecializedKind=0))">
                [11] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:asSpecializedKind', si présent, doit avoir son attribut @classCode="GRIC" (cardinalité [0..*]).
            </assert>
            
            <!-- Test de la présence potentielle et du format de 'pharm:ingredient' si présent -->
            <assert test="(($count_ingredient &gt;=1) or ($count_ingredient=0))">
                [12] [E_ProduitDeSantePrescrit_int.sch] Erreur de conformité IHE Pharm PRE : 
                L'élément optionnel 'pharm:ingredient', si présent, doit avoir son attribut @classCode="ACTI" (cardinalité [0..*]).
            </assert>
    
        </rule>        
    </pattern>
