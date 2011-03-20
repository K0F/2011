import javax.speech.*;
import javax.speech.recognition.*;
import java.io.FileReader;
import java.util.Locale;

Recognizer rec;

void resultAccepted(ResultEvent e) {
		Result r = (Result)(e.getSource());
		ResultToken tokens[] = r.getBestTokens();

		for (int i = 0; i < tokens.length; i++)
			System.out.print(tokens[i].getSpokenText() + " ");
		System.out.println();

		// Deallocate the recognizer and exit
	try{
		rec.deallocate();
	
	}catch (EngineException x){
		println(x);
	}
		System.exit(0);
	}



void setup(){
try {
			// Create a recognizer that supports English.
			rec = Central.createRecognizer(
							new EngineModeDesc(Locale.ENGLISH));
			
			// Start up the recognizer
			rec.allocate();
	 
			// Load the grammar from a file, and enable it
			FileReader reader = new FileReader(args[0]);
			RuleGrammar gram = rec.loadJSGF(reader);
			gram.setEnabled(true);
	
			// Add the listener to get results
			rec.addResultListener(this);
	
			// Commit the grammar
			rec.commitChanges();
	
			// Request focus and start listening
			rec.requestFocus();
			rec.resume();
		} catch (Exception e) {
			e.printStackTrace();
		}



}
