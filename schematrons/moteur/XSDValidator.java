//package com.dmp.validator;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.XMLConstants;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 * Classe de vérification d'un XML par rapport à un schema XSD
 * @author Administrateur
 *
 */
public class XSDValidator {

	private static List<Exception> errorList = new ArrayList<Exception>();
	
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
		   //errorList.add(e);
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
	
		    // create a Validator instance, which can be used to validate an instance document
		    Validator validator = schema.newValidator();

		    // errorhandler pour récupérer l'ensemble des erreurs de validation par rapport au schéma
		    validator.setErrorHandler(new MyErrorHandler());
		    
		    // validate the DOM tree
		    try {
		        validator.validate(new StreamSource(new File(cdaFilePath)));
		        
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
