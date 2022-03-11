<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:hl7="urn:hl7-org:v3" xmlns:sch="http://purl.oclc.org/dsdl/schematron" 
	xmlns:local="http://art-decor.org/functions" queryBinding="xslt2">
    <title>Verification sémantique</title>
    <ns uri="urn:hl7-org:v3" prefix="hl7"/>
    <ns uri="urn:hl7-org:v3" prefix="cda"/>
    <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
    <ns uri="urn:oid:1.3.6.1.4.1.19376.1.3.2" prefix="lab"/>
    <ns uri="http://www.w3.org/XML/1998/namespace" prefix="xml"/>
    <ns uri="urn:ihe:pharm" prefix="pharm"/>
    <ns uri="urn:hl7-org:sdtc" prefix="sdtc"/>
	<ns prefix="rdf" uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
	<ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
	<ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

    <pattern>
									
        <title>Verification sémantique</title>

		<!--Chemin vers le repertoire des terminologie-->
		<let name="path_terminologie" value="'../terminologie/'"/>
    	
		<!--Régle abstraite qui verifie l'exitance d'un code dans la terminologie-->
		<rule abstract="true" id="is-code-exist">
			<let name="theCode" value="@code"/>
			<let name="theNameCode" value="@displayName"/>
			<let name="theCodeSystem" value="@codeSystem"/>
			<let name="theCodeSystemName" value="@codeSystemName"/>
			 <assert role="error"  test="not (doc-available(concat($path_terminologie, $theCodeSystem,'.rdf')) and not(exists(doc(concat($path_terminologie, $theCodeSystem,'.rdf') )//skos:notation[text()= string($theCode)])))">
			  CodeSystem : "<value-of select="$theCodeSystem"/>" 
			  CodeSystemName : "<value-of select="$theCodeSystemName"/>" 
			  Code  : "<value-of select="$theCode"/>"
			  DisplayName : <value-of select="$theNameCode"/>
			  Ce code n'est pas retrouvé dans la terminologie
			 </assert>
		</rule>	
		
		<!--Régle abstraite qui verifie l'exitance d'un code dans UCUM-->
		<rule abstract="true" id="is-code-ucum-exist">
			<let name="theUnit" value="@unit"/>
			<let name="theUnitTransform" value="replace(@unit, '\{.[a-z]*.\}', '')"/>
			
			 <assert role="error"  test="not(($theUnitTransform != '') and not(exists(doc(concat($path_terminologie, 'ucum.xml') )//code[text()= string($theUnitTransform) ])))">
			  Code  : "<value-of select="$theUnit"/>" (Avant transformation : "<value-of select="$theUnitTransform"/>")
			  Ce code n'est pas dans UCUM
			 </assert>
		</rule>
		
		
		<!--Document CDA : Verification sur la balise "code"-->
		<rule context="//hl7:code">
			<sch:extends rule="is-code-exist"/>
		</rule>
		
		
		<!--Document CDA :  Verification sur la balise "value" avec l'attribut type "CD" ou "CE"-->
		<rule context="//hl7:value[@xsi:type='CD' or  @xsi:type='CE']">
			<sch:extends rule="is-code-exist"/>
		</rule>
		
		<!--Document JDV : Verification sur la balise "Concept"-->
		<rule context="//svs:Concept">
			<sch:extends rule="is-code-exist"/>
		</rule>
		
		
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:value[@xsi:type='PQ']">
		    <sch:extends rule="is-code-ucum-exist"/>
		</rule>
		    	
		<!--Document CDA : Verification sur la balise "value" d'un autoprésentable pour UCUM -->
		<rule context="//hl7:value[@xsi:type='c:PQ']">
		    <sch:extends rule="is-code-ucum-exist"/>
		</rule>
		    	
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:value[@xsi:type='IVL_PQ']/hl7:low">
			<sch:extends rule="is-code-ucum-exist"/>
		</rule>
		    	
		<!--Document CDA : Verification sur la balise "value" d'un autoprésentable pour UCUM -->
		<rule context="//hl7:value[@xsi:type='c:IVL_PQ']/hl7:low">
		    <sch:extends rule="is-code-ucum-exist"/>
		</rule>
			
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:value[@xsi:type='IVL_PQ']/hl7:high">
			<sch:extends rule="is-code-ucum-exist"/>
		</rule>
		
		<!--Document CDA : Verification sur la balise "value" d'un autoprésentable  pour UCUM -->
		<rule context="//hl7:value[@xsi:type='c:IVL_PQ']/hl7:high">
		    <sch:extends rule="is-code-ucum-exist"/>
		</rule>
		    	
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:substanceAdministration//hl7:doseQuantity/hl7:low">
			<sch:extends rule="is-code-ucum-exist"/>
		</rule>
		
		
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:substanceAdministration//hl7:doseQuantity/hl7:high">
			<sch:extends rule="is-code-ucum-exist"/>
		</rule>
		
		
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:substanceAdministration//hl7:rateQuantity/hl7:low">
			<sch:extends rule="is-code-ucum-exist"/>
		</rule>
		
		
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:substanceAdministration//hl7:rateQuantity/hl7:high">
			<sch:extends rule="is-code-ucum-exist"/>
		</rule>
		
		
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:substanceAdministration//hl7:maxDoseQuanity/hl7:low">
			<sch:extends rule="is-code-ucum-exist"/>
		</rule>
		
		
		<!--Document CDA : Verification sur la balise "value" pour UCUM -->
		<rule context="//hl7:substanceAdministration//hl7:maxDoseQuanity/hl7:high">
			<sch:extends rule="is-code-ucum-exist"/>
		</rule>

    </pattern>

</schema>