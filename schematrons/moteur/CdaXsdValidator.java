package com.dmp.validator;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.xml.XMLConstants;
import javax.xml.namespace.NamespaceContext;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Node;
import org.xml.sax.ErrorHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 * Classe de vérification d'un XML par rapport à un schema XSD
 * @author Administrateur
 *
 */
public class CdaXsdValidator {

	private static List<Exception> errorList = new ArrayList<Exception>();
	
	/**
	 * Inner class pour gérer les namespaces lors d'une requete XPATH
	 * @author Administrateur
	 *
	 */
	private static class NamespaceContextProvider implements NamespaceContext {
		private Map map;

		public NamespaceContextProvider() {
			map = new HashMap();
		}

		public void addNamespace(String prefix, String namespaceURI) {
			map.put(prefix, namespaceURI);
		}

		public String getNamespaceURI(String prefix) {

			String uri = (String) map.get(prefix);
			if (uri != null)
				return uri;
			else if (prefix.equals(XMLConstants.XML_NS_PREFIX)) {
				return XMLConstants.XML_NS_URI;
			} else if (prefix.equals(XMLConstants.XMLNS_ATTRIBUTE)) {
				return XMLConstants.XMLNS_ATTRIBUTE_NS_URI;
			} else {
				return XMLConstants.NULL_NS_URI;
			}

		}

		public String getPrefix(String namespaceURI) {
			Set keys = map.keySet();
			for (Iterator iterator = keys.iterator(); iterator.hasNext();) {
				String prefix = (String) iterator.next();
				String uri = (String) map.get(prefix);
				if (uri.equals(namespaceURI))
					return prefix;
			}
			return null;
		}

		public Iterator getPrefixes(String namespaceURI) {
			List prefixes = new ArrayList();
			Set keys = map.keySet();
			for (Iterator iterator = keys.iterator(); iterator.hasNext();) {
				String prefix = (String) iterator.next();
				String uri = (String) map.get(prefix);
				if (uri.equals(namespaceURI))
					prefixes.add(prefix);
			}
			return prefixes.iterator();
		}
	}
	
	
	/**
	 * Retourne le résultat (une liste d'erreur ou OK) au format XML  
	 * @return
	 */
	public static String xmlOutput() {
		StringBuffer buf = new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
		buf.append("<xsd-validation result=\"")
			.append(errorList.size() > 0 ? "ERROR" : "OK")
			.append("\"");
		
		if (errorList.size() > 0) {
			buf.append(" errorCount=\"")
			.append(errorList.size())
			.append("\"");
		}

		buf.append(">\n");
		
		for (int i = 0; i < errorList.size(); i++) {
			
			Exception error = errorList.get(i);

			//erreur de validation xsd
			if (error instanceof SAXParseException) {
				buf.append("<xsd-validation-error errorNumber=\"")
				.append(i+1)
				.append("\" errorType=\"validation")
				.append("\" lineNumber=\"")
				.append(((SAXParseException)error).getLineNumber())
				.append("\" columnNumber=\"")
				.append(((SAXParseException)error).getColumnNumber())
				.append("\">")
				.append(error.getMessage())
				.append("</xsd-validation-error>\n");
			} 
			//erreur de parsing XML ou autre
			else {
				buf.append("<xsd-validation-error errorNumber=\"")
				.append(i+1)
				.append("\" errorType=\"other")
				.append("\">")
				.append(error.getMessage())
				.append("</xsd-validation-error>\n");
			}
		}
		
		buf.append("</xsd-validation>");		
		return buf.toString();
	}
	
	/**
	 * handler des erreurs de validation XSD 
	 */
	private static class MyErrorHandler implements ErrorHandler {
	    public void warning(SAXParseException e) throws SAXException {
	       //warning ignoré
	    }
	    public void error(SAXParseException e) throws SAXException {
	    	errorList.add(e);
	    }
	    public void fatalError(SAXParseException e) throws SAXException {
	    	errorList.add(e);
	    }
	}
	
	/**
	 * valide un CDA par rapport à son shéma XSD
	 * @param schemaFilePath	chemin vers le cda.xsd
	 * @param cdaFilePath	chemin vers le fichier cda 
	 * @return
	 */
	public static void validate(String schemaFilePath, String cdaFilePath) {

		try {
		    // create a SchemaFactory capable of understanding WXS schemas
		    SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
	
		    // load a WXS schema, represented by a Schema instance
		    Source schemaFile = new StreamSource(new File(schemaFilePath));
		    Schema schema = factory.newSchema(schemaFile);
		    
		    //chargement de la partie CDA du XML (le XML peut être un "CDA auto-presentable")
		    InputSource xmlSource = new InputSource(new FileInputStream(cdaFilePath));
			
			//création du XPath pour chercher la racine CDA 
			XPath xpath = XPathFactory.newInstance().newXPath();
			CdaXsdValidator.NamespaceContextProvider nsContext = new CdaXsdValidator.NamespaceContextProvider();
			nsContext.addNamespace("h", "urn:hl7-org:v3");
			xpath.setNamespaceContext(nsContext);
			Node cdaNode = (Node) xpath.evaluate("//h:ClinicalDocument",xmlSource,XPathConstants.NODE);

		    if (cdaNode == null)
		    	throw new Exception("Noeud racine du CDA (ClinicalDocument) non trouve dans le XML fourni");//pas très joli / à adapter poru générer une exception csutom
			
		    // create a Validator instance, which can be used to validate an instance document
		    Validator validator = schema.newValidator();

		    // errorhandler pour récupérer l'ensemble des erreurs de validation par rapport au schéma
		    validator.setErrorHandler(new MyErrorHandler());
		    
		    // validate the DOM tree
		    try {
		    	//transforme le noeud CDA en StreamSource pour la validation XmlSchema:
		    	ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		    	StreamResult outputTarget = new StreamResult(outputStream);
		    	Transformer t = TransformerFactory.newInstance().newTransformer();
		    	t.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
		    	t.transform(new DOMSource(cdaNode), (javax.xml.transform.Result) outputTarget);
		    	StreamSource src = new StreamSource(new ByteArrayInputStream(outputStream.toByteArray()));
		    	
		    	//validation XmlSchema
		    	validator.validate(src);
		        
		    } catch (SAXException e) {
		    	errorList.add(e);
		    }
		}
	    catch (Exception e) {
	    	errorList.add(e);
	    }
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		if (args.length < 2) {
			System.out.println("paramètres manquants : <path_to_cda.xml> <path_to_schema_cda.xsd>");
			System.exit(0);
		} else {
			validate(args[1], args[0]);
			try {
				System.out.write(xmlOutput().getBytes("UTF-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
}
