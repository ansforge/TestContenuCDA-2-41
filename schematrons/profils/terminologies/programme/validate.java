import com.helger.schematron.pure.SchematronResourcePure; 
import com.helger.schematron.sch.SchematronResourceSCH;
import com.helger.schematron.*;
import com.helger.schematron.pure.model.*;
import com.helger.schematron.pure.exchange.PSReader;
import com.helger.schematron.pure.errorhandler.IPSErrorHandler;
import com.helger.commons.io.resource.FileSystemResource;
import com.helger.schematron.pure.errorhandler.DoNothingPSErrorHandler;
import com.helger.schematron.pure.binding.IPSQueryBinding;
import com.helger.schematron.pure.binding.PSQueryBindingRegistry;
import com.helger.schematron.pure.preprocess.PSPreprocessor;
import com.helger.xml.serialize.read.DOMReader;
import com.helger.schematron.pure.bound.IPSBoundSchema;
import com.helger.commons.io.file.FileHelper;
import java.text.SimpleDateFormat;  
import java.util.Date;  
import java.io.File;
import java.io.FileInputStream;
import java.io.*;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.URL;
import javax.xml.transform.stream.StreamSource;
import org.w3c.dom.*;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.Transformer;


import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.Option.Builder;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.ParseException;
	
public class validate {
    public static void main(String[] args) throws Exception  {
	
	//fichier schematron outsvrl xsl  
        CommandLine commandLine;
        Option option_i = Option.builder("i")
            .required(true)
			.hasArg(true) 
            .desc("Fichier CDA ou JDV à vérifier")
            .longOpt("input")
            .build();
			
        Option option_s = Option.builder("s")
            .required(true)
			.hasArg(true) 
            .desc("schematron")
            .longOpt("shematron")
            .build();			
			
        Option option_o = Option.builder("o")
            .required(true)
			.hasArg(true) 
            .desc("Ouput de la validation")
            .longOpt("output")
            .build();					
			
			
        Option option_xsl = Option.builder("xsl")
            .required(false)
			.hasArg(true) 
            .desc("xsl pour parser le réusltat")
            .longOpt("xsl")
            .build();

        Option option_oxsl = Option.builder("outputxsl")
            .required(false)
			.hasArg(true) 
            .desc("Résulat de la validation XSL")
            .longOpt("outputxsl")
            .build();
			
			
			
        Options options = new Options();
        CommandLineParser parser = new DefaultParser();
		

        options.addOption(option_i);
        options.addOption(option_s);		
        options.addOption(option_o);		
        options.addOption(option_xsl);		
        options.addOption(option_oxsl);
		
		
        try
        {
            commandLine = parser.parse(options, args);

			
	String fileShematron = commandLine.getOptionValue("s");
	File fCda = new File(commandLine.getOptionValue("i"));
	FileOutputStream outStream = new FileOutputStream(commandLine.getOptionValue("o")); 
	
	//Mode pure à true 
	boolean modePure = false;
	final ISchematronResource aResPure;
	if(modePure)
		 aResPure = SchematronResourcePure.fromFile (fileShematron);
	else 		
		 aResPure = SchematronResourceSCH.fromFile (fileShematron);
	if(!aResPure.isValidSchematron ())
		throw new IllegalArgumentException ("Invalid Schematron!");
	
	final Document aDoc =  aResPure.applySchematronValidation (new StreamSource (fCda)); 
	 
	//Validation et écriture du fichier
	TransformerFactory tf = TransformerFactory.newInstance();
	Transformer transformer;
	transformer = tf.newTransformer();
	transformer.transform(new DOMSource(aDoc), new StreamResult(outStream));


	//Parsing XSl si les options sont présentes
	if (commandLine.hasOption("xsl")&& commandLine.hasOption("outputxsl")){
		final Source xmlSource = new javax.xml.transform.stream.StreamSource(commandLine.getOptionValue("o"));
		final Source xsltSource = new javax.xml.transform.stream.StreamSource(commandLine.getOptionValue("xsl"));
		final Result result = new javax.xml.transform.stream.StreamResult(commandLine.getOptionValue("outputxsl"));

		TransformerFactory tFactory = TransformerFactory.newInstance();
		transformer = tf.newTransformer(xsltSource);
		transformer.setParameter("title",fCda.getName()); 
		transformer.transform(xmlSource, result);
	}
			 

        }
        catch (ParseException exception)
        {
            System.out.print("Parse error: ");
            System.out.println(exception.getMessage());
        }
		

		
		//C:\Users\mpriour\Documents\jdk-15.0.1_windows-x64_bin\jdk-15.0.1\bin\java  -cp ./* validate.java -i  c:\\Users\\mpriour\\Documents\\validation\\testContenuCDA_20210126_V2.29\\CR-BIO_v2.0_Chikungunya.XML -s schematron\terminologie.sch -o output/CR-bio.svrl  -xsl schematron/svrl-to-html.xsl -outputxsl outpu/crbio.html
		
	}
}