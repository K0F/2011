import processing.net.*;

Client thisClient;      // client object to connect to servers
String data;            // data string back from HTML request
ArrayList hopList;      // the list of hops
boolean debug = true;  // prints out debugging messages

String destinationAddress = "www.aho.no";    // where you want to traceroute to
boolean responseComplete = false;             // if the server's response is complete


// The rest of the global variables would change if the server changes:

/*
// http://www.tellurian.net/scripts/tools/traceroute.asp

String server = "www.tellurian.net";    // site you're connecting to
// path to the traceroute app interface:
String cgiString = "/scripts/tools/traceroute.asp";    
String method = "POST";                 // HTTP method
String parameters = "Host=";            // parameters of the request

String endHtmlText = "</html>";               // text that ends the HTML string
String traceBeginningText = "Tracing route to:"; // text that starts the trace results
String traceEndText = "</pre>";               // text that ends the trace results
 */

// If you're using this URL, use these settings:
// http://services.truteq.com/cgi-bin/nph-traceroute?facebook.com

String server = "services.truteq.com";    // site you're connecting to
// path to the traceroute app interface:
String cgiString = "/cgi-bin/nph-traceroute";    
String method = "GET";                    // HTTP method
String parameters = "";                   // parameters of the request

String endHtmlText = "</PRE>";            // text that ends the HTML string
String traceBeginningText = "<PRE>";      // text that starts the trace results
String traceEndText = "</PRE>";           // text that ends the trace results


void setup() {
    // make the traceoute call:
    callTraceroute(destinationAddress);
}

void draw() {
    // if the traceroute call is done, kill the client:
    if (responseComplete) {
        thisClient.stop();
        // if there's any data, look in it for the results
        // of the traceroute:
        if (data != null) {
            getTraceLines(data);
            printHopList();
        }
    }
}


// when new data comes in:
void clientEvent(Client someClient) {
    if (someClient.available() > 0) {
        // get the latest byte as a char:
        char newChar =  thisClient.readChar();
        // append it to the data string:
        data += newChar;
        // if the data string contains the end of file tag, close it:
        String[] closingTags = match(data, endHtmlText);
        if (closingTags != null) {
            responseComplete = true; 
        }

    }
}


void callTraceroute(String target) {
    // clear the data string:
    data = "";
    // clear the hop array:
    hopList = new ArrayList();
    // notify user a request is underway: 
    if (debug) println("making request");

    // open the connection to the server on port 80
    thisClient = new Client(this, server, 80);
    // Use the HTTP "GET" command to ask for a Web page
    thisClient.write(method + " " + cgiString);
    if (debug)  print(method + " " + cgiString);
    // if you're doing a GET, parameters follow the CGI string and a ?
    if (method.equals("GET")) {
        thisClient.write("?"+parameters + target);
        if (debug) print("?"+parameters + target);
    }

    thisClient.write(" HTTP/1.1\n"); 
    if (debug) print(" HTTP/1.1\n"); 
    // send the host identifier:
    thisClient.write("HOST: " + server + "\n");
    if (debug) print("HOST: " + server + "\n");

    // if you're doing a GET, finish it here:
    if (method.equals("GET"))  thisClient.write("\n");

    // if you're doing a POST, parameters follow the whole request:
    if (method.equals("POST")) {
        // send the content type line:
        thisClient.write("Content-Type: application/x-www-form-urlencoded\n");
        if (debug) print("Content-Type: application/x-www-form-urlencoded\n");

        // calculate the content length:
        int contentLength = target.length() + parameters.length();
        // send the content length:
        thisClient.write("Content-Length: " + contentLength + "\n\n");
        if (debug) print("Content-Length: " + contentLength + "\n\n");

        // send the parameters:
        thisClient.write(parameters+ target);
        if (debug) print(parameters + target);
    }
    // make debugging pretty:
    if (debug) println();
}

void getTraceLines(String whatData) {
    // get the data, split it on the newlines:
    String[] lines = splitTokens(whatData, "\n");
    String traceRoute = "";        // new string to hold just the trace results
    boolean inTraceResults = false;    // whether you're into the body of the trace results

    // iterate over the lines of the data:
    for (int thisLine = 0; thisLine < lines.length; thisLine++) {

        if (debug) println(lines[thisLine]);

        // if you're in the trace results, save it:
        if (inTraceResults) {
            traceRoute += lines[thisLine];
            // parse this line of the trace:
            parseHop(lines[thisLine]);
        }

        //check for the beginning of the trace:
        String[] stringToCheck = match(lines[thisLine], traceBeginningText);
        if (stringToCheck != null) {
            inTraceResults = true;
            stringToCheck = null;
        }
        //check for the end of the trace:
        stringToCheck = match(lines[thisLine], traceEndText);
        if (stringToCheck != null) {
            inTraceResults = false;
        }
    }
    // make data = null so the draw loop doesn't try to parse it again:
    data = null;
}

/*
   parseHop() and printHopList() are very dependent on how the server
   formats the data.  You'll likely need to rewrite these two in order to
   parse from a different server.

 */
void parseHop(String whatLine) {
    String hopTime = "";
    String hopAddress = "";
    String hopName= "";

    String[] elements = splitTokens(whatLine, " ");
    if (elements.length > 2) {
        hopTime = trim(elements[0]);
        hopAddress = trim(elements[1]);
        hopName = trim(elements[2].substring(1, elements[2].length()-1));

        // make this hop an element of the hopList:
        String[] thisHop = {
            hopTime, hopAddress, hopName                    };
        hopList.add(thisHop);
    }
}

void printHopList() {
    for (int thisHop = 0; thisHop < hopList.size(); thisHop++) {
        String[] nextHop = (String[])hopList.get(thisHop);

        // if you've got all three elements:
        if (nextHop.length > 2) {
            if ((nextHop[0].length() > 2) && (nextHop[0].substring(nextHop[0].length()-2).equals("ms"))) {
                print ("Time: " + nextHop[0]);
                print ("\tHop IP: " + nextHop[1]);
                println("\tHop Name: " + nextHop[2]);
            }
        } 
    }
}

